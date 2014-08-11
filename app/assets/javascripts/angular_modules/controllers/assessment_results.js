(function(angular, app) {
    "use strict";
    app.controller('AssessmentResultsController', ["$scope", "assessmentsTeacherService", function($scope, assessmentsTeacherService) {        
        assessmentsTeacherService.getTeacherGradeMappings()
            .then(function(result) {               
                $scope.mappings = result.data;   
                //alert(JSON.stringify($scope.mappings));
                
                $scope.teacher_grade_subject_mappings = [];
                for (var i=0; i< $scope.mappings.length; i++){
                    $scope.teacher_grade_subject_mappings.push({
                        id: $scope.mappings[i]['id'],
                        grade_master_id: $scope.mappings[i]['grade_master_id'],
                        section_master_id: $scope.mappings[i]['section_master_id'],
                        subject_master_id: $scope.mappings[i]['subject_master_id'],                       
                        teacher_grade_subject: $scope.mappings[i]['grade_name']+" - "+$scope.mappings[i]['section_name']+" - "+$scope.mappings[i]['subject_name'],                        
                    });
                }   
                $scope.teacher_assessments = [];
                for(var i = 0; i < $scope.teacher_grade_subject_mappings.length; i++){
                    //alert(i);
                    //alert($scope.teacher_grade_subject_mappings.length);
                   
                    $scope.myGrade = $scope.teacher_grade_subject_mappings[i]['grade_master_id'];
                    $scope.mySection = $scope.teacher_grade_subject_mappings[i]['section_master_id'];  
                    $scope.mySubject = $scope.teacher_grade_subject_mappings[i]['subject_master_id']; 
              
                    assessmentsTeacherService.getTeacherAssessmentsService($scope.myGrade, $scope.mySection, $scope.mySubject)
                        .then(function(result) { 
                            alert(i);
                            alert($scope.teacher_grade_subject_mappings.length);
                            if(i != $scope.teacher_grade_subject_mappings.length){
                                alert();
                                $scope.teacher_assessments[i] = result.data;
                                alert(JSON.stringify($scope.teacher_assessments[i]));
                            }      
                            
                        });                    
                }

               //alert(JSON.stringify($scope.teacher_assessments));
            });

       
        
    }]);    
})(angular, myApp);
