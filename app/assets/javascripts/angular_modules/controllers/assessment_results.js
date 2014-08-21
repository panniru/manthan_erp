(function(angular, app) {
    "use strict";
    app.controller('AssessmentResultsController', ["$scope", "$location", "assessmentsTeacherService", "assessmentResultsService", "gradingService", function($scope, $location, assessmentsTeacherService, assessmentResultsService, gradingService) {        
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

        assessmentResultsService.getTeacherAssessmentsService()
            .then(function(result){               
                $scope.teacher_assessments = result.data;                
            });
        
        $scope.buildEeditAssessmentResults = function(assessment){            
            $scope.edit_Assessment_Results = [];
            $scope.students = [];
            
            //getStudentsForGradeAndSectionService
            assessmentResultsService.getStudentDetailsService(assessment.grade_master_id, assessment.section_master_id)
                .then(function(result){                   
                    $scope.students = result.data;  
                   
                    for (var i = 0; i < result.data.length; i++){
                        $scope.edit_Assessment_Results.push({
                            id: "",
                            assessment_listing_id: assessment.id,
                            student_master_id: $scope.students[i]['id'],
                            student_name: $scope.students[i]['student_name'],
                            grading_master_id: "",
                            grading_name: "",
                            assessment_result_desc: "", 
                        });                
                    }                    
                });
            
            gradingService.getGradingServiceView()
                .then(function(result) {                     
                    $scope.gradings = result.data;
                });
        };

        $scope.editAssessmentResults = function(){  
            gradingService.getGradingServiceView()
                .then(function(result) {                     
                    $scope.gradings = result.data;
                });
            $scope.edit_Assessment_Results = $scope.show_Assessment_Results;           
        };      

        $scope.showAssessmentResults = function(assessment){
            $scope.assessment_Listing = assessment;            
            $scope.show_Assessment_Results = []; 

            assessmentResultsService.getAssessmentResultsService(assessment.id)
                .then(function(result) {  
                    $scope.show_Assessment_Results = result.data;                   
                    if(result.data.length == 0){                       
                        var path = "/";
                        path = "/assessment_results/add_form";
                        $location.path(path); 
                        $scope.buildEeditAssessmentResults(assessment);                      
                    }
                }); 
        };

        $scope.saveAssessmentResults = function(){           
            $scope.save_Assessment_Results = [];
            
            for (var i=0; i< $scope.edit_Assessment_Results.length; i++){
                $scope.save_Assessment_Results.push({
                    id: $scope.edit_Assessment_Results[i]['id'],
                    assessment_listing_id: $scope.edit_Assessment_Results[i]['assessment_listing_id'],
                    student_master_id: $scope.edit_Assessment_Results[i]['student_master_id'],
                    grading_master_id: $scope.edit_Assessment_Results[i]['grading_master_id'],
                    assessment_result_desc: $scope.edit_Assessment_Results[i]['assessment_result_desc'],
                });
            }
            
            assessmentResultsService.saveAssessmentResultsService($scope.save_Assessment_Results)
               .then(function(result) {                    
               });

            $scope.showAssessmentResults($scope.assessment_Listing);           
        };


    $scope.showStudentsAssessmentResults = function(mapping){
        $scope.student_mapping = mapping;            
            assessmentResultsService.getAssessmentResultsService(mapping.id)
                .then(function(result) {  
                    $scope.show_Assessment_Results = result.data;                                       
                }); 
        };
       
    }]);    
})(angular, myApp);
