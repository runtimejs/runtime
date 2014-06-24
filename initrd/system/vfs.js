// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

var vfs = (function() {
    "use strict";

    function createFsInitrd(initrdFiles) {
        var rootInode = 1;

        var allocInodes = {};
        var allocInodeNext = rootInode + 1;
        var inodesGraphAdj = new Map();

        for (var i = 0; i < initrdFiles.length; ++i) {
            var pathComponents = parsePathString(initrdFiles[i]);
            var dirInode = rootInode;

            for (var j = 0; j < pathComponents.length; ++j) {
                var parentInode = dirInode;

                var component = pathComponents[j];
                var key = '$' + component + '_' + j;

                if ('undefined' === typeof allocInodes[key]) {
                    dirInode = allocInodeNext++;
                    allocInodes[key] = dirInode;
                } else {
                    dirInode = allocInodes[key];
                }

                var inodeMap = inodesGraphAdj.get(parentInode);
                if ('undefined' === typeof inodeMap) {
                    inodeMap = new Map();
                    inodesGraphAdj.set(parentInode, inodeMap);
                }

                inodeMap.set(component, dirInode);
            }
        }

        return {
            lookup: function(inode, name, resolve) {
                var inodeMap = inodesGraphAdj.get(inode);
                if ('undefined' === typeof inodeMap) {
                    resolve(0);
                    return;
                }

                var resultInode = inodeMap.get(name);
                if ('undefined' === typeof resultInode) {
                    resolve(0);
                    return;
                }

                resolve(resultInode);
            },
            list: function(inode, resolve) {
                var inodeMap = inodesGraphAdj.get(inode);
                if ('undefined' === typeof inodeMap) {
                    resolve(0);
                    return;
                }

                resolve(inodeMap);
            },
            getRootInode: function() {
                return rootInode;
            },
        };
    }

    function createFsRoot() {
        var rootInode = 1;
        var rootEntries = new Map();
        rootEntries.set('initrd', 2);

        return {
            /**
             * Lookup child directory of inode. Returns inode as result
             */
            lookup: function(inode, name, resolve) {
                var resultInode = rootEntries.get(name);
                if ('undefined' === typeof resultInode) {
                    resolve(0);
                    return;
                }

                resolve(resultInode);
            },
            /**
             * List child directiories. Returns map (name -> inode)
             */
            list: function(inode, resolve) {
                resolve(rootEntries);
                return;
            },
            getRootInode: function() {
                return rootInode;
            },
        };
    }

    function parsePathString(str) {
        return str.split('/').filter(function(x) {
            return '' !== x;
        });
    }

    function VFSNode(fs, inode, name) {
        this.fs = fs;
        this.inode = inode;
        this.name = name;
        this.lookupCache = null;
        this.listCached = false;
        this.mountedNode = null;
    }

    VFSNode.prototype.lookup = function(name, resolve) {
        var self = this;

        if (null !== self.mountedNode) {
            self = self.mountedNode;
        }

        if (self.lookupCache) {
            var vfsnode = self.lookupCache.get(name);

            if (vfsnode instanceof VFSNode) {
                resolve(vfsnode);
                return;
            }
        }

        self.fs.lookup(self.inode, name, function(inode) {
            if (!inode) {
                resolve(null);
                return
            }

            var vfsnode = new VFSNode(self.fs, inode, name);

            if (null === self.lookupCache) {
                self.lookupCache = new Map();
            }

            self.lookupCache.set(name, vfsnode);
            resolve(vfsnode);
        });
    };

    VFSNode.prototype.list = function(resolve) {
        var self = this;

        if (null !== self.mountedNode) {
            self = self.mountedNode;
        }

        if (self.lookupCache && self.listCached) {
            var list = [];
            self.lookupCache.forEach(function(vfsnode) {
                list.push(vfsnode);
            });

            resolve(list);
            return;
        }

        self.fs.list(self.inode, function(inodeMap) {
            var result = [];

            if (null === self.lookupCache) {
                self.lookupCache = new Map();
            }

            inodeMap.forEach(function(inode, name) {
                var vfsnode = self.lookupCache.get(name);

                if (!(vfsnode instanceof VFSNode)) {
                    vfsnode = new VFSNode(self.fs, inode, name);
                    self.lookupCache.set(name, vfsnode);
                }

                result.push(vfsnode);
            });

            self.listCached = true;
            resolve(result);
        });
    };

    VFSNode.prototype.mount = function(vfsnode) {
        var self = this;

        if (!(vfsnode instanceof VFSNode)) {
            throw new Error('vfsnode required');
        }

        if (null !== self.mountedNode) {
            throw new Error('node already mounted');
        }

        self.mountedNode = vfsnode;
    };

    function pathLookupNext(vfsnode, pathComponents, componentIndex, resolve) {
        if (null === vfsnode) {
            resolve(null);
            return;
        }

        if (componentIndex >= pathComponents.length) {
            resolve(vfsnode);
            return;
        }

        var component = pathComponents[componentIndex];
        vfsnode.lookup(component, function(vfsnodeNext) {
            pathLookupNext(vfsnodeNext, pathComponents, componentIndex + 1, resolve);
        });
    }

    function pathLookup(vfsnodeRoot, pathComponents, resolve) {
        pathLookupNext(vfsnodeRoot, pathComponents, 0, function(vfsnode) {
            resolve(vfsnode);
        });
    }

    function init(fsRoot, fsInitrd) {
        var root = new VFSNode(fsRoot, fsRoot.getRootInode(), 'root');

        return new Promise(function(resolve, reject) {
            root.lookup('initrd', function(vfsnode) {
                var initrdRoot = new VFSNode(fsInitrd, fsInitrd.getRootInode(), 'initrd');
                vfsnode.mount(initrdRoot);

                resolve(root);
            });
        });
    }

    return {
        createFsInitrd: createFsInitrd,
        createFsRoot: createFsRoot,
        pathLookup: pathLookup,
        init: init,
        parsePathString: parsePathString,
    };
})();

/**
 * Virtual file system component
 */
define('vfs', ['resources'],
function(resources) {
    "use strict";

    var fsRoot = vfs.createFsRoot();
    var fsInitrd = vfs.createFsInitrd(resources.natives.initrdList());

    vfs.init(fsRoot, fsInitrd).then(function(root) {

        root.list(function(list) {
            rt.log('ls $', list.map(function(x) { return x.name; }));
        });

        var pathComponents = vfs.parsePathString('/initrd/lib/runtime/0.1.0/platform.js');

        vfs.pathLookup(root, pathComponents, function(vfsnode) {
            if (vfsnode) {
                rt.log('pathLookup $', vfsnode.name);
            } else {
                rt.log('pathLookup $ not found');
            }
        });

    }).catch(function(err) {
        rt.log(err.stack);
    });
});
