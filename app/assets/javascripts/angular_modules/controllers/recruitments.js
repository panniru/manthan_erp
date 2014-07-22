(function(angular, app) {
    "use strict";
    app.controller('RecruitmentsController',["$scope", "recruitmentsService",function($scope,recruitmentsService) {
        
        recruitmentsService.getSubjectServiceView()
            .then(function(result) {
                alert('hi');
                $scope.subjects=result.data
            });
    }]);
})(angular, myApp);
