React = require 'react'
{div, input, label, span} = require 'reactionary'

module.exports = React.createClass

  propTypes:
    id: React.PropTypes.string.isRequired
    label: React.PropTypes.string
    fieldType: React.PropTypes.string.isRequired
    placeholder: React.PropTypes.string

  render: ->
    if @props.label
      fieldLabel = label
        className: 'control-label'
        htmlFor: @props.id,
          @props.label
    else
      false
    div
      className: 'form-group',
        fieldLabel
        div
          className: '',
            input
              className: 'form-control'
              id: @props.id
              value: @props.value
              onChange: @props.onChange
              onKeyDown: @props.onKeyDown
              type: @props.fieldType
              placeholder: @props.placeholder
              autoComplete: "off"
            span
              className: 'help-block',
                @props.help
