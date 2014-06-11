(function(angular, app) {
    "use strict";
    app.directive('studentHeaderDetails', function(){
        return{
            restrict: 'E',
            controller: function($scope, $attrs, $http) {
                var url = "/student_masters/"+$attrs.studentId+".json"
                $http.get(url)
                    .then(function(response){
                        $scope.student = response.data
                    });
            },
            templateUrl: 'student_header_details.html'
        };
    });
})(angular, myApp);
