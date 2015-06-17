module.exports = function(runtime) {
  runtime.shell.setCommand('clear', function(args, cb) {
    // TODO: print according to screen height.
    runtime.tty.print('\n', 80, runtime.tty.color.BLACK, runtime.tty.color.BLACK);
    runtime.tty.moveTo(0, 0);
    cb();
  });
};
