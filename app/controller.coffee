_ = require 'lodash'

module.exports =
  filterCollection: (s) ->
    resetCollection = true
    config = {}
    if s.searchTxt
      config.filters = s.searchTxt.toLowerCase().split(' ').map (searchTxt) ->
        (model) ->
          model.searchStr.indexOf(searchTxt) > -1

    if _.size config
      app.boats.configure config, resetCollection

  prepState: (s) ->
    @filterCollection s
    if app.boats.length and app.boats.length < 8
      app.boats.each (model) ->
        unless model.retrieved
          #console.log 'Fetching '+model.id
          model.fetch()
      if app.boats.length == 1
        s.model = app.boats.models[0]
        s.modelLoaded = false
      else
        s.model = null
    if s.id
      s.model = app.boats.get(s.id)
    return s
