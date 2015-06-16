(function(angular, app) {
    "use strict";
    app.service("na_assessmentResultsClassTeacherService",["$http", function($http) {
        
        var getNonAssessmentsService = function(){
            var url = "/na_assessment_results/get_non_assessments_service.json"
            return $http.get(url);
        }; 
        
        return {
            getNonAssessmentsService : getNonAssessmentsService
            
        }
    }]);
})(angular, myApp);    
