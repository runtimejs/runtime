var shells = new Map();

exports.Shell = require("./shell");
exports.addShell = function(shell) {
  if(shells.has(shell.ENV["TERM"])) return false;
  shells.set(shell.ENV["TERM"],shell);
};
exports.shells = shells;