(function(angular, app) {
    "use strict";
    app.controller('AssessmentsTeacherController', ["$scope", "$location",  "assessmentsTeacherService", "teachersGradesService", "timeTableService", "assessmentsService", function($scope, $location , assessmentsTeacherService, teachersGradesService, timeTableService, assessmentsService) { 

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
                        grade_master_id: $scope.mappings[i]['grade_master_id'],
                        section_master_id: $scope.mappings[i]['section_master_id'],
                        subject_master_id: $scope.mappings[i]['subject_master_id'],                       
                        teacher_grade_subject: $scope.mappings[i]['grade_name']+" - "+$scope.mappings[i]['section_name']+" - "+$scope.mappings[i]['subject_name'],                        
                    });
                }               
            });
   
        assessmentsService.getAssessmentTypesService()
            .then(function(result) { 
                $scope.assessment_types = result.data;           
            });  
        
        $scope.getSections = function (){
            timeTableService.getSectionServiceView()
                .then(function(result) {
                    $scope.sections=result.data;                   
                });
        }; 
 
        $scope.getTeacherAssessmentMappings = function(){ 
            alert(' ')
            var path = "/";
            path = "/teacher_show";
            $location.path(path);            
            $scope.myGrade = $scope.myGradeSection['grade_master_id'];
            $scope.mySection = $scope.myGradeSection['section_master_id'];  
            $scope.mySubject = $scope.myGradeSection['subject_master_id']; 
            assessmentsTeacherService.getTeacherAssessmentsService($scope.myGrade, $scope.mySection, $scope.mySubject)
                .then(function(result) {                 
                    $scope.teacher_assessments = result.data;
                });  
        };    

        
        $scope.showTeacherAssessmentMappings = function(){ 
            $scope.getTeacherAssessmentMappings();  
        };

        $scope.saveTeacherAssessmentMappings = function(){            
            $scope.save_teacher_assessments  = [];

            $scope.save_teacher_assessments.push({ 
                id: "",
                faculty_master_id: "",
                grade_master_id: $scope.myGrade,
                section_master_id: $scope.mySection,
                subject_master_id: $scope.mySubject,
                assessment_id: $scope.myAssessment,
                assessment_desc: $scope.myAssessmentDescription,
                assessment_date: $scope.dateFormat,
            });

           assessmentsTeacherService.saveTeacherAssessmentMappings($scope.save_teacher_assessments)
             .then(function(result) {   
                $scope.showTeacherAssessmentMappings();
                $scope.cancelMyModal();                   
            });      
        };
        
        $scope.saveEditTeacherAssessmentMappings = function(){            
            assessmentsTeacherService.saveTeacherAssessmentMappings($scope.edit_teacher_assessments)
                .then(function(result) {                    
               });
            $scope.showTeacherAssessmentMappings();
        }

        $scope.editTeacherAssessmentMappings = function(teacher_assessment){            
            $scope.edit_teacher_assessments = [];            
            
            $scope.edit_teacher_assessments.push({
                id: teacher_assessment.id,
                faculty_master_id: teacher_assessment.faculty_master_id,
                grade_master_id: $scope.myGrade,
                section_master_id: $scope.mySection,
                subject_master_id: $scope.mySubject,
                assessment_id: teacher_assessment.assessment_id,
                assessment_desc: teacher_assessment.assessment_desc,
                assessment_date: teacher_assessment.assessment_date,
            });             
        };

        $scope.deleteTeacherAssessmentMappings = function(teacher_assessment){            
            $scope.delete_mappping_id = teacher_assessment.id;            
            assessmentsTeacherService.deleteTeacherAssessmentMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                });  
            
            $scope.showTeacherAssessmentMappings();         
        };

        $scope.cancelMyModal = function(){            
            $('#myModal').modal('hide');        
        };
    
        $scope.reflectContent = function(date_obj){          
            $scope.edit_teacher_assessments['assessment_date'] = $.datepicker.formatDate('yy-mm-dd', date_obj)     
        }
        
        $scope.getAssessmentsForAssessmentType = function(){
            assessmentsService.getAssessmentsForAssessmentType($scope.myAssessmentType,  $scope.myGrade, $scope.mySubject)
                .then(function(result){
                    $scope.assessments = result.data;                    
                });
        };
        
    }]);
    
})(angular, myApp);
