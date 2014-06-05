(function(angular, app) {
    "use strict";
    app.controller("StudentsController",["$scope", "studentService",  function($scope, studentService) {
        $scope.students = []
        $scope.student = {}
        
        $scope.getStudentDetails = function(student_id){
            studentService.student_details(student_id).then(function(student) {
                $scope.student = student.data
            });
        };
    }]);
    
})(angular, myApp);


