(function(angular, app) {
    "use strict";
    app.controller("FeeTypesController",["$scope", function($scope) {
        $scope.fee_types = []
        for(var i=0; i<5; i++){
            $scope.fee_types.push({"fee_type":""});
        };
        
        $scope.addMorefeeTypes = function(){
            var lnt = parseInt($scope.fee_types.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.fee_types.push({"fee_type":""});
            };
        }
    }]);
    
})(angular, myApp);


