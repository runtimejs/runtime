// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Virtual file system component
 */
define('vfs', [],
function() {
    "use strict";

    function Node(name) {
        this.name = name;
        this.children = new Map();
    }

    Node.prototype.get = function(name) {
        var node = this.children.get(name);
        if ('undefined' === typeof node) {
            return null;
        }

        return node;
    }


    function pathLookupNext(node, parts) {
        var name = parts.shift();
        var nextNode = node.get(name);
        if (null === nextNode) {
            return null;
        }

        if (0 === parts.length) {
            return nextNode;
        }

        return pathLookupNext(nextNode, parts);
    }

    function pathLookup(root, path) {
        var parts = path.split('/');

        if (0 === parts.length || '' !== parts[0]) {
            throw new Error('invalid path');
        }

        if (1 === parts.length) {
            return root;
        }

        // Remove the root
        parts.shift();
        return pathLookupNext(root, parts);
    }
    

    function mount(path) {
    }

    var root = new Node('root');
    pathLookup(root, '/home/root/file1.doc');

    return { };
});
