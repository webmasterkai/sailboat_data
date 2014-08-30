Qs = require 'qs'
_ = require 'lodash'
Router = require 'ampersand-router'

module.exports = Router.extend

  routes:
    '': 'form'
    'form': 'form'

  form: ->
    @setReactState section: 'form'
