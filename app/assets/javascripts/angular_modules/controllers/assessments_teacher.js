(function(angular, app) {
    "use strict";
    app.controller('AssessmentsTeacherController', ["$scope", "assessmentsTeacherService", "teachersGradesService", "gradeService", "sectionService","assessmentsService", function($scope, assessmentsTeacherService, teachersGradesService, gradeService, sectionService, assessmentsService) { 
 
        $('#assessments_calendar').fullCalendar({           
            selectable: true,
            select: function(date) {
                $scope.dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();               
                $('#myModal').modal('show');                
            }            
        });
       
        assessmentsTeacherService.getTeacherGradeMappings()
            .then(function(result) {               
                $scope.mappings = result.data;   
               
                $scope.teacher_grade_subject_mappings = [];
                for (var i=0; i< $scope.mappings.length; i++){
                    $scope.teacher_grade_subject_mappings.push({
                        id: $scope.mappings[i]['id'],
                        teacher_grade_subject: $scope.mappings[i]['grade_name']+" - "+$scope.mappings[i]['section_name']+" - "+$scope.mappings[i]['subject_name'],                        
                    });
                }
               
                $scope.removeDuplicatesInGrades();
            });

        $scope.removeDuplicatesInGrades = function(){             
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
        };
        
        assessmentsService.getAssessmentTypesService()
            .then(function(result) {                 
                $scope.assessment_types = result.data;                 
            });  

        assessmentsTeacherService.getTeacherAssessmentsService()
            .then(function(result) {                 
                $scope.teacher_assessments = result.data;               
            });       

        $scope.getSections = function (){
            sectionService.getSectionServiceView()
                .then(function(result) {
                    $scope.sections=result.data;                   
                });
        };  
        
        $scope.showTeacherAssessmentMappings = function(){ 
            assessmentsTeacherService.getTeacherAssessmentsService()
                .then(function(result) {                 
                    $scope.teacher_assessments = result.data;                     
                });       
        };

        $scope.saveTeacherAssessmentMappings = function(){            
            $scope.save_teacher_assessments  = [];

            $scope.save_teacher_assessments.push({ 
                faculty_master_id: "",
                grade_master_id: $scope.myGrade,
                section_master_id: $scope.mySection,
                assessment_type_id: $scope.myAssessmentType,
                assessment_date: $scope.dateFormat,
            });

            assessmentsTeacherService.saveTeacherAssessmentMappings($scope.save_teacher_assessments)
               .then(function(result) {                    
               });  

            $scope.showTeacherAssessmentMappings();
        };

        $scope.editAssessmentGradeMappings = function(assessment_type){            
            $scope.edit_assessment_types = [];
            
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });                
        };

        $scope.deleteTeacherAssessmentMappings = function(teacher_assessment){            
            $scope.delete_mappping_id = teacher_assessment.id;
            
            assessmentsTeacherService.deleteTeacherAssessmentMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                });  
            
            $scope.showTeacherAssessmentMappings();         
        };
      
    

    }]);
   
})(angular, myApp);
