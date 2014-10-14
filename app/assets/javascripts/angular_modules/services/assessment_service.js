(function(angular, app) {
    "use strict";
    app.service("assessService",["$http", function($http) {
        var getStudentAssessment = function(){
            var url = "/admissions/get_assessment_students.json"
            return $http.get(url);
        };
        
        return {
            getStudentAssessment : getStudentAssessment,
        };
    }]);
})(angular, myApp);
        
