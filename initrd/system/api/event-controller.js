

function EventController() {
  if (!(this instanceof EventController)) {
    throw new Error('constructor requires "new"');
  }

  this.listeners = [];
}

function testInstance(self) {
  if (!(self instanceof EventController)) {
    throw new Error('"this" is not an instance');
  }
}

function testFunction(fn) {
}

EventController.prototype.add = function(fn) {
  testInstance(this);
  if ('function' !== typeof fn) {
    throw new Error('argument 0 is not a function')
  }

  if (this.listeners.indexOf(fn) === -1) {
    this.listeners.push(fn);
  }
};

EventController.prototype.remove = function(fn) {
  testInstance(this);
  if ('function' !== typeof fn) {
    throw new Error('argument 0 is not a function')
  }

  var index = this.listeners.indexOf(fn);
  if (index !== -1) {
    this.listeners.splice(index, 1);
  }
};

EventController.prototype.raise = function() {
  testInstance(this);
  for (var i = 0, l = this.listeners.length; i < l; ++i) {
    this.listeners[i].apply(this, arguments);
  }
};

module.exports = EventController;
