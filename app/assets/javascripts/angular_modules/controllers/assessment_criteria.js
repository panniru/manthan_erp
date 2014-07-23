(function(angular, app) {
    "use strict";
    app.controller('AssessmentCriteriaController',["$scope", "assessmentCriteriaService", function($scope, assessmentCriteriaService) {  
        $scope.myShowFormValue = "true";
        $scope.FormValue = "false";

        assessmentCriteriaService.getAssessmentCriteriaService()
            .then(function(result) {
                $scope.assessments = result.data; 
                //alert(JSON.stringify($scope.assessments));
            });
        


    }]);    
    
})(angular, myApp);
