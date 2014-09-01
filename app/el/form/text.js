(function() {
  var React, div, input, label, span, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, input = _ref.input, label = _ref.label, span = _ref.span;

  module.exports = React.createClass({
    propTypes: {
      id: React.PropTypes.string.isRequired,
      label: React.PropTypes.string.isRequired,
      fieldType: React.PropTypes.string.isRequired,
      placeholder: React.PropTypes.string
    },
    render: function() {
      return div({
        className: 'form-group'
      }, label({
        className: 'col-md-4 control-label',
        htmlFor: this.props.id
      }, this.props.label), div({
        className: 'col-md-4'
      }, input({
        className: 'form-control',
        id: this.props.id,
        value: this.props.value,
        onChange: this.props.onChange,
        onKeyDown: this.props.onKeyDown,
        type: this.props.fieldType,
        placeholder: this.props.placeholder
      }), span({
        className: 'help-block'
      }, this.props.help)));
    }
  });

}).call(this);
