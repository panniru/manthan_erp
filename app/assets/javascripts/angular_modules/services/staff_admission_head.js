(function(angular, app) {
    "use strict";
    app.service("staffadmissionheadsService",["$http", function($http) {
        var getHeadServiceView = function(){
            var url = "/staff_admissions/get_head_view.json"
            return $http.get(url);
        };
        return {
            getHeadServiceView : getHeadServiceView
        };
    }]);
})(angular, myApp);
