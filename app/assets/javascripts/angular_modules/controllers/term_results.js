(function(angular, app) {
    "use strict";
    app.controller('TermResultsController', ["$scope", "$window", "termResultsService", "assessmentsTeacherService", "gradingService", "academicTermsService", function($scope, $window, termResultsService, assessmentsTeacherService, gradingService, academicTermsService) {  
        //alert();
        $scope.showTriggerForm = false;
        $scope.showShowForm = true;
        $scope.student_Result = false;
        $scope.teacher_view_term_Result = false;  
        

        $scope.showTrigger = function()
        {
            $scope.showTriggerForm = true;
            $scope.showShowForm = false;
        }

        $scope.showShow = function()
        {
            $scope.showTriggerForm = false;
            $scope.showShowForm = true;
        }
        
        gradingService.getGradingServiceView()
            .then(function(result) {                
                $scope.gradings = result.data; 
            });
 
        //Principal View Of Trigger Term Results
        $scope.initiateMail = function(term_name){
            $scope.myMailSubject = "Regarding"+"  "+term_name+"  "+"Results";            
            $('#mailSubjectModal').modal('show');          
        };         
       
        $scope.selectTermResults = function(academic_term){            
            $scope.academic_Term_Id = academic_term.id;
            $scope.teacher_view_term_Result = true;
            $scope.teacher_view_select_term_Result = false;
            
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
            
            $('#termResultsModal').modal('show');     
            
        };

        $scope.getTermResults = function(){ 
            $scope.teacher_view_select_term_Result = true;
            termResultsService.getStudentDetailsService($scope.myGradeSection.grade_master_id, $scope.myGradeSection.section_master_id)
                .then(function(result){                   
                    $scope.students = result.data;                   
                });

            termResultsService.getSubjectAssessmentCriteriaService($scope.myGradeSection.grade_master_id, $scope.myGradeSection.subject_master_id)
                .then(function(result){                   
                    $scope.assessment_criteria = result.data;                   
                });

            termResultsService.getTermResultsService($scope.academic_Term_Id, $scope.myGradeSection.grade_master_id, $scope.myGradeSection.section_master_id, $scope.myGradeSection.subject_master_id)
                .then(function(result) {               
                    $scope.term_results = result.data;                                 
                });            
        };

        $scope.editTermResults = function(student,grading_name){           
            $scope.edit_term_results = [];  
            $scope.assessment_criteria_gardings = [];
           
            $scope.assessment_criteria_gardings.push({
                assessment_criteria_id: "",
                grading_master_id: "",    
            });

            $scope.edit_term_results.push({
                id: "",
                academic_term_id: $scope.academic_Term_Id,
                grade_master_id: $scope.myGradeSection.grade_master_id,
                section_master_id: $scope.myGradeSection.section_master_id,
                subject_master_id: $scope.myGradeSection.subject_master_id,
                student_master_id: student.id,
                student_name: student.student_name,
                assessment_criteria_gardings: $scope.assessment_criteria_gardings,                             
            });           
            $('#myEditTermResultsModal').modal('show');      
        };
        
        $scope.saveTermResults = function(){           
            termResultsService.saveTermResultsService($scope.edit_term_results)
                .then(function(result) {                     
            });
            $scope.showTermResults();            
        };   

        $scope.showTermResults = function(){  
            $('#myEditTermResultsModal').modal('hide');  
            $scope.getTermResults();
        };    
       
        //Principal View Of Term Results
        termResultsService.getGradesSectionsService()
            .then(function(result) {                
                $scope.mappings = result.data; 
                $scope.grades_sections = [];
                
               
                for(var i=0; i<result.data.length; i++){
                    $scope.grades_sections.push({
                        grade_master_id: $scope.mappings[i]['grade_master_id'],
                        section_master_id: $scope.mappings[i]['section_master_id'],
                        student_grade_section: $scope.mappings[i]['grade_name']+" - "+$scope.mappings[i]['section_name'],                    });
                }               
            });
        
        academicTermsService.getAcademicTermsService()
            .then(function(result) {                     
                $scope.academic_terms = result.data;                
            });
        
        $scope.getGradeSectionStudents = function(){  
            $scope.student_Result = false;
            
            termResultsService.getStudentDetailsService($scope.studentGradeSection.grade_master_id, $scope.studentGradeSection.section_master_id)
                .then(function(result){                   
                    $scope.students = result.data;                   
                });

            termResultsService.getGradeSubjectsService($scope.studentGradeSection.grade_master_id)
                .then(function(result){ 
                    $scope.grade_subjects = [];
                    $scope.grade_subjects = result.data;                   
                    $scope.subject_wise_criteria = [];

                    for(var i=0; i<$scope.grade_subjects.length;i++){
                        termResultsService.getSubjectAssessmentCriteriaService($scope.studentGradeSection.grade_master_id, $scope.grade_subjects[i]['subject_master_id'])
                            .then(function(result){                   
                                $scope.assessment_criteria = result.data;  
                                $scope.subject_wise_criteria.push({                                    
                                    assessment_criteria:  $scope.assessment_criteria,
                                });                                
                            });
                    }                  
                });          
        };        
        
        $scope.showStudentTermResults = function(academic_term,student){ 
            $scope.student_Result = true;
            $scope.academic_Term_Id = academic_term.id;            
            $scope.student_master_id = student.id;
            
            $('#myStudentTermResultsModal').modal('show');   
            termResultsService.getStudentTermResultsService($scope.academic_Term_Id, $scope.student_master_id, $scope.studentGradeSection.grade_master_id, $scope.studentGradeSection.section_master_id)
                .then(function(result) {               
                    $scope.term_results = result.data;                  
                });         
        };


        

    }]);
})(angular, myApp);
