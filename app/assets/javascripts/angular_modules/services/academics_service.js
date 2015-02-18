(function(angular, app) {
    "use strict";
    app.service("academicsService",["$http", function($http) {

        var getGrades = function(){
            var url = "/academics/get_grades.json"
            return $http.get(url);
        };

        var getAcademicSubjects = function(){
            var url = "/academics/get_academics_subjects.json"
            return $http.get(url);
        };

        return {
            getAcademicSubjects : getAcademicSubjects,
            getGrades : getGrades
        };    
        
    }]);    
})(angular, myApp);
