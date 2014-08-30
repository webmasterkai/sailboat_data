React = require 'react'
{div, textarea, label, span} = require 'reactionary'
md = require 'marked'
module.exports = React.createClass

  getInitialState: ->
    value: 'Type some *markdown* here!'

  propTypes:
    id: React.PropTypes.string.isRequired
    label: React.PropTypes.string.isRequired
    fieldType: React.PropTypes.string.isRequired
    placeholder: React.PropTypes.string

  setMarkdown: ->
    @setState value: @refs[@props.id].getDOMNode().value

  render: ->
    div
      className: 'form-group',
        label
          className: 'col-md-4 control-label'
          htmlFor: @props.id,
            @props.label
        div
          className: 'col-md-4',
            textarea
              className: 'form-control'
              id: @props.id
              ref: @props.id
              value: @state.value
              onChange: @setMarkdown
              type: @props.fieldType
              placeholder: @props.placeholder
            span
              className: 'help-block',
                @props.help
        div
          className: 'markdown-content',
          dangerouslySetInnerHTML:
            __html: md @state.value
