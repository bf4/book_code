/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/

module.exports = function(config) {
  config.set({
    basePath: "",
    frameworks: ["jasmine"],
    files: ["spec/javascripts/**/*_spec.js"],
    preprocessors: {
      "app/javascript/packs/*.js": ["webpack", "sourcemap"],
      "spec/javascripts/**/*_spec.js": ["webpack", "sourcemap"],
    },
    reporters: ["mocha"],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ["ChromeHeadless"],
    singleRun: true,
    concurrency: Infinity,
    webpack: require("./config/webpack/test.js"),
    webpackMiddleware: {
      stats: "errors-only"
    }
  })
}
