(function(angular, app) {
    "use strict";
    app.service("assessService",["$http", function($http) {
        var getStudentAssessment = function(){
            var url = "/admissions/get_assessment_students.json"
            return $http.get(url);
        };

        var getStaffAssessment = function(){
            var url = "/staffrecruits/get_staff_assessment.json"
            return $http.get(url);
        };

        var getAssessmentStaff = function(){
            var url = "/staffrecruits/get_assessment_staff.json"
            return $http.get(url);
        };
        return {
            getStudentAssessment : getStudentAssessment,
            getAssessmentStaff : getAssessmentStaff,
            getStaffAssessment : getStaffAssessment
        };
    }]);
})(angular, myApp);
        
