(function(angular, app) {
    "use strict";
    app.controller('TermResultsController', ["$scope", "termResultsService", "assessmentsTeacherService", "gradingService", function($scope, termResultsService, assessmentsTeacherService, gradingService) {     
        $scope.initiateMail = function(term_name){
            $scope.myMailSubject = "Regarding"+"  "+term_name+"  "+"Results";            
            $('#mailSubjectModal').modal('show');          
        };
        
        gradingService.getGradingServiceView()
            .then(function(result) {                
                $scope.gradings = result.data;   
                //alert(JSON.stringify($scope.gradings));     
                //$scope.initialize();
            });

        $scope.selectTermResults = function(term_id,term_name){  
            $scope.academic_Term_Id = term_id;
            //alert(JSON.stringify(term_id+" "+term_name));
            //$scope.myMailSubject = "Regarding"+"  "+term_name+"  "+"Results"; 

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
            //alert(JSON.stringify($scope.myGradeSection));           
            termResultsService.getStudentDetailsService($scope.myGradeSection.grade_master_id, $scope.myGradeSection.section_master_id)
                .then(function(result){                   
                    $scope.students = result.data; 
                    //alert(JSON.stringify($scope.students));
                });

            termResultsService.getSubjectAssessmentCriteriaService($scope.myGradeSection.grade_master_id, $scope.myGradeSection.subject_master_id)
                .then(function(result){                   
                    $scope.assessment_criteria = result.data; 
                    alert(JSON.stringify($scope.assessment_criteria));
                });

            termResultsService.getTermResultsService($scope.academic_Term_Id, $scope.myGradeSection.grade_master_id, $scope.myGradeSection.section_master_id, $scope.myGradeSection.subject_master_id)
                .then(function(result) {               
                    $scope.term_results = result.data; 
                    alert(JSON.stringify($scope.term_results));                   
                });
            
        };

        $scope.saveTermResults = function(){   
            alert();
        };
        

    }]);
})(angular, myApp);

