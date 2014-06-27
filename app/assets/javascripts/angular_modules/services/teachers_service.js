(function(angular, app) {
    "use strict";
    app.service("teachersService",["$http", function($http) {
        var getFacultyNamesServiceView = function(){
            var url = "/teachers_time_tables/get_faculty_names_view.json"
            return $http.get(url);
        };
        var getFacultyGradeSectionsServiceView = function(){
            var url = "/teachers_time_tables/get_faculty_garde_sections_view.json"
            return $http.get(url);
        };

       
        return {
            getFacultyNamesServiceView : getFacultyNamesServiceView,
            getFacultyGradeSectionsServiceView : getFacultyGradeSectionsServiceView
        };        
    }]);   

})(angular, myApp);
