(function(angular, app) {
    "use strict";
    app.service("staffassessmentService",["$http", function($http) {
        var getAssessmentStaff = function(){
            var url = "/staffrecruits/get_assessment_staff.json"
            return $http.get(url);
        };

        var getAssessmentStudent = function(){
            var url = "/admissions/get_assessment_students.json"
            return $http.get(url);
        };

        var getDesignations = function(){
            var url = "/staffadmins/get_designation.json"
            return $http.get(url);
        };


        return {
            getAssessmentStaff : getAssessmentStaff,
            getAssessmentStudent : getAssessmentStudent,
            getDesignations : getDesignations
        };
        
    }]);
})(angular, myApp);
