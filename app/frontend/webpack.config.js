const path = require('path');
const WebpackAssetsManifest = require('webpack-assets-manifest');

module.exports = {
  entry: {
    home: [path.resolve('js', 'AppHome.jsx')],
  },
  output: {
    filename: '[name]-[hash].js',
    chunkFilename: '[id]-[hash].js',
    path: path.resolve('..', 'assets', 'javascripts'),
  },
  devServer: {
    publicPath: '/javascripts/',
  },
  devtool: 'cheap-module-eval-source-map',
  plugins: [new WebpackAssetsManifest({
    output: path.resolve('..', 'assets', 'config', 'manifest.json'),
    writeToDisk: true,
  })],
};
