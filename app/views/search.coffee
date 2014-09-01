React = require 'react'
{div, p, label, fieldset} = require 'reactionary'

Typeahead = require('react-typeahead').Typeahead

FormBuilder = require './form_builder'
Names = require './boat_names'
Sources = require './sources'

BoatDetail = require './boat_detail'

data = require '../models/sailboat.yaml'

module.exports = React.createClass
  st:
    at: -1

  setSearchTxt: (e) ->
    val = e.target.value
    data.props.name.value = val
    @props.setRouterState searchTxt: val

  _nav: (nextId) ->
    @st.at = nextId
    model = app.boats.at nextId
    @props.setRouterState model: model, id: model.id

  _up: ->
    @_nav Math.max(0, @st.at - 1)

  _down: ->
    @_nav Math.min(app.boats.length-1, @st.at + 1)

  _onKeyDown: (e) ->
    if e.keyCode == 27 # esc
      @props.setRouterState
        id: null
        searchTxt: ''
      return false
    if e.keyCode == 38 # up
      @_up()
    if e.keyCode == 40 # down
      @_down()

  componentWillMount: ->
    data.props.name.onChange = @setSearchTxt
    data.props.name.onKeyDown = @_onKeyDown
    data.props._focus = 'name'

  componentWillUpdate: (nextProps, nextState) ->
    if nextProps and nextProps.initState
      #console.log nextProps.initState
      data.props.name.value = nextProps.initState.searchTxt

  render: ->
    if @props.initState.model
      console.log 'hi boat'
      detail = BoatDetail
        model: @props.initState.model
        initState: @props.initState
    else
      detail = false
    div
      className: 'boat-data row',
        div
          className: 'col-md-3',
            FormBuilder data.props
            Names
              collection: app.boats
              initState: @props.initState
        detail
