Collection = require('ampersand-rest-collection')
Item = require('./boat')

module.exports = Collection.extend
  model: Item
  url: 'api/boat'
  indexes: ['title']
