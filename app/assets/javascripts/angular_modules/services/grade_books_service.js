(function(angular, app) {
    "use strict";
    app.service("gradeBooksService",["$http", function($http) {
        var getGradesService = function(){
            var url = "/grade_books/get_grades_service.json"
            return $http.get(url);
        };

        var getGradeBooksService = function(){
            var url = "/grade_books/get_grade_books_service.json"
            return $http.get(url);
        };
        
        return {
            getGradesService : getGradesService, 
            getGradeBooksService : getGradeBooksService
        };        
    }]);
})(angular, myApp);
