(function(angular, app) {
    "use strict";
    app.controller("StudentsController",["$scope", "studentService", "resourceService", function($scope, studentService, resourceService) {
        $scope.students = []
        $scope.student = {}
        
        $scope.getStudentDetails = function(student_id){
            studentService.student_details(student_id).then(function(student) {
                $scope.student = student.data
            });
        };
        
        $scope.bookIssuings = function(student_id){
            studentService.book_issuings(student_id)
                .then(function(response){
                    $scope.books = response.data
                    $scope.book_names = $.map(response.data, function(value, key){
                        return key
                    });
                });
        }

        $scope.showBookDetails = function(book){
            var book_id = $scope.books[book][0]['book_id']
            if(typeof $scope.books[book+"Details"] != 'undefined'){
            }else{
                $scope.books[book+"_details"] = resourceService.Book.get({id: book_id})
            }
            $scope.books[book+"_shown"] = true;
        }
    }]);
    
})(angular, myApp);
