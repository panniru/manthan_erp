(function(angular, app) {
    "use strict";
    app.controller("RoutesController",["$scope", function($scope) {
	alert('');
        $scope.routes = []
        for(var i=0; i<3; i++){
            $scope.routes.push({"no_of_stopes":""});
        };
        
        $scope.addMoreterms = function(){
            var lnt = parseInt($scope.no_of_stops.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.post_dated_cheques.push({"sequence_no":""});
            };
        }
    }]);
    
})(angular, myApp);
