(function(angular, app) {
    "use strict";
    app.service("labService" , ["$http", function($http) {
	var getLabNames = function(){
	    var url = "/lab_criterias/get_lab_masters.json"
	    return $http.get(url);
        };
	var getGradeNames = function(){
	    var url = "/lab_criterias/get_all_grades.json"
	    return $http.get(url);
        };
	var saveCriteria = function(assessment_criterias){
            var url = "/lab_criterias/save_assessment_criterias.json"
            return $http.post(url, {criterias: assessment_criterias});          
        };
	var getAssessmentCriteria = function(labName){
	    var url = "/lab_criterias/get_assessment_criteria.json"
	    return $http.get(url,{params:{lab_name: labName}});
	};
	var deleteAssessmentCriteriaMappings = function(delete_mapping_id){
            var url = "/lab_criterias/deletemappings.json"
            return $http.post(url, {delete_mapping_id: delete_mapping_id}); 
        };
        // LABASSESSMENT 
        var getAssessmentTypesService = function(){
            var url = "/lab_assessments/get_assessment_types_service.json"
            return $http.get(url);
        }; 
        var saveAssessmentTypeMappings = function(save_assessment_types){            
            var url = "/lab_assessments/save_assessment_type_mappings.json"
            return $http.post(url, {mappings: save_assessment_types});    
        }; 
        var deleteAssessmentTypeMappings = function(delete_mapping_id){
            var url = "/lab_assessments/delete_assessment_type_mappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };
        //MAPPINGS
        var getAssessmentGradeMappingsService = function(){
            var url = "/lab_assessments/get_grade_mappings_service.json"
            return $http.get(url);
        }; 
        var saveAssessmentGradeMappings = function(save_assessment_grade_mappings){            
            var url = "/lab_assessments/save_assessment_grade_mappings.json"
            return $http.post(url, {mappings: save_assessment_grade_mappings});    
        }; 
        //show assessments
        // var getSectionsForGradeService = function(myGrade){
        //     var url = "/lab_assessments/get_sections_for_grade.json"
        //     return $http.get(url,{params:{my_Grade: myGrade}});
        // };  

	
	return {
	    getLabNames : getLabNames,
	    getGradeNames : getGradeNames,
	    saveCriteria : saveCriteria,
	    getAssessmentCriteria : getAssessmentCriteria ,
	    deleteAssessmentCriteriaMappings : deleteAssessmentCriteriaMappings,
            saveAssessmentTypeMappings :saveAssessmentTypeMappings,
            getAssessmentTypesService :getAssessmentTypesService,
            deleteAssessmentTypeMappings :deleteAssessmentTypeMappings,
            getAssessmentGradeMappingsService :getAssessmentGradeMappingsService,
            saveAssessmentGradeMappings :saveAssessmentGradeMappings
            // getSectionsForGradeService :getSectionsForGradeService 

	};
    }]);
})(angular, myApp);
