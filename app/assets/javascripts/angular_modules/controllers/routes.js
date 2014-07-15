(function(angular, app) {
    "use strict";
    app.controller("RouteController",["$scope","resourceService", function($scope, resourceService) {
	$scope.routes = resourceService.Route.query();
        $scope.newRoutes = []
        
        $scope.newRoute = function(){

            for(var i=0; i<1; i++){
                $scope.newRoutes.push({"lpp":"", "sequence_no" :"" });
            };
            $('#createModal').modal('show')
        }
	$scope.editRoutes = function(){
            $scope.newRoutes = $scope.routes
            $('#createModal').modal('show')
        }
        $scope.submitRoutes = function(){
            resourceService.Route.bulk({bulk_route: $scope.newRoutes})
                .$promise.then(function(responce){
                    $scope.routes = resourceService.Route.query()
                    $('#createModal').modal('hide')
                })
	}
	$scope.destroy = function(route){
            route.$delete()
                .then(function(responce){
                    $scope.routes.splice($scope.routes.indexOf(route), 1)
                })
        };
        
      
        $scope.addMoreterms = function(){
	    var lnt = parseInt($scope.newRoutes.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newRoutes.push({"lpp":"" , "sequence_no":""});
            };
        }
    }]);
    
})(angular, myApp);
