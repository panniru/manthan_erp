(function(angular, app) {
    "use strict";
    app.service("addsService",["$http", function($http) {
        var getDeptServiceView = function(){
            var url = "/adds/get_dept_view.json"
            return $http.get(url);
        };
        return {
            getDeptServiceView : getDeptServiceView
        };
    }]);
})(angular, myApp);
