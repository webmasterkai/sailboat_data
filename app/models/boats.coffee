Collection = require('ampersand-rest-collection')
Item = require('./boat')

module.exports = Collection.extend
  model: Item
  url: 'http://localhost:8000/boat'
