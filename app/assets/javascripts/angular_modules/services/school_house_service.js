(function(angular, app) {
    "use strict";
    app.service("school_houses_service",["$http", function($http) {
        var getSchoolHouses = function(){
            var url = "/school_houses/get_school_houses.json"
            return $http.get(url);
        };

        return {
            getSchoolHouses : getSchoolHouses,
            
        };
        
    }]);
})(angular, myApp);
