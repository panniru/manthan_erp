(function(angular, app) {
    "use strict";
    app.controller('CanteensController',["$scope","resourceService", function($scope, resourceService) {
        $scope.canteen_managements = resourceService.CanteenManagement.query();
        $scope.newMeals = []
        $scope.newMeal = function(){
            for(var i=0; i<1; i++){
                $scope.newMeals.push({"meal_name":"", "time" :"", "description" :""});
            };
            $('#createModal').modal('show')
        }
        $scope.submitMeals = function(){
            alert(JSON.stringify($scope.newMeals));
            resourceService.CanteenManagement.bulk({bulk_meal: $scope.newMeals})          
                .$promise.then(function(responce){
                    //alert(result.data)                   
                    $('#createModal').modal('hide')
                })
        }
       
        $scope.addMoremeals = function(){
            var lnt = parseInt($scope.newMeals.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newMeals.push({"meal_name":"", "time" :"", "description":"" });
            };
        }
    }]);
})(angular, myApp);
