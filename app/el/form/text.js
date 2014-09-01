(function() {
  var React, div, input, label, span, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, input = _ref.input, label = _ref.label, span = _ref.span;

  module.exports = React.createClass({
    propTypes: {
      id: React.PropTypes.string.isRequired,
      label: React.PropTypes.string,
      fieldType: React.PropTypes.string.isRequired,
      placeholder: React.PropTypes.string
    },
    render: function() {
      var fieldLabel;
      if (this.props.label) {
        fieldLabel = label({
          className: 'control-label',
          htmlFor: this.props.id
        }, this.props.label);
      } else {
        false;
      }
      return div({
        className: 'form-group'
      }, fieldLabel, div({
        className: ''
      }, input({
        className: 'form-control',
        id: this.props.id,
        value: this.props.value,
        onChange: this.props.onChange,
        onKeyDown: this.props.onKeyDown,
        type: this.props.fieldType,
        placeholder: this.props.placeholder,
        autoComplete: "off"
      }), span({
        className: 'help-block'
      }, this.props.help)));
    }
  });

}).call(this);
