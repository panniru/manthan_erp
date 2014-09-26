(function(angular, app) {
    "use strict";
    app.controller("DonateBooksController",["$scope","resourceService", "donateBooksService", function($scope, resourceService, donateBooksService) {         
        $scope.donate_books = resourceService.DonateBook.query();  

    }]);  
    
})(angular, myApp);
