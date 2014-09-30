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
                subject_name: ""
            });
        };

        $scope.addMoreSubjects = function(){
            for(var i=0; i<3; i++){
                $scope.addSubject(); 
            } 
        };

        $scope.submitSubjects = function(){          
            resourceService.SubjectMaster.bulk({bulk_subject: $scope.subject_masters})
                .$promise.then(function(responce){
                    $scope.showSubjects();
                    $('#myModal').modal('hide');
                });

        };        
       
        $scope.deleteSubject = function(subject){            
            subject.$delete()
                .then(function(responce){
                    $scope.showSubjects();                   
                })
        };

    }]);
})(angular, myApp)
