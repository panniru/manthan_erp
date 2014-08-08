(function(angular, app) {
    "use strict";
       app.service("klassService",["$http", function($http) {
            var getKlassServiceView = function(){
                var url = "/staff_admissions/get_klass_view.json"
                return $http.get(url);
            };
            return {
                getKlassServiceView : getKlassServiceView
            };
       }]);
})(angular, myApp);
