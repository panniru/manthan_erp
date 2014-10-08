(function(angular, app) {
    "use strict";
    app.service("gradeService",["$http", function($http) {      
        
        var allGrades = function(){
            var url = "/fee_grade_buckets/all_grades.json"
            return $http.get(url);
        } 
        
        return {
           
            allGrades : allGrades,            
        };
        
    }]);
})(angular, myApp);
