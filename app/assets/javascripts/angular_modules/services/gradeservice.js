(function(angular, app) {
    "use strict";
    app.service("gradeService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/time_tables/gradeServiceView.json"
            return $http.get(url);
        };
        
        return {
            getGradeServiceView : getGradeServiceView
        };
        
    }]);
})(angular, myApp);
