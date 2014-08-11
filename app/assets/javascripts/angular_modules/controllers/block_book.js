(function(angular, app) {
    "use strict";
    app.controller("BlockbooksController",["$scope","blockBookService", function($scope, blockBookService) {
        blockBookService.getbookServiceView()
            .then(function(result) {
                $scope.block_books = result.data
            });
        $scope.Go = function(){  
            blockBookService.getBooks($scope.myIsbn)
                .then(function(result) {
                    alert(JSON.stringify(result.data))
                    $scope.books=result.data
                    $scope.bookName = result.data[0]['name']
                    $scope.authorName = result.data[0]['author']
                });            
        };
        
        $scope.save = function(){
            var isbn = $("#isbn").val()
           blockBookService.saveBooks($scope.myBlock,$scope.myIsbn,$scope.bookName,$scope.authorName)
                .then(function(result) {
                    $scope. books=result.data
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
