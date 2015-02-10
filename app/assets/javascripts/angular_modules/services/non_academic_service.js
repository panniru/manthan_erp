(function(angular, app) {
    "use strict";
    app.service("nonAcademicService",["$http", function($http) {

        var getActivities = function(){
            var url = "/grades_activities_mappings/get_activities.json"
            return $http.get(url);
        };

        return {
            getActivities : getActivities           
        };    
    
    }]);    
})(angular, myApp);
