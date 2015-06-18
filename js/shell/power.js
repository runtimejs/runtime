module.exports = function(runtime) {
  runtime.shell.setCommand('poweroff', function(args, cb) {
    runtime.tty.print('Going down, now!');
    runtime.machine.shutdown();
    cb();
  });
  runtime.shell.setCommand('reboot', function(args, cb) {
    runtime.tty.print('Restarting, now!');
    runtime.machine.reboot();
    cb();
  });
};
