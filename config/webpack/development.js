process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const WebpackMildCompile = require('webpack-mild-compile').Plugin;


environment.plugins.append('Provide',new WebpackMildCompile());


module.exports = environment.toWebpackConfig()
