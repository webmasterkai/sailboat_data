_ = require 'lodash'

module.exports =
  filterCollection: (s) ->
    resetCollection = true
    config = {}
    if s.searchTxt
      config.limit = 30
      config.filters = s.searchTxt.toLowerCase().split(' ').map (searchTxt) ->
        (model) ->
          model.searchStr.indexOf(searchTxt) > -1

    if _.size config
      app.boats.configure config, resetCollection

  fetchBoat: (model) ->
    unless model.retrieved
      console.log 'Fetching '+model.id
      model.fetch()
    model

  prepState: (s) ->
    @filterCollection s
    if app.boats.length and app.boats.length < 21
      app.boats.each @fetchBoat
      if app.boats.length == 1
        s.model = app.boats.models[0]
        s.modelLoaded = false
      else
        s.model = null
        s.modelLoaded = false
    if s.id
      s.model = @fetchBoat(s.model or app.boats.get(s.id))
      s.modelLoaded = s.model.retrieved
    return s
