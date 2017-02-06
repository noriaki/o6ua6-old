const path = require('path');
const webpack = require('webpack');
const WebpackAssetsManifest = require('webpack-assets-manifest');

const DEV =
        process.env.NODE_ENV === 'development' ||
        process.env.NODE_ENV === undefined;
const assetsManifestPath = DEV ?
        path.resolve('..', 'assets', 'config', 'manifest-development.json') :
        path.resolve('..', 'assets', 'config', 'manifest.json');

module.exports = {
  entry: {
    home: [path.resolve('js', 'AppHome.jsx')],
  },
  output: {
    filename: '[name]-[hash].js',
    // chunkFilename: '[id]-[chunkhash].js',
    path: path.resolve('..', 'assets', 'javascripts'),
  },
  devServer: {
    publicPath: '/javascripts/',
  },
  devtool: 'cheap-module-eval-source-map',
  plugins: [
    new WebpackAssetsManifest({
      output: assetsManifestPath,
      writeToDisk: true,
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify(process.env.NODE_ENV) },
    }),
  ],
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    modules: [
      path.resolve('js'),
      'node_modules',
    ],
    extensions: ['.jsx', '.js', '.json'],
  },
};
