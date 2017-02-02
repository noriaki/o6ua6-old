const path = require('path');

module.exports = {
  entry: {
    home: [path.resolve('js', 'AppHome.jsx')],
  },
  output: {
    path: path.resolve('..', 'assets', 'javascripts'),
    filename: '[name].js',
  }
};
