# Contributing to runtime.js

Firstly, thanks for deciding to contribute! :+1:

## Got an issue?

 * Make sure the issue isn't already reported by checking in [Issues](https://github.com/runtimejs/runtime/issues).
 * Include the version of the kernel and JavaScript library in the issue description.

## Something to improve or add?

### Kernel change (C++)

Make sure that:
 * the kernel is compilable by running `scons` (more information [here](https://github.com/runtimejs/runtime/wiki/Build)).
 * the system can still boot up normally.
 * the new/fixed/changed feature/bug works (of course, :smile:).

### Library change (JavaScript)

Make sure that:
 * you run `npm run lint` at the root of repository (you'll also need to have installed dependencies beforehand with `npm install`) and get rid of any lint.
 * the system can still boot up normally.
 * the new/fixed/changed feature/bug works.
 * the code is written in as much ES6 as possible and it conforms to the style guide found [here](https://github.com/airbnb/javascript) (with a [few exceptions](https://github.com/runtimejs/runtime/docs/code-style-exceptions.md)).
