(function() {
  var React, div, label, option, select, span, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, select = _ref.select, option = _ref.option, label = _ref.label, span = _ref.span;

  module.exports = React.createClass({
    propTypes: {
      id: React.PropTypes.string.isRequired,
      label: React.PropTypes.string.isRequired,
      options: React.PropTypes.array.isRequired
    },
    render: function() {
      var options;
      options = [];
      this.props.options.forEach(function(opt) {
        return options.push(option({
          key: opt.value,
          value: opt.value
        }, opt.name));
      });
      return div({
        className: 'form-group'
      }, label({
        className: 'col-md-4 control-label',
        htmlFor: this.props.id
      }, this.props.label), div({
        className: 'col-md-4'
      }, select({
        value: this.props.value,
        onChange: this.props.onChange,
        type: 'select'
      }, options), span({
        className: 'help-block'
      }, this.props.help)));
    }
  });

}).call(this);
