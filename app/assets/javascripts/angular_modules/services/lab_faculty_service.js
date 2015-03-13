(function(angular, app) {
    "use strict";
    app.service("labFacultyService",["$http", function($http) {
        var getLabFacultyIdView = function(){
            var url = "/lab_masters/get_faculty_id_view.json"
            return $http.get(url);
        };
        return {
            getLabFacultyIdView : getLabFacultyIdView
        };
    }]);
})(angular, myApp);
