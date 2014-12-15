State = require("ampersand-model")

data = require './sailboat.yaml'
calc = require './comfortRatio'

module.exports = State.extend
  props: data.props
  fields: data.props
  extraProperties: 'allow'
  url: ->
    '/api/boat/'+@id+'.json'

  parse: (item) ->
    item.retrieved = true
    if item.logo
      item.logo = 'http://sailboatdata.com/'+item.logo
    if item.phrf
      item.phrf += ''
    item

  # Comfort ratio = Disp / (2/3*((7/10 * LWL)+(1/3 *LOA))*Beam4/3 )
  cr: (loa, lwl, disp, beam) ->
    disp / ((2/3) * (((7/10) * lwl) + ((1/3) * loa)) * Math.pow(beam, (4/3)))

  derived:
    comfortRatio:
      deps: ['loa', 'lwl', 'disp', 'beam']
      fn: ->
        if @loa and @lwl and @disp and @beam
          disp = parseInt @disp.split('/')[0].replace('lbs.', '')
          beam = parseFloat @beam.split('/')[0].replace("'", '')
          loa = parseFloat @loa.split('/')[0].replace("'", '')
          lwl = parseFloat @lwl.split('/')[0].replace("'", '')
          calc.cr loa, lwl, disp, beam
          #disp / ((2/3) * (((7/10) * lwl) + ((1/3) * loa)) * Math.pow(beam, (4/3)))
    csf:
      deps: ['beam', 'disp']
      fn: ->
        if @disp and @beam
          disp = parseInt @disp.split('/')[0].replace('lbs.', '')
          beam = parseFloat @beam.split('/')[0].replace("'", '')
          calc.csf beam, disp

    searchStr:
      deps: ['name']
      fn: ->
        str = @name
        str.toLowerCase()
    title:
      deps: ['name', 'loa', 'first-built']
      fn: ->
        @name + ' [' + @['first-built'] + ']'
    link:
      deps: ['id']
      fn: ->
        'http://sailboatdata.com/viewrecord.asp?class_id='+@id
