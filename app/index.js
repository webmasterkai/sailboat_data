(function() {
  var BoatNames, BoatsCollection, React, Router, SubCollection, _;

  React = require('react');

  SubCollection = require('ampersand-subcollection');

  _ = require('lodash');

  Router = require('./react-router');

  BoatNames = require('./models/names');

  BoatsCollection = require('./models/boats');

  module.exports = {
    blastoff: function() {
      var boats, el, routerComponent, self;
      window._ = _;
      self = window.app = this;
      boats = new BoatsCollection(BoatNames);
      app.boats = new SubCollection(boats);
      el = document.getElementById('react');
      routerComponent = Router({});
      return this.container = React.renderComponent(routerComponent, el);
    }
  };

  module.exports.blastoff();

}).call(this);
