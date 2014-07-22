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

    function createFsInitrd(initrdFiles, initrdLoad) {
        var rootInode = 1;
        var fileInodeFirst = 2;

        var allocInodes = {};
        var initrdFilesCount = initrdFiles.length;
        var allocInodeNext = rootInode + fileInodeFirst + initrdFilesCount + 1;
        var inodesGraphAdj = new Map();

        function inodeToFile(inode) {
            var fileIndex = inode - fileInodeFirst;
            if (fileIndex >= 0 && fileIndex < initrdFilesCount) {
                return initrdFiles[fileIndex];
            } else {
                return null;
            }
        }

        function statInode(inode) {
            var file = inodeToFile(inode);
            if (!file) {
                return {
                    type: 'directory',
                    size: 0,
                };
            }

            return {
                type: 'file',
                size: file.size,
                // initrdName: file.name,
            };
        }

        /**
         * Read the entire contents of file
         */
        function readFile(inode, opts) {
            var file = inodeToFile(inode);
            if (!file) {
                return;
            }

            return initrdLoad(file.name)
        }

        for (var i = 0; i < initrdFilesCount; ++i) {
            var pathComponents = parsePathString(initrdFiles[i].name);
            var dirInode = rootInode;

            for (var j = 0; j < pathComponents.length; ++j) {
                var parentInode = dirInode;

                var component = pathComponents[j];
                var key = '$' + component + '_' + j;

                if ('undefined' === typeof allocInodes[key]) {
                    if (j === pathComponents.length - 1) {
                        dirInode = i + fileInodeFirst;
                    } else {
                        dirInode = allocInodeNext++;
                        allocInodes[key] = dirInode;
                    }
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
            stat: function(inode, resolve) {
                resolve(statInode(inode));
            },
            readFile: function(inode, opts, resolve) {
                resolve(readFile(inode, opts));
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
            stat: function(inode, resolve) {
                resolve({
                    type: 'directory',
                    size: 0,
                });
            },
            readFile: function(inode, opts, resolve) {
                resolve();
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

    function VFSNode(fs, parent, inode, name) {
        this.fs = fs;
        this.inode = inode;
        this.name = name;
        this.lookupCache = null;
        this.listCached = false;
        this.mountedNode = null;
        this.parent = parent;
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

            var vfsnode = new VFSNode(self.fs, self, inode, name);

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
                    vfsnode = new VFSNode(self.fs, self, inode, name);
                    self.lookupCache.set(name, vfsnode);
                }

                result.push(vfsnode);
            });

            self.listCached = true;
            resolve(result);
        });
    };

    VFSNode.prototype.readFile = function(opts, resolve) {
        var self = this;

        if (null !== self.mountedNode) {
            self = self.mountedNode;
        }

        self.fs.readFile(self.inode, opts, function(data) {
            resolve(data);
        });
    };

    VFSNode.prototype.stat = function(resolve) {
        var self = this;

        if (null !== self.mountedNode) {
            self = self.mountedNode;
        }

        self.fs.stat(self.inode, function(stat) {
            resolve(stat);
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
        vfsnode.parent = self;
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

    /**
     * Do a path lookup relative to provided root node
     */
    function pathLookup(vfsnodeRoot, pathComponents, resolve) {
        if (!(vfsnodeRoot instanceof VFSNode)) {
            resolve(null);
            return;
        }

        pathLookupNext(vfsnodeRoot, pathComponents, 0, function(vfsnode) {
            resolve(vfsnode);
        });
    }

    function init(fsRoot, fsInitrd) {
        var root = new VFSNode(fsRoot, null, fsRoot.getRootInode(), 'root');
        var initrdRoot = new VFSNode(fsInitrd, null, fsInitrd.getRootInode(), 'initrd');

        root.lookup('initrd', function(vfsnode) {
            vfsnode.mount(initrdRoot);
        });

        return {root: root, initrd: initrdRoot};
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
    var fsInitrd = vfs.createFsInitrd(resources.natives.initrdList(),
                                      resources.natives.initrdText);

    var ret = vfs.init(fsRoot, fsInitrd);
    var root = ret.root;
    var initrdRoot = ret.initrd;

    function createNodeAccessor(vfsnodeRoot) {
        var actions = {
            stat: function(vfsnode, opts, resolve) {
                vfsnode.stat(resolve);
            },
            readFile: function(vfsnode, opts, resolve) {
                vfsnode.readFile(opts, resolve);
            },
        };

        return function(opts) {
            return new Promise(function(resolve, reject) {
                function error(message) {
                    reject(new Error(message));
                }

                if ('string' !== typeof opts.path) {
                    return error('path required');
                }

                if ('string' !== typeof opts.action) {
                    return error('action required');
                }

                var action = opts.action;

                if ('undefined' === typeof actions[action]) {
                    return error('unknown action');
                }

                var pathComponents = vfs.parsePathString(opts.path);
                vfs.pathLookup(vfsnodeRoot, pathComponents, function(vfsnode) {
                    if (null === vfsnode) {
                        return error('file does not exist');
                    }

                    actions[action](vfsnode, opts, function(result) {
                        resolve(result);
                    });
                });
            });
        };
    };

    /**
     * Spawn new process.
     * @param {vfsnode} vfsnodeRoot - root node to use for path lookup
     * @param {string} path - path relative to root node
     * @param {object} opts - spawn options
     * @param {object} data - process extra data (objects, interfaces, command line etc)
     * @param {object} env - inherited process user environment (objects, interfaces etc)
     * @param {object} systemOverwrite [optional] - process system namespace overwrite
     */
    function spawn(vfsnodeRoot, path, opts, data, env, systemOverwrite) {
        if (Object(systemOverwrite) !== systemOverwrite) {
            systemOverwrite = {};
        }

        var pathComponents = vfs.parsePathString(path);

        vfs.pathLookup(vfsnodeRoot, pathComponents, function(vfsnode) {
            if (null === vfsnode) {
                return;
            }

            vfsnode.stat(function(stats) {
                if ('file' !== stats.type) {
                    return;
                }

                var workDir = vfsnode.parent;
                if (null === workDir) {
                    return;
                }

                vfsnode.readFile(null, function(fileContent) {
                    // FS accessors
                    systemOverwrite.fs = systemOverwrite.fs || {
                        default: createNodeAccessor(workDir),
                    };

                    // Process management functions
                    systemOverwrite.process = systemOverwrite.process || {
                        spawn: function(path, opts, data, env) {
                            spawn(workDir, path, opts, data, env);
                        },
                    };

                    // Console support
                    // TODO: log should write into stdout, not kernel log
                    systemOverwrite.console = systemOverwrite.console || {
                        log: runtime.log
                    };

                    resources.processManager.create(fileContent, {
                        system: systemOverwrite,
                        data: data,
                        env: env,
                    });
                });
            });
        });
    }

    return {
        getRoot: function() { return root; },
        getInitrdRoot: function() { return initrdRoot; },
        find: function(vfsnode, path) {
            return new Promise(function(resolve, reject) {
                var pathComponents = vfs.parsePathString(path);

                vfs.pathLookup(vfsnode, pathComponents, function(vfsnode) {
                    if (null === vfsnode) {
                        reject();
                        return;
                    }

                    resolve(createNodeAccessor(vfsnode));
                });
            });
        },
        spawn: spawn,
    };
});
