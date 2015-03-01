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

var resources = require('./resources')();

var vfs = (function() {

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
var fsRoot = vfs.createFsRoot();
var fsInitrd = vfs.createFsInitrd(resources.natives.initrdList(),
                  resources.natives.initrdText);

var ret = vfs.init(fsRoot, fsInitrd);
var root = ret.root;
var initrdRoot = ret.initrd;

var spawnSystem = {};

var spawnKernelData = {
  lspci: function() { return new Error('NOT_READY') },
  listNetworkInterfaces: function() { return new Error('NOT_READY') },
  systemInfo: resources.natives.systemInfo,
  isolatesInfo: resources.natives.isolatesInfo,
  reboot: resources.natives.reboot,
  enterSleepState: resources.acpi.enterSleepState,
};

/**
 * Accessor provides access to vfsnode for outside world
 */
function createNodeAccessor(vfsnodeRoot) {
  /**
  * Actions on this node. Required params for all actions:
  * @param {object} opts.action - action name to execute
  * @param {object} opts.path - path to lookup on node
  */
  var actions = {
    /**
     * Get node stats info
     */
    stat: function(vfsnode, opts, resolve, reject) {
      vfsnode.stat(resolve);
    },
    /**
     * Read file content
     */
    readFile: function(vfsnode, opts, resolve, reject) {
      vfsnode.readFile(opts, resolve);
    },
    /**
     * List files under directory
     */
    list: function(vfsnode, opts, resolve, reject) {
      vfsnode.list(function(data) {
        var names = [];
        for (var i = 0; i < data.length; ++i) {
          names.push(data[i].name);
        }

        resolve(names);
      });
    },
    /**
     * Execute file as a program
     * @param {object} opts.data [optional] - program data (objects, interfaces, command line etc)
     * @param {object} opts.env [optional] - inherited program environment (objects, interfaces etc)
     * @param {object} opts.system [optional] - overwrite program system data
     * @param {object} opts.onExit [optional] - function to call on program exit
     */
    spawn: function(vfsnode, opts, resolve, reject) {
      var argsData = opts.data || {};
      var argsEnv = opts.env || {};
      var argsSystem = opts.system || spawnSystem;
      var onExit = opts.onExit || function() {};

      if (Object(argsSystem) !== argsSystem) {
        argsSystem = spawnSystem;
      }

      vfsnode.stat(function(stats) {
        if ('file' !== stats.type) {
          reject(new Error('NOT_A_FILE'));
          return;
        }

        var workDir = vfsnode.parent;
        if (null === workDir) {
          reject(new Error('NO_PARENT'));
          return;
        }

        vfsnode.readFile(null, function(fileContent) {
          // FS accessors
          argsSystem.fs = argsSystem.fs || {
            current: createNodeAccessor(workDir),
          };

          argsSystem.kernel = argsSystem.kernel || spawnKernelData;

          resources.isolatesManager.create([fileContent, vfsnode.name],
            [argsData, argsEnv, argsSystem]).then(function(value) {
            onExit(value);
          }, reject);
        });
      });
    },
  };

  return function(opts) {
    return new Promise(function(resolve, reject) {
      function error(message) {
        reject(new Error(message));
      }

      if ('string' !== typeof opts.path) {
        return error('NO_PATH');
      }

      if ('string' !== typeof opts.action) {
        return error('NO_ACTION');
      }

      var action = opts.action;

      if ('undefined' === typeof actions[action]) {
        return error('UNKNOWN_ACTION');
      }

      var pathComponents = vfs.parsePathString(opts.path);
      vfs.pathLookup(vfsnodeRoot, pathComponents, function(vfsnode) {
        if (null === vfsnode) {
          return error('NOT_FOUND');
        }

        actions[action](vfsnode, opts, function(result) {
          resolve(result);
        }, function(err) {
          reject(err);
        });
      });
    });
  };
};

var rootAccessor = createNodeAccessor(root);
var initrdRootAccessor = createNodeAccessor(initrdRoot);

module.exports = {
  /**
   * Get VFS global root node
   */
  getRoot: function() { return rootAccessor; },
  /**
   * Get VFS initrd filesystem root node
   */
  getInitrdRoot: function() { return initrdRootAccessor; },
  /**
   * Expose kernel value to all new programs
   */
  setKernelValue: function(key, value) {
    spawnKernelData[key] = value;
  },
  /**
   * Get kernel value
   */
  getKernelValue: function(key) {
    return spawnKernelData[key];
  },
  /**
   * Set system namespace value
   */
  setSystem: function(name, value) {
    spawnSystem[name] = value;
  },
};
