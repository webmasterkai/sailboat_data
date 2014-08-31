React = require 'react'
SubCollection = require 'ampersand-subcollection'
_ = require 'lodash'

Router = require './react-router'

BoatNames = require './models/names'

BoatsCollection = require './models/boats'

module.exports =
  blastoff: ->
    window._ = _
    self = window.app = @
    boats = new BoatsCollection BoatNames#, parse: true
    app.boats = new SubCollection boats
    # Init the React application router.
    el = document.getElementById('react')
    routerComponent = Router {}
    @container = React.renderComponent routerComponent, el

# run it
module.exports.blastoff()
