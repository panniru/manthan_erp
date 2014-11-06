(function(angular, app) {
    "use strict";
    app.controller('AssessmentResultsClassTeacherController', ["$scope", "assessmentResultsClassTeacherService", "assessmentResultsService", "gradeService",function($scope, assessmentResultsClassTeacherService, assessmentResultsService, gradeService) {       
        assessmentResultsClassTeacherService.getAssessmentsService()
            .then(function(result){               
                $scope.teacher_assessments = result.data;                 
            });
        // gradeService.getGradeServiceView()
        //     .then(function(result) {
        //         $scope.grades=result.data;               
        //     });
        
       



        
    }]);     
})(angular, myApp);
