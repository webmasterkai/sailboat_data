Qs = require 'qs'
_ = require 'lodash'
Router = require 'ampersand-router'

module.exports = Router.extend

  routes:
    '': 'search'
    'form': 'form'

  search: ->
    @setReactState section: 'search'
