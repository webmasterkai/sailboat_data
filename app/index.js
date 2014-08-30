(function() {
  var React, Router, SubCollection, _;

  React = require('react');

  SubCollection = require('ampersand-subcollection');

  _ = require('lodash');

  Router = require('./react-router');

  module.exports = {
    blastoff: function() {
      var el, routerComponent, self;
      window._ = _;
      self = window.app = this;
      el = document.getElementById('react');
      routerComponent = Router({});
      return this.container = React.renderComponent(routerComponent, el);
    }
  };

  module.exports.blastoff();

}).call(this);
