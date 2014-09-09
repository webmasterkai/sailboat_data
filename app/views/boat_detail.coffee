React = require 'react'
{div, h2, h3, p, dl, dt, dd, ul, li, span, small, mark, strong, img} = require 'reactionary'
_ = require 'lodash'

module.exports = React.createClass

  handleLoaded: (model, val) ->
    @props.initState.setRouterState modelLoaded: val

  componentDidMount: ->
    @props.model.on 'change:retrieved', @handleLoaded

  componentWillUnmount: ->
    @props.model.off 'change:retrieved', @handleLoaded

  componentWillReceiveProps: (nextProps) ->
    @props.model.off 'change:retrieved', @handleLoaded
    nextProps.model.on 'change:retrieved', @handleLoaded

  built: (boat) ->
    builtQty = if boat.built then mark(boat.built) else false
    first = if boat['first-built'] then strong(boat['first-built']) else false
    last = if boat['last-built'] then ' to '+boat['last-built'] else false

    if boat.designer
      designer = span ' Designed by ', mark(boat.designer), '.'
    else
      designer = false

    builder = if boat.builder then ' by '+boat.builder else false

    if last
      fromSince = ' from '
    else
      fromSince = ' since '
    # if first and last
    #   str = built+' from '+first+' to '+last
    # else if first and not last
    #   str = built+' since '+first
    # if builder
    #   str += ' by '+builder+'.'
    # if designer
    #   str += ' Designed by '+designer+'.'
    p {}, 'Built ', builtQty, fromSince, first, last, builder, '.', designer

  size: (boat) ->
    ul
      className: 'list-inline',
        li boat.loa

  weight: (boat) ->
    ul
      className: 'weight list-inline',
        li boat.disp
        li boat['bal-type']
        li boat.ballast
        li boat['bal-disp']
        li boat['disp-len']

  name: (boat) ->
    h2 boat.name + ' ', small(boat.loa+' - '+boat.lwl)

  logo: (boat) ->
    unless boat.logo
      return false
    img
      className: 'pull-right'
      src: boat.logo
      alt: boat.name

  render: ->
    boat = @props.model
    unless boat and boat.id
      return false
    dlist = []
    boatFields = boat.toJSON()
    hide = ['id', 'name', 'notes', 'first-built', 'last-built',
      'designer', 'built', 'bal-type', 'bal-disp', 'disp',
      'ballast', 'disp-len', 'loa', 'lwl', 'builder', 'logo']
    _.each boatFields, (val, id) ->
      field = boat.fields[id] or {}
      if _.isString(val) and not _.contains(hide, id)
        dlist.push dt
          key: 'dt-'+id,
            field.title or id
        dlist.push dd
          key: 'dd-'+id,
            val
    if boat.phrf
      dlist.push dt key: 'dt-phrf', 'PHRF'
      dlist.push dd key: 'dd-phrf', boat.phrf
    if boat.notes
      notes = div
        className: 'notes',
          h3 'Notes'
          p boat.notes
    else
      notes = false
    if boat.imgs and boat.imgs.length
      imgs = boat.imgs.map (image) ->
        img
          src: 'http://sailboatdata.com/'+image.link
          alt: image.text
    else
      imgs = false
    div
      className: 'info col-md-8',
        @logo boat
        @name boat
        @built boat
        @weight boat
        dl
          className: 'dl-horizontal',
            dlist
        notes
        imgs
