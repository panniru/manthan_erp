(function(angular, app) {
    "use strict";
    app.service("studentService",["$http", "$q", "$resource",  function($http, $q, $resource) {

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
        var Student = $resource('/student_masters/:id.json', {id: '@id'}, 
                             {
                                 "update_address": { url: "/student_masters/:id/update_address.json", method:'PUT', params: {address: '@address'}},
                             }
                            );
        
        return {
            student_details : student_details,
            book_issuings : book_issuings,
            Student : Student
        };
        
    }]);
})(angular, myApp);
