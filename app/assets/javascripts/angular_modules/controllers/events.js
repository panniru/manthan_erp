(function(angular, app) {
    "use strict";
    app.controller('EventsController',["$scope", "eventsService",function($scope,eventsService) {
        
        eventsService.getFacultyServiceView()
            .then(function(result) {
                $scope.faculties=result.data
            });
    }]);
})(angular, myApp);
