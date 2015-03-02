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
	
	return {
	    getLabNames : getLabNames,
	    getGradeNames : getGradeNames,
	    saveCriteria : saveCriteria,
	    getAssessmentCriteria : getAssessmentCriteria ,
	    deleteAssessmentCriteriaMappings : deleteAssessmentCriteriaMappings
	};
    }]);
})(angular, myApp);
