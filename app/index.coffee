React = require 'react'
SubCollection = require 'ampersand-subcollection'
_ = require 'lodash'
#r = require 'superagent'

Router = require './react-router'

BoatNames = require './models/names'

BoatsCollection = require './models/boats'
#Phrf = require './models/phrfs'
calc = require './models/comfortRatio'

module.exports =
  blastoff: ->
    window._ = _
    self = window.app = @
    boats = new BoatsCollection BoatNames#, parse: true
    app.boats = new SubCollection boats
    app.calc = calc
    # Init the React application router.
    el = document.getElementById('react')
    routerComponent = Router {}
    @container = React.renderComponent routerComponent, el
    #@phrf = new Phrf()
    #@phrf.fetch()
# run it
module.exports.blastoff()
