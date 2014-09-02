Collection = require('ampersand-rest-collection')
Item = require('./boat')

module.exports = Collection.extend
  model: Item
  indexes: ['title']
