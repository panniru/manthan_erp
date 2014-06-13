(function(angular, app) {
    "use strict";
    app.service("gradeService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/time_tables/gradeserviceview.json"
            return $http.get(url);
        };

        var savePeriods = function(timeperiods){
            alert("hello");
            var url = "/time_tables/saveperiods.json"
            return $http.post(url, {time_periods: timeperiods});
            
        };
        
        
        return {
            getGradeServiceView : getGradeServiceView,
            savePeriods : savePeriods
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

    app.service("subjectService",["$http", function($http) {
        var getSubjectServiceView = function(){
            var url = "/time_tables/subjectserviceview.json"
            return $http.get(url);
        };
        
        return {
            getSubjectServiceView : getSubjectServiceView
        };
        
    }]);

   

})(angular, myApp);
