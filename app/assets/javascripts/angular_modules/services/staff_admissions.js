(function(angular, app) {
    "use strict";
    app.service("staffsService",["$http", function($http) {
        var getPostServiceView = function(){
            var url = "/staff_admissions/get_post_view.json"
            return $http.get(url);
        };
        return {
            getPostServiceView : getPostServiceView
        };
    }]);
})(angular, myApp);
