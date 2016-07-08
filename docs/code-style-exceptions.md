# Code Style Exceptions

The JavaScript code adheres to the style guide found [here](https://github.com/airbnb/javascript), but with some exceptions:

## No ES6 Modules

V8 support for native ES6 modules is under development, so for now use `require` like you would in Node.
All other ES6 features (classes, destructuring, default parameters, etc.) can be used freely.

## Using `for-of` and `for-in`

You're free to use `for-of` and `for-in` as necessary, however it's better to use `for (let value of object)` for values and `for (let key of Object.keys(object))` for keys.
You can still use `for-in`, just be sure you know [the catch](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in#Iterating_over_own_properties_only) when using it.

## Using 'dangling' underscores

You *can* use 'dangling' underscores to denote a private member on an object or class.
Some APIs were written before this style was adopted which use underscores for private members and probably won't be changed for compatability.
However, for any new APIs, it'd be prefered to use a [`Symbol`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol) instead, like:

```js
const somePrivateVarName = Symbol('somePrivateVarName');

class Demo {
  constructor() {
    this[somePrivateVarName] = 'my value';
  }
  getMyPrivateVar() {
    return this[somePrivateVarName];
  }
}
```
