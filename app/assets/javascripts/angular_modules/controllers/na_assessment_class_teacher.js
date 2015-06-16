(function(angular, app) {
    "use strict";
    app.controller('NonAssessmentResultsClassTeacherController', ["$scope", "na_assessmentResultsClassTeacherService", "assessmentResultsService", "gradeService",function($scope, na_assessmentResultsClassTeacherService, assessmentResultsService, gradeService) {       
        
        // gradeService.getGradeServiceView()
        //     .then(function(result) {
        //         $scope.grades=result.data;               
        //     });


        na_assessmentResultsClassTeacherService.getNonAssessmentsService()
            .then(function(result){               
                $scope.non_teacher_assessments = result.data;                 
            });
        
        



        
    }]);     
})(angular, myApp);
