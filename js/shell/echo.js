module.exports = function(runtime) {
  runtime.shell.setCommand('echo', function(args, cb) {
    runtime.tty.print(args);
    cb();
  });
};
