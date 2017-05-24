var terms = require("../core/tty/terminal.js").terms;

function isatty(i) {
  return typeof(terms[i]) != "undefined";
}

exports.isatty = isatty;