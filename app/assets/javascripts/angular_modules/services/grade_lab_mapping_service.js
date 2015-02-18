(function(angular, app) {
    "use strict";
    app.service("gradeLabMappingService" , ["$http", function($http) {
	
	var getLabNames = function(){
	    var url = "/grade_lab_mappings/all_subjects.json"
	    return $http.get(url);
        };
	
	return {
	    getLabNames : getLabNames
	};
    }]);
})(angular , myApp);

