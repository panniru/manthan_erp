(function(angular, app) {
    "use strict";
    app.service("nonAcademicsService",["$http", function($http) {

        var getNonAcademicsSubjects = function(){
            var url = "/non_academics/get_non_academics_subjects.json"
            return $http.get(url);
        };

        return {
            getNonAcademicsSubjects : getNonAcademicsSubjects           
        };    
    
    }]);    
})(angular, myApp);
