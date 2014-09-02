Qs = require 'qs'
_ = require 'lodash'
Router = require 'ampersand-router'

module.exports = Router.extend

  routes:
    '': -> @redirectTo 'search'
    'search(/:searchTxt)': 'search'

  search: (searchTxt) ->
    document.title = 'Sailboat Search'
    @setReactState
      searchTxt: searchTxt or ''
      section: 'search'
