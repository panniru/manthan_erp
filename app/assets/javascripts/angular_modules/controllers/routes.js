(function(angular, app) {
    "use strict";
    app.controller("RoutesController",["$scope", function($scope) {
	$scope.routes = []
        for(var i=0; i<5; i++){
            $scope.routes.push({"no_of_stops":""});
        };
        
        $scope.addMoreterms = function(){
	    var lnt = parseInt($scope.routes.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.routes.push({"routes":""});
            };
        }
    }]);
    
})(angular, myApp);
