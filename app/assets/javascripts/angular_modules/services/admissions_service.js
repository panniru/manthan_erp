(function(angular, app) {
    "use strict";
    app.service("admissionsService",["$http", function($http) {
        var getKlassServiceView = function(){
            var url = "/admissions/get_klass_view.json"
            return $http.get(url);
        };

        return {
            getKlassServiceView : getKlassServiceView,
        };
    }]);
})(angular, myApp);
