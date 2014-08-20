(function(angular, app) {
    "use strict";
    app.controller("DamagebooksController",["$scope","bookService","blockBookService", function($scope, bookService,blockBookService) {
        bookService.getbookServiceView()
            .then(function(result) {
                //alert(JSON.stringify(result.data))
                $scope.damagebooks = result.data
            });
        $scope.Go = function(){
            blockBookService.getBooks($scope.myIsbn)
                .then(function(result) {
                    $scope.books=result.data
                    $scope.bookName = result.data[0]['name']
                    $scope.authorName = result.data[0]['author']
                    
                }); 
        };
        $scope.submit = function(){
            
            var isbn = $("#isbn").val()
            blockBookService.damageBooks($scope.myIsbn,$scope.bookName,$scope.authorName,$scope.bookStage,$scope.damageType,$scope.damageDescription)
            
                .then(function(result) {
                    $scope. books=result.data
                });
        };
    }]);
})(angular, myApp)



