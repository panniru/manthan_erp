(function(angular, app) {
    "use strict";
    app.service("assessmentsService",["$http", function($http) {
        var getAssessmentTypesService = function(){
            var url = "/assessments/get_assessment_types_service.json"
            return $http.get(url);
        }; 

        var saveAssessmentTypeMappings = function(save_assessment_types){            
            var url = "/assessments/save_assessment_type_mappings.json"
            return $http.post(url, {mappings: save_assessment_types});    
        }; 

        var deleteAssessmentTypeMappings = function(delete_mapping_id){
            var url = "/assessments/delete_assessment_type_mappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };
       
        return { 
            getAssessmentTypesService : getAssessmentTypesService,
            deleteAssessmentTypeMappings : deleteAssessmentTypeMappings,
            saveAssessmentTypeMappings : saveAssessmentTypeMappings,
        } 

        
    }]);    
})(angular, myApp);


