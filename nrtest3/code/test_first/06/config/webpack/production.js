/***
 * Excerpted from "Rails 5 Test Prescriptions",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
***/
// Note: You must restart bin/webpack-watcher for changes to take effect

const webpack = require('webpack')
const merge = require('webpack-merge')
const CompressionPlugin = require('compression-webpack-plugin')

const sharedConfig = require('./shared.js')

module.exports = merge(sharedConfig.config, {
  output: { filename: '[name]-[chunkhash].js' },

  plugins: [
    new webpack.LoaderOptionsPlugin({
      minimize: true
    }),
    new webpack.optimize.UglifyJsPlugin(),
    new CompressionPlugin({
      asset: '[path].gz[query]',
      algorithm: 'gzip',
      test: /\.js$/
    })
  ]
})
