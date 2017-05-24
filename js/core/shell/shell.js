class Shell {
  constructor(cmdcb = () => {},promptcb = () => {},name = "rtty",user = "runtime",width = 80,height = 25,stdio = runtime.stdio.defaultStdio) {
    this.CURSOR.X = this.CURSOR.Y = 0;
    this.CURSOR.SHOWING = true;
    this.WIDTH = width;
    this.HEIGHT = height;
    this.COMMANDS = new Map();
    this.ENV = {};
    this.ENV["TERM"] = name;
    this.ENV["USER"] = user;
    this.ENV["HOME"] = "/";
    this.ENV["PATH"] = "";
    this.DIR = "/";
    this.HISTORY = [];
    this.STDIO = stdio;
    this.oncommand = cmdcb;
    this.onprompt = promptcb;
  },
  run(cmd,argv,cb) {
    this.HISTORY.push(cmd+argv.join(" "));
    return this.oncommand(cmd,argv,cb);
  },
  prompt(loop) {
    return this.onprompt(loop);
  }
}
module.exports = Shell;