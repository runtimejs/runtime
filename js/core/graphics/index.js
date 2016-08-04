'use strict';

const GraphicsRenderer = require('./graphics-renderer');
const { Screen, symbols: screenSymbols } = require('./screen');
const renderers = require('./renderers');
const screen = new Screen();

module.exports = {
  graphicsAvailable() {
    return renderers.renderersAvailable();
  },
  enableGraphics(width, height, bitDepth) {
    const renderer = renderers.getDefaultRenderer();
    renderer.enableGraphics(width, height, bitDepth);
    screen[screenSymbols.reset]();
    screen[screenSymbols.init](width, height, bitDepth, renderer);
  },
  GraphicsRenderer,
  get screen() {
    return screen;
  },
  addRenderer: renderers.addRenderer,
  get constants() {
    return renderers.getConstants();
  },
};
