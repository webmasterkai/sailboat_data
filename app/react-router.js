(function() {
  var React, Router, div, p, _, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, p = _ref.p;

  _ = require('lodash');

  Router = require('./router');

  module.exports = React.createClass({
    router: new Router(),
    initRouter: function() {
      this.router.setReactState = this.setRouterState;
      return this.router.history.start();
    },
    componentDidMount: function() {
      return this.initRouter();
    },
    setRouterState: function(newState) {
      if (newState) {
        return this.setState(newState);
      }
    },
    brokenEl: function(section) {
      var txt;
      txt = 'Hello there! Unfortunately our application is broken... ';
      return p(txt + section);
    },
    render: function() {
      var component, footer, header, props, section;
      section = null;
      if (this.state && this.state.section) {
        section = this.state.section;
      }
      props = {
        initState: this.state,
        setRouterState: this.setRouterState
      };
      if (_.isObject(props.initState)) {
        props.initState.setRouterState = this.setRouterState;
      }
      header = false;
      component = (function() {
        switch (section) {
          case 'example':
            return p('example');
          default:
            return this.brokenEl(section);
        }
      }).call(this);
      footer = false;
      return div(header, component, footer);
    }
  });

}).call(this);
