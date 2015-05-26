(function(angular, app) {
    "use strict";
    app.controller('NonAssessmentResultsController', ["$scope", "$location", "assessmentsTeacherService", "na_assessmentResultsService", "gradingService", function($scope, $location, assessmentsTeacherService, na_assessmentResultsService, gradingService) {        

        // na_assessmentResultsService.getNonAssessmentsService()
        //     .then(function(result){               
                
        //         $scope.teacher_assessments = result.data;                 
        //     });
        

        assessmentsTeacherService.getNonTeacherGradeMappings()
            .then(function(result) {               
                $scope.mappings = result.data;  
                $scope.teacher_non_grade_subject_mappings = [];
                
                for (var i=0; i< $scope.mappings.length; i++){
                    $scope.teacher_non_grade_subject_mappings.push({
                        id: $scope.mappings[i]['id'],
                        grade_master_id: $scope.mappings[i]['grade_master_id'],
                        section_master_id: $scope.mappings[i]['section_master_id'],
                        subject_master_id: $scope.mappings[i]['subject_master_id'],                       
                        teacher_grade_subject: $scope.mappings[i]['grade_name']+" - "+$scope.mappings[i]['section_name']+" - "+$scope.mappings[i]['subject_name'],                        
                    });
                }                     

            });

        na_assessmentResultsService.getTeacherAssessmentsService()
            .then(function(result){               
                $scope.teacher_assessments = result.data;
            });
        
        $scope.buildEeditAssessmentResults = function(assessment){            
            $scope.edit_Assessment_Results = [];
            $scope.students = [];
            
            //getStudentsForGradeAndSectionService
            na_assessmentResultsService.getStudentDetailsService(assessment.grade_master_id, assessment.section_master_id)
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
                            result_type: "",
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
            $scope.edit_Assessment_Results = $scope.show_Assessment_Resultss;           
        };      
        
        $scope.showAssessmentResults = function(assessment){
            $scope.assessment_Listing = assessment;            
            $scope.show_Assessment_Resultss = []; 

            na_assessmentResultsService.getAssessmentResultsService(assessment.id)
                .then(function(result) {  
                    $scope.show_Assessment_Resultss = result.data;                   
                    if(result.data.length == 0){                       
                        var path = "/";
                        path = "/assessment_results/add_non_form";
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
                    result_type: 'non_academics'
                    
                });
                
            }
            
            na_assessmentResultsService.saveAssessmentResultsService($scope.save_Assessment_Results)
                .then(function(result) {                    
                });
            
            $scope.showAssessmentResults($scope.assessment_Listing);           
        };
        
        $scope.showStudentsAssessmentResults = function(mappingg){
            $scope.studentt_mappingg = mappingg;            
            na_assessmentResultsService.getAssessmentResultsService(mappingg.id)
                .then(function(result) {  
                    $scope.show_Assessment_Resultss = result.data;    
                }); 
        };
        






    }]);    
})(angular, myApp);
