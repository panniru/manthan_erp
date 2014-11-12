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

        var saveGradeBooksService = function(save_grade_book){
            var url = "/grade_books/save_grade_books_service.json"
            return $http.post(url,{ save_grade_book: save_grade_book});
        };
        
        return {
            getGradesService : getGradesService, 
            getGradeBooksService : getGradeBooksService,
            saveGradeBooksService : saveGradeBooksService
        };        
    }]);
})(angular, myApp);
