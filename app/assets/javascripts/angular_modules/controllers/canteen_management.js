(function(angular, app) {
    "use strict";
    app.controller('CanteensController',["$scope","resourceService","canteenManagementService", function($scope, resourceService,canteenManagementService) {
        $scope.mealtypes = resourceService.Mealtype.query();       
        $scope.newMeal = function(date){
            $scope.newMeals = []
           var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()
            $scope.canteenDate = dateFormat;            
            for(var i=0; i<1; i++){
                $scope.newMeals.push({"meal_type":"", "time" :""});
            };
            canteenManagementService.getMealtypeIdService()
                .then(function(result) {            
                    $scope.mealtypes = result.data;
                    $scope.mealnames = [];
                    for(var i=0; i < result.data.length; i++){
                        $scope.mealnames.push({
                            id: "",
                            meal_type_id: $scope.mealtypes[i]['id'],
                            meal_type: $scope.mealtypes[i]['mealtype'],
                            meal_detail_name: "",
                            canteen_date: "",
                        });
                    }
               //     alert(JSON.stringify($scope.mealnames));
                });      
            $('#createModal').modal('show')
        };
        $scope.submitMeals = function(){                       
            resourceService.Mealtype.bulk({bulk_meal: $scope.newMeals})          
                .$promise.then(function(responce){                                
                    $('#createModal').modal('hide')
                })
        }

        $scope.submitMenus = function(date){
           // var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()
            // $scope.canteenDate = dateFormat;
            alert($("#canteen_date").val())           
            resourceService.Mealname.bulk({bulk_meal: $scope.mealnames, canteen_date: $("#canteen_date").val()})
                .$promise.then(function(responce){
                    //  $scope.mealnames = canteenManagementService.Meal.query()   
                   
                    $('#myModalPop').modal('hide')
                })
        }
      
        
      //  $scope.edit = function(mealname){
        //    $scope.mealname = mealname
          //  $("#editModal").modal("show")
       // }
        


       
        $scope.addMoremeals = function(){
            var lnt = parseInt($scope.newMeals.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newMeals.push({"meal_type":"", "time" :""});
            };
        }
      
            
    }]);
})(angular, myApp);

