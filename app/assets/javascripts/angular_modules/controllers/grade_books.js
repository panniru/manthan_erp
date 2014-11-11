(function(angular, app) {
    "use strict";
    app.controller("GradeBooksController",["$scope", "gradeBooksService", function($scope,  gradeBooksService) {
        //alert();
        gradeBooksService.getGradesService()
            .then(function(result) {                
                $scope.grades=result.data  
                //alert(JSON.stringify($scope.grades));
            });

        gradeBooksService.getGradeBooksService()
            .then(function(result) {                
                $scope.grade_books=result.data  
                alert(JSON.stringify($scope.grade_books));
            });

   
    }]);
})(angular, myApp);

