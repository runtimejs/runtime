# Contributing to runtime.js

Firstly, thanks for deciding to contribute! :+1:

## Got an issue?

 * Make sure the issue isn't already reported by checking in [Issues](https://github.com/runtimejs/runtime/issues).
 * Include the version of the kernel and JavaScript library in the issue description.
 * Include a description of what happens or what the issue/bug does and what the expected behavior is.

## Cool feature request?

 * Make sure the feature isn't already request by checking in [Issues](https://github.com/runtimejs/runtime/issues).
 * Include good reasons for why you think it should be added and why it'd be a good feature.
 * If possible, include resources for anyone planning to add the feature.

## Something to improve, add, or fix?

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
 * the code is written in as much ES6 as possible and it conforms to the style guide found [here](https://github.com/airbnb/javascript) (with a [few exceptions](docs/code-style-exceptions.md)).
