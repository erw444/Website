angular.module('app')
.controller('NewEntryController', ['$scope','NewBlogEntry', '$ngConfirm', function($scope, NewBlogEntry, $ngConfirm){
	$scope.model = {};
	$scope.submit = submit;
	$scope.editor =  new Quill('#editor-container', {
		  modules: {
			    toolbar: [
			      ['bold', 'italic'],
			      ['link', 'blockquote', 'code-block', 'image'],
			      [{ list: 'ordered' }, { list: 'bullet' }]
			    ]
			  },
			  placeholder: 'Compose an epic...',
			  theme: 'snow'
			});
	$scope.editor.on('text-change', function(){
		$scope.model.blogBody = $scope.editor.getText();
	})
	
	
	function submit(){
		NewBlogEntry.save($scope.model).$promise.then(
				function(data){
					$scope.model= {};
					$scope.editor.setContents([{ insert: '\n' }]);
					$ngConfirm("Blog has been posted.");
				}, function(error){
					$ngConfirm('Blog was not posted.');
				});
	}
}])