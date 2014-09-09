(function() {
  var Controller, React, Router, Search, div, p, _, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, p = _ref.p;

  _ = require('lodash');

  Router = require('./router');

  Controller = require('./controller');

  Search = require('./views/search');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        searchTxt: ''
      };
    },
    router: new Router(),
    initRouter: function() {
      this.router.setReactState = this.setRouterState;
      return this.router.history.start();
    },
    componentDidMount: function() {
      return this.initRouter();
    },
    componentDidUpdate: function(prevProps, prevState) {
      this.urlUpdate(prevState, this.state);
    },
    setRouterState: function(newState) {
      var s;
      if (newState) {
        s = Controller.prepState(newState);
        return this.setState(s);
      }
    },
    brokenEl: function(section) {
      var txt;
      txt = 'Hello there! Unfortunately our application is broken... ';
      return p(txt + section);
    },
    urlCreate: function(s) {
      var urlTxt;
      if (s.section === 'favs' && s.ids && s.ids.length) {
        urlTxt = s.section + '/' + s.ids.join('/');
      } else {
        urlTxt = s.section;
      }
      if (s.searchTxt) {
        urlTxt += '/' + s.searchTxt;
      }
      return urlTxt;
    },
    urlUpdate: function(prev, next) {
      var newUrl, oldURL;
      newUrl = this.urlCreate(next);
      oldURL = this.urlCreate(prev);
      if (newUrl !== oldURL) {
        this.router.navigate(newUrl, {
          replace: true
        });
        return true;
      } else {
        return false;
      }
    },
    render: function() {
      var component, footer, header, props, section;
      section = null;
      if (this.state && this.state.section) {
        section = this.state.section;
      }
      props = {
        initState: this.state,
        setRouterState: this.setRouterState,
        collection: app.boats
      };
      if (_.isObject(props.initState)) {
        props.initState.setRouterState = this.setRouterState;
      }
      header = false;
      component = (function() {
        switch (section) {
          case 'search':
            return Search(props);
          default:
            return this.brokenEl(section);
        }
      }).call(this);
      footer = false;
      return div({
        className: 'container'
      }, header, component, footer);
    }
  });

}).call(this);
