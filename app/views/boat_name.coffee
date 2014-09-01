React = require 'react/addons'

{li, a} = require 'reactionary'
cx = React.addons.classSet
module.exports = React.createClass
  handleClick: (e) ->
    if e.preventDefault
      e.preventDefault()
    @props.initState.setRouterState id: e.target.id

  render: ->
    boat = @props.model
    activeBoat = @props.initState.model
    active = activeBoat and activeBoat.id == boat.id
    classes = cx
      boat: true
      'bg-success': active
    li
      className: classes,
        a
          onClick: @handleClick
          id: boat.id
          href: boat.link,
            @props.model.title
