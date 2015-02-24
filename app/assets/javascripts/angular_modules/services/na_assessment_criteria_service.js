(function(angular, app) {
    "use strict";
    app.service("na_assessmentCriteriaService",["$http", function($http) {
       
        var getAssessmentCriteriaService = function(myGrade){
            var url = "/na_assessment_criterias/get_assessment_criteria_service.json"
            return $http.get(url,{params:{my_Grade: myGrade}});
        };

        var saveAssessmentCriteriaMappings = function(assessment_criterias){
            var url = "/na_assessment_criterias/save_assessment_criterias.json"
            return $http.post(url, {mappings: assessment_criterias});          
        };

        var deleteAssessmentCriteriaMappings = function(delete_mapping_id){
            var url = "/na_assessment_criterias/deletemappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };

        return {
            getAssessmentCriteriaService : getAssessmentCriteriaService,
            saveAssessmentCriteriaMappings : saveAssessmentCriteriaMappings,
            deleteAssessmentCriteriaMappings : deleteAssessmentCriteriaMappings,
        }  
    }]);     
    
})(angular, myApp);
   
