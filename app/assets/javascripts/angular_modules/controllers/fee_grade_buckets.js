(function(angular, app) {
    "use strict";
    app.controller("FeeGradeBucketsController",["$scope", function($scope) {
        $scope.fee_grade_buckets = []
      	for(var i=0; i<3; i++){
            $scope.fee_grade_buckets.push({"bucket_name":""});
        };
	$scope.addMorefeeTypes = function(){
            var lnt = parseInt($scope.fee_types.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.fee_types.push({"fee_type":""});
            };
	}
    }]);
    
})(angular, myApp);
