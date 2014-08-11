(function(angular, app) {
    "use strict";
    app.service("issuingService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/issuings/gradeserviceview.json"
            return $http.get(url);
        };
        
        
        var getSectionServiceView = function(){
            var url = "/issuings/sectionserviceview.json"
            return $http.get(url);
        }; 
        return {
            getGradeServiceView : getGradeServiceView,
            getSectionServiceView : getSectionServiceView
        };
        
    }]);
})(angular, myApp);
