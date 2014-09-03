(function(angular, app) {
    "use strict";
    app.controller('BooksController',["$scope","resourceService", function($scope, resourceService) {
        $scope.books = resourceService.Book.query();
        
        $scope.newBook = function(){
            $scope.newBooks = []
            for(var i=0; i<3; i++){
                $scope.newBooks.push({"name":"", "isbn" :"", "author": "", "year_of_publishing":"", "book_type":"" });
            };
            $('#createModal').modal('show')
        };
        $scope.submitBooks = function(){
            resourceService.Book.bulk({bulk_book: $scope.newBooks})
                .$promise.then(function(responce){
                    $scope.books = resourceService.Book.query()
                    $('#createModal').modal('hide')
                })
        }
            
        $scope.editBooks = function(){
            $scope.newBooks = $scope.Books
            $('#createModal').modal('show')
        }       
        $scope.destroy = function(book){
            book.$delete()
                .then(function(responce){
                    $scope.books.splice($scope.books.indexOf(book), 1)
                })
        };      
	$scope.addMorebooks = function(){
            var lnt = parseInt($scope.newBooks.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newBooks.push({"name":"", "isbn" :"", "author": "", "year_of_publishing":"",  "book_type":"" });
            };
        }
        
    }]);  
    
})(angular, myApp);
