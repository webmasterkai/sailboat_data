React = require 'react'
{dl, dt, dd} = require 'reactionary'
_ = require 'lodash'

module.exports = React.createClass

  render: ->
    boat = @props.model
    dlist = []
    _.each boat, (id, val) ->
      dlist.push dt
        key: 'dt-'+id,
          id
      dlist.push dd
        key: 'dd-'+id,
          val
    dl
      className: 'dl-horizontal',
        dlist
