React = require 'react'
{h2, dl, dt, dd} = require 'reactionary'
_ = require 'lodash'

module.exports = React.createClass

  handleLoaded: ->
    @props.initState.setRouterState modelLoaded: true

  componentDidMount: ->
    @props.model.on 'change:retrieved', @handleLoaded

  componentWillUnmount: ->
    @props.model.off 'change:retrieved', @handleLoaded

  render: ->
    boat = @props.model
    dlist = []
    boatFields = boat.toJSON()
    _.each boatFields, (val, id) ->
      field = boat.fields[id] or {}
      if _.isString val and not field.element == 'hidden'
        dlist.push dt
          key: 'dt-'+id,
            field.title or id
        dlist.push dd
          key: 'dd-'+id,
            val
      # else
      #   dlist.push @(@props)
    div
      className: 'info',
        h2 boat.name
        dl
          className: 'dl-horizontal',
            dlist
