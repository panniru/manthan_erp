(function(angular, app) {
    "use strict";
    app.controller('AssessmentsTeacherController', ["$scope", "assessmentsTeacherService", "teachersGradesService", "gradeService", "sectionService","assessmentsService", function($scope, assessmentsTeacherService, teachersGradesService, gradeService, sectionService, assessmentsService) {         
        
        //alert("hi");
        teachersGradesService.getMappings(7)
            .then(function(result) {  
                $scope.mappings = result.data
                //alert(JSON.stringify($scope.mappings));
                $scope.teacher_grade_subject_mappings = [];
                for (var i=0; i< $scope.mappings.length; i++){
                    $scope.teacher_grade_subject_mappings.push({
                        id: $scope.mappings[i]['id'],
                        teacher_grade_subject: $scope.mappings[i]['grade_name']+" - "+$scope.mappings[i]['section_name']+" - "+$scope.mappings[i]['subject_name'],                        
                    });
                }
                //alert(JSON.stringify($scope.teacher_grade_subject_mappings));              
                $scope.temp_grades = [];  

                for (var i=0; i< $scope.mappings.length; i++){                  
                    $scope.temp_grades.push({ 
                        grade_master_id : $scope.mappings[i]['grade_master_id'],
                        grade_name :  $scope.mappings[i]['grade_name'], 
                    });
                }  

                var NewLength = 1;
                for (var i=1; i< $scope.temp_grades.length; i++){
                    for (var j=0; j< NewLength; j++){
                        if($scope.temp_grades[i]['grade_master_id'] == $scope.temp_grades[j]['grade_master_id']){ 
                            break;
                        }
                    }
                    if(j == NewLength){
                        $scope.temp_grades[NewLength++] = $scope.temp_grades[i]
                    }                                        
                }

                $scope.grades = [];
                for (var i=0; i< NewLength; i++){                  
                    $scope.grades.push({ 
                        grade_master_id : $scope.temp_grades[i]['grade_master_id'],
                        grade_name :  $scope.temp_grades[i]['grade_name'], 
                    });
                }     
                //alert(NewLength); 
                //alert(JSON.stringify($scope.grades)); 
                //alert(JSON.stringify($scope.temp_grades));                
            });

        assessmentsService.getAssessmentTypesService()
            .then(function(result) {                 
                $scope.assessment_types = result.data;  
                //alert(JSON.stringify($scope.assessment_types));
            });       


        assessmentsTeacherService.getTeacherAssessmentsService()
            .then(function(result) {                 
                $scope.teacher_assessments = result.data;  
                //alert(JSON.stringify($scope.teacher_assessments));    
            });       

        $scope.getSections = function (){
            sectionService.getSectionServiceView()
                .then(function(result) {
                    $scope.sections=result.data; 
                    alert(JSON.stringify($scope.sections));           
                });
        };       



    }]);    
})(angular, myApp);
