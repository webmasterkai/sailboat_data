State = require("ampersand-state")

data = require './sailboat.yaml'

module.exports = State.extend
  props: data.props

  #parse: (item) ->
  derived:
    searchStr:
      deps: ['name']
      fn: ->
        str = @name
        str.toLowerCase()
    title:
      deps: ['name', 'loa', 'first_built']
      fn: ->
        @name + ' [' + @first_built + ']'
    link:
      deps: ['id']
      fn: ->
        'http://sailboatdata.com/viewrecord.asp?class_id='+@id
