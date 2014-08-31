React = require 'react'
{div, p, form, fieldset} = require 'reactionary'
_ = require 'lodash'

Text = require '../el/form/text'
TextArea = require '../el/form/textarea'
Select = require '../el/form/select'

module.exports = React.createClass
  handleSubmit: (e) ->
    if e.preventDefault
      e.preventDefault()

  render: ->
    fields = []
    _.forEach @props, (field, fieldId) ->
      props =
        key: fieldId
        id: fieldId
        label: field.label
        placeholder: field.placeholder
        help: field.help
        fieldType: field.element
        options: field.options
        onChange: field.onChange
        value: field.value
      if _.contains ['text', 'email'], field.element
        fields.push Text props
      else if field.element == 'select'
        fields.push Select props
      else if field.element == 'textarea'
        fields.push TextArea props

    form
      onSubmit: @handleSubmit
      className: 'form-horizontal',
        fieldset {},
          div
            className: 'input-area',
              fields
