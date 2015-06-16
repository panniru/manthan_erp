(function(angular, app) {
    "use strict";
    app.service("assessmentResultsClassTeacherService",["$http", function($http) {
        var getAssessmentsService = function(){
            var url = "/assessment_results/get_assessments_service.json"
            return $http.get(url);
        }; 

        return {
            getAssessmentsService :  getAssessmentsService,

        }        
    }]);    
})(angular, myApp);
