React = require 'react'
{ul} = require 'reactionary'

Name = require './boat_name'

module.exports = React.createClass

  render: ->
    unless @props.initState.searchTxt.length
      return false
    s = @props.initState
    names = []
    @props.collection.each (model) ->
      names.push Name
        key: model.id
        model: model
        initState: s
    ul
      className: 'boats',
        names
