(function() {
  var Qs, Router, _;

  Qs = require('qs');

  _ = require('lodash');

  Router = require('ampersand-router');

  module.exports = Router.extend({
    routes: {
      '': 'form',
      'form': 'form'
    },
    form: function() {
      return this.setReactState({
        section: 'form'
      });
    }
  });

}).call(this);
