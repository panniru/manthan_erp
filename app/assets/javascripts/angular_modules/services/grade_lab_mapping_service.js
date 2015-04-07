(function(angular, app) {
    "use strict";
    app.service("gradeLabMappingService" , ["$http", function($http) {
	
	var getLabNames = function(){
	    var url = "/grade_lab_mappings/all_subjects.json"
	    return $http.get(url);
        };
        var saveSubjectsMappings = function(grades_subjects){
            
            var url = "/grade_lab_mappings/save_subjects_mappings.json"
            return $http.post(url, {mappings: grades_subjects});    
        };
        var getSubjectsGradesServiceView = function(){
            
            var url = "/grade_lab_mappings/get_subjects_grades_service_view.json"
            return $http.get(url);
        }; 
        // var getSubjectsGradesMappings = function(){
            
        //     var url = "/grade_lab_mappings/get_subjects_grades_mappings.json"
        //     return $http.get(url);
        // }; 

	
	return {
	    getLabNames : getLabNames,
            saveSubjectsMappings : saveSubjectsMappings,
            getSubjectsGradesServiceView : getSubjectsGradesServiceView
            // getSubjectsGradesMappings : getSubjectsGradesMappings
	};
    }]);
})(angular , myApp);

