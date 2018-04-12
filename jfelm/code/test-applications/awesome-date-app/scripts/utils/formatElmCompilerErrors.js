/***
 * Excerpted from "Programming Elm",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/jfelm for more book information.
***/
'use strict';

var chalk = require('chalk');
var ctx = new chalk.constructor({ enabled: true });
var error = ctx.bold.red;
var filename = ctx.cyan;
var isBrowser = typeof window === 'object';

if (isBrowser) {
  ctx.level = 1;
  error = ctx.cyan;
  filename = ctx.green;
}

function stripRedundantInfo(error) {
  return error.replace(
    /Module build failed: Error: Compiler process exited with error Compilation failed/g,
    ''
  );
}

module.exports = function formatElmCompilerErrors(messages) {
  var errors = messages.errors;
  var warnings = messages.warnings;
  return errors.length > 0
    ? {
        errors: errors
          .map(x =>
            x
              .replace(/(--\s[A-Z\s]+-+\s.*\.elm\r?\n)/g, filename('$1'))
              .replace(/(\n\s*)(\^+)/g, '$1' + error('$2'))
              .replace(/(\d+)(\|>)/g, '$1' + error('$2'))
          )
          .map(stripRedundantInfo),
        warnings: warnings
      }
    : messages;
};
