(function () {
	'use strict';

	function BlogSummaryController() {
		var ctrl = this;
		
		ctrl.$onChanges = function(){
			if(ctrl.blogEntry){
				ctrl.localBlogEntry = angular.copy(ctrl.blogEntry);
			}
		}
	}

	angular.module('app').component('blogSummary', {
		templateUrl: 'js/components/blogSummary/blogSummary.html',
		controller: BlogSummaryController,
		bindings: {
			blogEntry: '<'
		}
	});
})();
