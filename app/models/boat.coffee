State = require("ampersand-model")

data = require './sailboat.yaml'

module.exports = State.extend
  props: data.props
  fields: data.props
  extraProperties: 'allow'
  parse: (item) ->
    item.retrieved = true
    item

  derived:
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
