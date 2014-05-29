(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope", function($scope) {
        $scope.post_dated_cheques = []
	$scope.initialize = function(){
	    for(var i=0; i<12; i++){
		$scope.post_dated_cheques.push({"date":""});
            };
	$scope.showModal = function(){
	    alert('')
	    $("#myModal").modal()
	}
	    $scope.post_dated_cheque = {"date":"", "amount_per":""}
	    $scope.save = function(){
		$scope.post_dated_cheques.push( $scope.post_dated_cheque);
            };
    
	    
	$scope.validation = function(){
	    var lnt = parseInt($scope.post_dated_cheques.length)
	    var sum = 0
	    for(var i =0;i<lnt;i++){
		alert($scope.post_dated_cheques.amount_per)
		sum += parseInt($scope.post_dated_cheques.amount_per) ;
	    };
	    if (sum != 100)
		alert ('Percent not equal to 100');
	    else
		alert ('save?');
		
	}
	}  
     }]);
 })(angular, myApp);
