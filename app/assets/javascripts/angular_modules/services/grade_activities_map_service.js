(function(angular, app) {
    "use strict";
    app.service("gradeActivitiesMapService",["$http", function($http) {
        var getGradeActivities = function(){
            var url = "/grades_activities_mappings/get_grade_activities.json"
            return $http.get(url);
        }; 
        
        var saveGradeActivitiesMappings = function(activities_grades){
            var url = "/grades_activities_mappings/save_grade_activities_mappings.json"
            return $http.post(url, {mappings: activities_grades});    
        };

        return {
            getGradeActivities : getGradeActivities,
            saveGradeActivitiesMappings : saveGradeActivitiesMappings
        }  
    }]);    

})(angular, myApp);
