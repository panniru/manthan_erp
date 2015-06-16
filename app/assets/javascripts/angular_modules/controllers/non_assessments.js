(function(angular, app) {
    "use strict";
    app.controller('NonAssessmentsController', ["$scope", "assessmentsService", "timeTableService", "academicsService", function($scope, assessmentsService, timeTableService, academicsService) {        

        timeTableService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data;               
            });



        $scope.addAssessments = function(){
            $scope.add_assessments = [];
            academicsService.getNonAcademicsSubjects()
                .then(function(result) {
                    $scope.subject_masters=result.data;
                });

            assessmentsService.getNonAssessmentGradeMappings()
                .then(function(result) {
                    $scope.assessment_types=result.data;
                  
                });  
            
            $scope.add_assessments.push({
                assessment_name : "",
                assessment_grade_mapping_id : "",
                subject_master_id : ""
            });                      
            // alert(JSON.stringify($scope.add_assessments))
        };

        $scope.saveNonAssessments = function(){
            assessmentsService.saveNonAssessments($scope.add_assessments)
                .then(function(result) {
          
                    $scope.showAssessments();                    
                });
        };

        
        $scope.showAssessments = function(myGrade,mySection){
            assessmentsService.getNonAssessments()
                .then(function(result) {  
                    $scope.assessments = result.data;
                    alert(JSON.stringify($scope.assessments))
                }); 
        };

        $scope.getSubjects = function (myGrade){
            //alert(myGrade);
            academicsService.getNonAcademicsSubjectsForGradeService(myGrade)
                .then(function(result) {
                    alert(JSON.stringify($scope.subjects))
                    $scope.subjects=result.data;
                });
        };

        $scope.showAssessmentMappings = function(myGrade,mySubject){
            assessmentsService.getAssessmentMappingsService(myGrade,mySubject)
                .then(function(result){
                    $scope.assessments = result.data;
                });
        };

        $scope.addAssessmentCriteria = function(assessment_id)
        {
            $scope.getAssessmentCriteria(assessment_id);
            $scope.selected_assessment_id = assessment_id;
            $scope.criteria = [];
            $scope.criteria.push({
                assessment_id : $scope.selected_assessment_id, 
                assessment_criteria : "",
            });            
            $('#assessmentCriteriaModal').modal('show');             
        };

        $scope.addCriteria = function(){	   
            $scope.criteria.push({
                assessment_id : $scope.selected_assessment_id, 
                assessment_criteria : "",
            });           
        };

        $scope.destroyCriteria = function($index){
            $scope.criteria.splice($index, 1);            
        };

        $scope.saveAssessmentCriteria = function(){
             assessmentsService.saveAssessmentCriteria($scope.criteria)
                .then(function(result) {
                    $scope.showAssessments();       
                    $('#assessmentCriteriaModal').modal('hide');            
                });
        };






    }]);    
})(angular, myApp);

