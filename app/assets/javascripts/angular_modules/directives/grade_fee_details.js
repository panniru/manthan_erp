(function(angular, app) {
    "use strict";
    app.directive('gradeFeeDetails', function(){
        return{
            restrict: 'E',
            controller: ["$scope", "$attrs", "$http",  function($scope, $attrs, $http) {
                var url = "/grade_wise_fees/grade_wise_fee_of_student.json?student_id="+$attrs.studentId
                $http.get(url)
                    .then(function(response){
                        $scope.grade = response.data.grade;
                        $scope.fee_types = response.data.fee_details;
                        $scope.total = response.data.total;
                    });
            }],
            templateUrl: 'grade_fee_details.html'
        };
    });
})(angular, myApp);
