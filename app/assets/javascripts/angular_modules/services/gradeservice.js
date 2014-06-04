(function(angular, app) {
    "use strict";
    app.service("getGradeService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/time_tables/gradeserviceview.json"
            return $http.get(url);
        };
        
        return {
            getGradeServiceView : getGradeServiceView
        };
        
    }]);
    
    app.service("getSectionService",["$http", function($http) {
        var getSectionServiceView = function(){
            var url = "/time_tables/sectionserviceview.json"
            return $http.get(url);
        };
        
        return {
            getSectionServiceView : getSectionServiceView
        };
        
    }]);
})(angular, myApp);
