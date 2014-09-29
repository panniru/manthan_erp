(function(angular, app) {
    "use strict";
    app.controller("DonateBooksController",["$scope","resourceService", "donateBooksService", function($scope, resourceService, donateBooksService) {         
        $scope.donate_books = resourceService.DonateBook.query();  

    
    $scope.editDonateBook = function(donate_book){
        //alert(JSON.stringify(donate_book));
        $scope.donate_book
        $('#myEditModal').modal('show');

    };
        $scope.updateDonateBook = function(donate_book){
            //alert(JSON.stringify(donate_book));
            $('#myEditModal').modal('hide');
            donateBooksService.updateDonateBook($scope.donate_book)
                .then(function(result){
                });
        };



    }]); 
})(angular, myApp);
