React = require 'react'
{div, p} = require 'reactionary'
_ = require 'lodash'

Router = require './router'
Controller = require './controller'

Search = require './views/search'

module.exports = React.createClass
  getInitialState: ->
    searchTxt: ''
    #loggedIn: app.me.loggedIn

  router: new Router()

  initRouter: ->
    @router.setReactState = @setRouterState
    @router.history.start()

  componentDidMount: ->
    @initRouter()

  setRouterState: (newState) ->
    if newState
      s = Controller.prepState(newState)
      @setState s

  brokenEl: (section) ->
    txt = 'Hello there! Unfortunately our application is broken... '
    p txt+section

  render: ->
    section = null
    if @state and @state.section
      section = @state.section
    props =
      initState: @state
      setRouterState: @setRouterState
      collection: app.boats

    if _.isObject props.initState
      props.initState.setRouterState = @setRouterState

    header = false
    component = switch section
      when 'search' then Search props
      else @brokenEl(section)
    footer = false

    return div header, component, footer
