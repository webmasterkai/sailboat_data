React = require 'react'
{div, p, label, fieldset} = require 'reactionary'

Typeahead = require('react-typeahead').Typeahead

FormBuilder = require './form_builder'
Names = require './boat_names'
Sources = require './sources'

BoatDetail = require './boat_detail'

data = require '../models/sailboat.yaml'

module.exports = React.createClass
  setSearchTxt: (e) ->
    val = e.target.value
    data.props.name.value = val
    @props.setRouterState searchTxt: val

  _onKeyDown: (e) ->
    console.log e.keyCode
    return false

  componentWillMount: ->
    data.props.name.onChange = @setSearchTxt
    data.props.name.onKeyDown = @_onKeyDown
    data.props._focus = 'name'

  render: ->
    if @props.initState.searchTxt.length > 1 or @props.initState.id
      colLen = @props.collection.length
      if @props.initState.model
        boatInfo = BoatDetail
          model: @props.initState.model
          initState: @props.initState
      else
        boatInfo = false
      if colLen > 0
        listSources = Sources()
      else
        listSources = false
      results = div {},
        Names
          collection: app.boats
          initState: @props.initState
        boatInfo
        listSources
    else
      results = false
    div
      className: 'boat-data',
        FormBuilder data.props
        results
