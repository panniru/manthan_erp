(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope", function($scope) {
        $scope.post_dated_cheques = []
	$scope.initialize = function(){
	    for(var i=0; i<12; i++){
		$scope.post_dated_cheques.push({"date":""});
            };
	}
                     
    }]);
    
})(angular, myApp);
             
