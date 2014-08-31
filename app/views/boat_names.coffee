React = require 'react'
{ul} = require 'reactionary'

Name = require './boat_name'

module.exports = React.createClass

  render: ->
    names = []
    @props.collection.each (model) ->
      names.push Name
        key: model.id
        model: model
    ul
      className: 'boats',
        names
