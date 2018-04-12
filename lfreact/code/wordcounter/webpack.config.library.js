/***
 * Excerpted from "React for Real",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/lfreact for more book information.
***/
const webpack = require('webpack');
module.exports = {
  entry: ['./src/index-library.js'],
  output: {
    path: __dirname,
    filename: 'library-bundle.js',
    libraryTarget: 'var',
    library: 'Wordcounter'
  },
  externals: {
    react: 'React',
    'react-dom': 'ReactDOM'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: ['babel-loader']
      }
    ]
  }
};
