const path = require('path');

module.exports = {
  entry: {
    home: [path.resolve('js', 'AppHome.jsx')],
  },
  output: {
    filename: '[name].js',
    path: path.resolve('..', 'assets', 'javascripts'),
  },
  devServer: {
    publicPath: '/javascripts/',
  },
  devtool: 'cheap-module-eval-source-map',
};
