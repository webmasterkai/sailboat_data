(function() {
  var React, div, label, md, span, textarea, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, textarea = _ref.textarea, label = _ref.label, span = _ref.span;

  md = require('marked');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        value: 'Type some *markdown* here!'
      };
    },
    propTypes: {
      id: React.PropTypes.string.isRequired,
      label: React.PropTypes.string.isRequired,
      fieldType: React.PropTypes.string.isRequired,
      placeholder: React.PropTypes.string
    },
    setMarkdown: function() {
      return this.setState({
        value: this.refs[this.props.id].getDOMNode().value
      });
    },
    render: function() {
      return div({
        className: 'form-group'
      }, label({
        className: 'col-md-4 control-label',
        htmlFor: this.props.id
      }, this.props.label), div({
        className: 'col-md-4'
      }, textarea({
        className: 'form-control',
        id: this.props.id,
        ref: this.props.id,
        value: this.state.value,
        onChange: this.setMarkdown,
        type: this.props.fieldType,
        placeholder: this.props.placeholder
      }), span({
        className: 'help-block'
      }, this.props.help)), div({
        className: 'markdown-content',
        dangerouslySetInnerHTML: {
          __html: md(this.state.value)
        }
      }));
    }
  });

}).call(this);
