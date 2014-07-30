(function(angular, app) {
    "use strict";
    app.controller('AssessmentsController', ["$scope", "assessmentsService", '$routeParams', function($scope, assessmentsService, $routeParams) { 
        //alert(JSON.stringify($routeParams));
        assessmentsService.getAssessmentTypesService()
            .then(function(result) {                 
                $scope.assessment_types = result.data; 
                //alert(JSON.stringify($scope.assessment_types));
            });       

        $scope.showAssessmentTypeMappings = function(){
            assessmentsService.getAssessmentTypesService()
                .then(function(result) {                 
                    $scope.assessment_types = result.data; 
                    //alert(JSON.stringify($scope.assessment_types));
                });
        };

        $scope.editAssessmentTypeMappings = function(assessment_type){ 
            alert(JSON.stringify(assessment_type));
            $scope.edit_assessment_types = [];
            
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });                      
        };

        $scope.saveAssessmentTypeMappings = function(assessment_type){           
            $scope.save_assessment_types = [];

            $scope.save_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });

            assessmentsService.saveAssessmentTypeMappings($scope.save_assessment_types)
                .then(function(result) {                    
                });

            $scope.showAssessmentTypeMappings();     
        };

        $scope.deleteAssessmentTypeMappings = function(assessment_type){           
            $scope.delete_mappping_id =assessment_type.id;
            
            assessmentsService.deleteAssessmentTypeMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                });  
            
            $scope.showAssessmentTypeMappings();            
        };



        
    }]);    
})(angular, myApp);
