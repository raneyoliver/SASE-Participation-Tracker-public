/* eslint-disable @typescript-eslint/no-var-requires */
const LiveReloadPlugin = require('webpack-livereload-plugin');

module.exports = {
  mode: 'production',

  // Enable sourcemaps for debugging webpack's output
  devtool: 'source-map',

  resolve: {
    extensions: ['.ts', '.tsx', '.js', '.css'],
  },

  module: {
    rules: [
      {
        test: /\.ts(x?)$/,
        exclude: /node_modules/,
        use: {
          loader: 'ts-loader',
        },
      },
      // All output '.js' files will have any sourcemaps re-processed by source-map-loader.
      {
        enforce: 'pre',
        test: /\.js$/,
        loader: 'source-map-loader',
      },
    ],
  },

  plugins: [
    new LiveReloadPlugin({
      ignore: /tests/,
      port: 0,
    }),
  ],
};
