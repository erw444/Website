(function () {
	'use strict';
	var stateRouter = function($stateProvider, $urlRouterProvider) {
		var rootState = {
			name: 'root',
			url: '/',
			templateUrl: 'views/root.html'
		}

		var welcomeState = {
			name: 'root.welcome',
			url: 'welcome',
			controller: 'WelcomeController',
			controllerAs: '$ctrl',
			templateUrl: 'views/welcome.html'
		}

		var newEntryState = {
			name: 'root.newEntry',
			url: 'newEntry',
			templateUrl: 'views/newEntry.html'
		}

		$urlRouterProvider.otherwise("/welcome");
		$stateProvider.state(rootState);
		$stateProvider.state(welcomeState);
		$stateProvider.state(newEntryState);
	};

	angular.module('app', ['ui.router', 'ngResource', 'cp.ngConfirm'])
	.config(stateRouter)
	.run();
})();
