(function(angular, app) {
    "use strict";
    app.service("eventsService",["$http", function($http) {
        var getFacultyServiceView = function(){
            var url = "/events/get_faculty_view.json"
            return $http.get(url);
        };
        return {
            getFacultyServiceView : getFacultyServiceView
        };
    }]);
})(angular, myApp);
