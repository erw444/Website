(function () {
	'use strict';

	function BlogEntryListController() {
		var ctrl = this;

		ctrl.$onChanges = function(){
			if(ctrl.blogEntries && ctrl.blogEntries.length){
				ctrl.localBlogList = angular.copy(ctrl.blogEntries);
			}
		}
	}

	angular.module('app').component('blogEntryList', {
		templateUrl: 'js/components/blogEntryList/blogEntryList.html',
		controller: BlogEntryListController,
		bindings: {
			blogEntries: '<'
		}
	});
})();
