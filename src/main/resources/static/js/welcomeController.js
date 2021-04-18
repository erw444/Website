(function(){
  'use strict';
  
  let WelcomeController = function($scope, Blogs){
    var ctrl = this;
    ctrl.blogEntries = [];
    getBlogs();
    
    function getBlogs() {
    	Blogs.query($scope.model).$promise.then(
	        function(data){
	          ctrl.blogEntries= data;
	        });
    }
  }
  
  WelcomeController.$inject = ['$scope', 'Blogs'];
  angular.module('app').controller('WelcomeController', WelcomeController);
})();
