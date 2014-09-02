(function() {
  var Qs, Router, _;

  Qs = require('qs');

  _ = require('lodash');

  Router = require('ampersand-router');

  module.exports = Router.extend({
    routes: {
      '': function() {
        return this.redirectTo('search');
      },
      'search(/:searchTxt)': 'search'
    },
    search: function(searchTxt) {
      document.title = 'Sailboat Search';
      return this.setReactState({
        searchTxt: searchTxt || '',
        section: 'search'
      });
    }
  });

}).call(this);
