React = require 'react'
{div, p, label, fieldset} = require 'reactionary'

FormBuilder = require './form_builder'
Names = require './boat_names'
Sources = require './sources'

BoatDetail = require './boat_detail'

data = require '../models/sailboat.yaml'

module.exports = React.createClass
  st:
    at: 0

  setSearchTxt: (e) ->
    val = e.target.value
    data.props.name.value = val
    @props.setRouterState searchTxt: val

  _nav: (nextId) ->
    @st.at = nextId
    model = app.boats.at nextId
    # console.log model.id
    @props.setRouterState model: model, id: model.id
    false

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
      return @_up()
    if e.keyCode == 40 # down
      return @_down()

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
