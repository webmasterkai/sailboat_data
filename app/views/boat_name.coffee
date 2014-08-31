React = require 'react'
{li, a} = require 'reactionary'

module.exports = React.createClass

  render: ->
    boat = @props.model
    li
      className: 'boat',
        a
          href: boat.link,
            @props.model.title
