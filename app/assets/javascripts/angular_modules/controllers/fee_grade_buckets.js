(function(angular, app) {
    "use strict";
    app.controller("FeeGradeBucketsController",["$scope",  function($scope) {
        $scope.fee_grade_buckets = []
      	for(var i=0; i<3; i++){
            $scope.fee_grade_buckets.push({"grade_from":""});
        };
	$scope.validation = function(index, key){
	    if(key === "grade_from"){
		if(typeof $scope.fee_grade_buckets[index-1] != 'undefined'){
		   // alert($scope.fee_grade_buckets[index-1]["grade_to"] +"" +$scope.fee_grade_buckets[index]["grade_from"])
		    if($scope.fee_grade_buckets[index-1]["grade_to"] >= $scope.fee_grade_buckets[index]["grade_from"]){
			alert("already defined")
		    }
		}
	    }else{
		if($scope.fee_grade_buckets[index]["grade_to"] <= $scope.fee_grade_buckets[index]["grade_from"]){
		    alert("To field must be greater than From field")
		}
	    };
	}
	   
    }]);
	
})(angular, myApp);
