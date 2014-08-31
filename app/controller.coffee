_ = require 'lodash'

module.exports =
  filterCollection: (s) ->
    resetCollection = true
    config = {}
    if s.searchTxt
      config.filter = (model) -> model.searchStr.indexOf(s.searchTxt) > -1
    if _.size config
      app.boats.configure config, resetCollection

  prepState: (s) ->
    @filterCollection s
    return s
