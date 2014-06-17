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
