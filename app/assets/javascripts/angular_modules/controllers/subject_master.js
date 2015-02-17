(function(angular, app) {
    "use strict";
    app.controller("SubjectMasterController",["$scope","resourceService", "subjectMasterService", function($scope, resourceService, subjectMasterService) {         
        $scope.subjects = resourceService.SubjectMaster.query();  
        $scope.subject_masters = [];       

        $scope.showSubjects = function(){
            $scope.subjects = resourceService.SubjectMaster.query();  
            $scope.subject_masters = [];            
        };

        $scope.addSubject = function(){
            $scope.subject_masters.push({
                subject_name: "",
                subject_type: "academic"
            });
        };

        $scope.addMoreSubjects = function(){
            for(var i=0; i<3; i++){
                $scope.addSubject(); 
            } 
        };
        
        $scope.submitSubjects = function(){          
            resourceService.SubjectMaster.bulk({bulk_subject: $scope.subject_masters})
                .$promise.then(function(response){
                    if(response[0] == "success"){
                        alert("Bulk Subjects Added Successfully");
                        $scope.showSubjects();
                        $('#myModal').modal('hide');
                        $scope.showErrorMessage = false;
                    }
                    else
                    {
                        $scope.showErrorMessage = true;
                    }
                });

        };        
       
        $scope.deleteSubject = function(subject){       
            if(confirm("Are you sure want to delete")){
                subject.$delete()
                    .then(function(responce){
                        $scope.showSubjects();                   
                    })
            }else{
                $('#myModal').modal('hide');
            }     
        };

    }]);
})(angular, myApp)
