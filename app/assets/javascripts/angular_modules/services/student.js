(function(angular, app) {
    "use strict";
    app.service("studentService",["$http", function($http) {

        var student_details = function(student_id){
            var url = "/student_masters/"+student_id+".json"
            return $http.get(url);
        }
        
        return {
            student_details : student_details
        };
        
    }]);
})(angular, myApp);
