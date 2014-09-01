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
      #console.log 'Fetching '+model.id
      model.fetch()
    model

  prepState: (s) ->
    console.log s
    if s.searchTxt
      @filterCollection s
    if app.boats.length and app.boats.length < 11
      app.boats.each @fetchBoat
    if s.searchTxt and not s.id and not s.model
      s.model = app.boats.at(0)
      s.id = s.model.id
    if s.id or s.model
      s.model = @fetchBoat(s.model or app.boats.get(s.id))
      s.id = s.model.id
      s.modelLoaded = s.model.retrieved
    return s
