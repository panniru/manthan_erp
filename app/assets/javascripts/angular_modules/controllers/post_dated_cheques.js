(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope", function($scope) {
        $scope.post_dated_cheques = []
	$scope.initialize = function(){
	    for(var i=0; i<12; i++){
		$scope.post_dated_cheques.push({"date":""});
            };
	$scope.showModal = function(){
	    $("#myModal").modal()
	}
	    $scope.post_dated_cheque = {"date":"", "amount_per":""}
	    $scope.save = function(){
		$scope.post_dated_cheques.push( $scope.post_dated_cheque);
            };
    	}  
    }]);
})(angular, myApp);

