(function(){
  'use strict';
  angular.module('app')
  .factory('Blogs', ['$resource', function($resource) {
    return $resource('/blog', {}, {
      query: {method: 'GET', url: '/blog/all', isArray: true},
      save: {method: 'POST', url: '/blog/new'}
    });
  }]);
})();
