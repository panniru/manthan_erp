(function(angular, app) {
    "use strict";
    app.controller("SchoolHousesController",["$scope","resourceService", "school_houses_service", function($scope, resourceService, school_houses_service) {         

        
        school_houses_service.getSchoolHouses()
            .then(function(result) {
                $scope.school_houses = result.data;
            });


        $scope.houses = resourceService.House.query();  
        $scope.housees = [];       

        $scope.showHouses = function(){
            $scope.houses = resourceService.House.query();  
            
            $scope.housees = [];            
        };

        $scope.addHouse = function(){
           
            $scope.housees.push({
                house: "",
                
            });
        };

        $scope.addMoreHouses = function(){
            for(var i=0; i<3; i++){
                $scope.addHouse(); 
            } 
        };
        
        $scope.submitHouses = function(){          
            resourceService.House.bulk({bulk_house: $scope.housees})
                .$promise.then(function(response){
                    if(response[0] == "success"){
                        $scope.showHouses();
                        $('#myModal').modal('hide');
                        $scope.showErrorMessage = false;
                        
                    }
                    else
                    {
                        $scope.showErrorMessage = true;
                    }
                });

        };        
       
        $scope.deleteHouse = function(house){       
            if(confirm("Are you sure want to delete")){
                house.$delete()
                    .then(function(response){
                        $scope.showHouses();                   
                        
                    })
            }else{
                $('#myModal').modal('hide');
            }     
        };

    }]);
})(angular, myApp)
