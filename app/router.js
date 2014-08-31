(function() {
  var Qs, Router, _;

  Qs = require('qs');

  _ = require('lodash');

  Router = require('ampersand-router');

  module.exports = Router.extend({
    routes: {
      '': 'search',
      'form': 'form'
    },
    search: function() {
      return this.setReactState({
        section: 'search'
      });
    }
  });

}).call(this);
