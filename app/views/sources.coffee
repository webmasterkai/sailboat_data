React = require 'react'
{img, a} = require 'reactionary'

module.exports = React.createClass

  render: ->
    a
      href: 'http://sailboatdata.com',
        img
          src: 'http://sailboatdata.com/images/sbd_logo_400x50.gif'
