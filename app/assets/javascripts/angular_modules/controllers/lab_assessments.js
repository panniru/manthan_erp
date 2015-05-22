(function(angular, app) {
    "use strict";
    app.controller('LabAssessmentsController', ["$scope", "labAssessmentService", function($scope, labAssessmentService) { 
       
        $scope.editAssessmentTypeMappings = function(assessment_type){          
            $scope.edit_assessment_types = [];
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });                      
        };

    }]);
})(angular, myApp);
