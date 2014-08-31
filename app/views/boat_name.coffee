React = require 'react'
{li, a} = require 'reactionary'

module.exports = React.createClass
  handleClick: (e) ->
    if e.preventDefault
      e.preventDefault()
    @props.initState.setRouterState id: e.target.id

  render: ->
    boat = @props.model
    li
      className: 'boat',
        a
          onClick: @handleClick
          id: boat.id
          href: boat.link,
            @props.model.title
