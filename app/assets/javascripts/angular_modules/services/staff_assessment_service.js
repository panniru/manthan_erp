(function(angular, app) {
    "use strict";
    app.service("staffassessmentService",["$http", function($http) {
        var getAssessmentStaff = function(){
            var url = "/staffrecruits/get_assessment_staff.json"
            return $http.get(url);
        };
        return {
            getAssessmentStaff : getAssessmentStaff
        };
        
    }]);
})(angular, myApp);
