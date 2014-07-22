(function(angular, app) {
    "use strict";
    app.service("studentService",["$http", "$q",  function($http, $q) {

        var student_details = function(student_id){
            var url = "/student_masters/"+student_id+".json"
            return $http.get(url);
        }

        var book_issuings = function(student_id){
            var deferred = $q.defer();
            $http.get("/issuings/student_book_issuings.json?student_id="+student_id)
                .then(function(data){
                    deferred.resolve(data)
                },function(error){
                    deferred.reject(data)
                });
            
            return deferred.promise;
        }

        return {
            student_details : student_details,
            book_issuings : book_issuings
        };
        
    }]);
})(angular, myApp);
