(function(angular, app) {
    "use strict";
    app.controller("DesignationsController",["$scope","resourceService", function($scope, resourceService) {         
        $scope.designations = resourceService.Designation.query();  
        $scope.designs = [];       

        $scope.showDesignations = function(){
            $scope.designations = resourceService.Designation.query();  
            
            $scope.designs = [];            
        };

        $scope.addDesignation = function(){
           
            $scope.designs.push({
                designation: "",
                
            });
        };

        $scope.addMoreDesignations = function(){
            for(var i=0; i<3; i++){
                $scope.addDesignation(); 
            } 
        };
        
        $scope.submitDesignations = function(){          
            resourceService.Designation.bulk({bulk_designation: $scope.designs})
                .$promise.then(function(response){
                    if(response[0] == "success"){
                        $scope.showDesignations();
                        $('#myModal').modal('hide');
                        $scope.showErrorMessage = false;
                        
                    }
                    else
                    {
                        $scope.showErrorMessage = true;
                    }
                });

        };        
       
        $scope.deleteDesignation = function(designation){       
            if(confirm("Are you sure want to delete")){
                designation.$delete()
                    .then(function(response){
                        $scope.showDesignations();                   
                        
                    })
            }else{
                $('#myModal').modal('hide');
            }     
        };

    }]);
})(angular, myApp)
