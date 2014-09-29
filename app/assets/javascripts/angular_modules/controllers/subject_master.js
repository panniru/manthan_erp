(function(angular, app) {
    "use strict";
    app.controller("SubjectMasterController",["$scope","resourceService", "subjectMasterService", function($scope, resourceService, subjectMasterService) {      
        //alert();        
        $scope.subjects = resourceService.SubjectMaster.query();  
        $scope.subject_masters = [];
        //alert(JSON.stringify($scope.subjects));

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
        
        $scope.editSubject = function(subject){  
            $('#myEditModal').modal('show');   
            $scope.subject_master = subject;           
        };
        
        $scope.updateSubject = function(subject){ 
            $scope.subject_master.$update()
                .then(function(responce){
                    $scope.showSubjects();
                    $('#myEditModal').modal('hide');   
                })
           
        };

        $scope.deleteSubject = function(subject){            
            subject.$delete()
                .then(function(responce){
                    $scope.showSubjects();
                    //$scope.subjects.splice($scope.subjects.indexOf(subject), 1)
                })
        };

    }]);
})(angular, myApp)
