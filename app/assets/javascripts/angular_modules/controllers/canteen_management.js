(function(angular, app) {
    "use strict";
    app.controller('CanteensController',["$scope","resourceService","canteenManagementService","plot", function($scope, resourceService,canteenManagementService, plot) {
        $scope.mealtypes = resourceService.Mealtype.query();       
        $scope.newMeal = function(date){
            $scope.newMeals = []
	    alert(date)
	    //var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()
	    $scope.canteenDate = date
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
                            mealtype_id: $scope.mealtypes[i]['id'],
                            meal_type: $scope.mealtypes[i]['mealtype'],
                            meal_detail_name: "",
                            canteen_date: "",
                        });
                    }
                });      
            $('#createModal').modal('show')
        };
        $scope.submitMeals = function(){                       
            resourceService.Mealtype.bulk({bulk_meal: $scope.newMeals})          
                .$promise.then(function(responce){                                
                    $('#createModal').modal('hide')
		    window.location.reload();
                })
        }
	
	
        $scope.submitMenus = function(date){
	   
           // var dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()
            // $scope.canteenDate = dateFormat;
            //alert($("#canteen_date").val())           
            resourceService.Mealname.bulk({bulk_meal: $scope.mealnames, canteen_date: $("#canteen_date").val()})
                .$promise.then(function(responce){
                    //  $scope.mealnames = canteenManagementService.Meal.query()   
                   
                    $('#myModalPop').modal('hide')
		    window.location.reload();
                })
        }
	$scope.buildPlotChart = function(){
            canteenManagementService.getFoodWastage()
                .then(function(response){
		    plot.plotChart("placeholder123", response.data);
		})
        }
	
	canteenManagementService.getmealnameView()
	    .then(function(response){
		$scope.meals = response.data
		
	    });

	
	
        
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

