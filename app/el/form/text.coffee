React = require 'react'
{div, input, label, span} = require 'reactionary'

module.exports = React.createClass

  propTypes:
    id: React.PropTypes.string.isRequired
    label: React.PropTypes.string.isRequired
    fieldType: React.PropTypes.string.isRequired
    placeholder: React.PropTypes.string

  render: ->
    div
      className: 'form-group',
        label
          className: 'col-md-4 control-label'
          htmlFor: @props.id,
            @props.label
        div
          className: 'col-md-4',
            input
              className: 'form-control'
              id: @props.id
              value: @props.value
              onChange: @props.onChange
              type: @props.fieldType
              placeholder: @props.placeholder
            span
              className: 'help-block',
                @props.help
