Collection = require('ampersand-collection')
Item = require('./boat')

module.exports = Collection.extend
  model: Item
