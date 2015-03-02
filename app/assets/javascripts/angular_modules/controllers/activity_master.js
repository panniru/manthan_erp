(function(angular, app) {
    "use strict";
    app.controller("ActivityMasterController",["$scope","resourceService", "activityMasterService", function($scope, resourceService, activityMasterService) { 
        $scope.activities = resourceService.ActivityMaster.query();  
        $scope.activity_masters = [];      

        $scope.showActivities = function(){
            $scope.activities = resourceService.ActivityMaster.query();  
            $scope.activity_masters = [];
        };

        $scope.addActivity = function(){
            $scope.activity_masters.push({
                subject_name: "",
                subject_type: "non_academics"
            });
        };

        $scope.addMoreActivities = function(){
            for(var i=0; i<3; i++){
                $scope.addActivity(); 
            } 
        };
        
        $scope.submitActivities = function(){          
            resourceService.ActivityMaster.bulk({bulk_activity: $scope.activity_masters})
                .$promise.then(function(response){
                    if(response[0] == "success"){
                        alert("Bulk Activities Added Successfully");
                        $scope.showActivities();
                        $('#myModal').modal('hide');
                        $scope.showErrorMessage = false;
                    }
                    else
                    {
                        $scope.showErrorMessage = true;
                    }
                });

        };        
       
        $scope.deleteActivity = function(activity){       
            if(confirm("Are you sure want to delete")){
                activity.$delete()
                    .then(function(responce){
                        $scope.showActivities();                   
                    })
            }else{
                $('#myModal').modal('hide');
            }     
        };

    }]);
})(angular, myApp)
