(function(angular, app) {
    "use strict";
    app.controller('AssessmentCriteriaTeacherController',["$scope", "assessmentCriteriaTeacherService", function($scope, assessmentCriteriaTeacherService) { 

        assessmentCriteriaTeacherService.getGradeSubjectService()
            .then(function(result) {
                $scope.grade_subjects=result.data;
                $scope.teacher_grade_subjects = [];
                for (var i=0; i< $scope.grade_subjects.length; i++){
                    $scope.teacher_grade_subjects.push({
                        grade_master_id: $scope.grade_subjects[i]['grade_master_id'],
                        subject_master_id: $scope.grade_subjects[i]['subject_master_id'],                       
                        teacher_grade_subject: $scope.grade_subjects[i]['grade_name']+" - "+$scope.grade_subjects[i]['subject_name'],                
                    });
                }  
            });
        
        $scope.getAssessmentCriteria = function(){        
            assessmentCriteriaTeacherService.getAssessmentCriteria($scope.myGradeSubject.grade_master_id,$scope.myGradeSubject.subject_master_id)
                .then(function(result) {
                    $scope.assessment_criterias = result.data;                     
                });            
        };  

     
    }]);    
})(angular, myApp);
