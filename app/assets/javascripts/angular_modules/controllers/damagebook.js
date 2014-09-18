(function(angular, app) {
    "use strict";
    app.controller("DamagebooksController",["$scope", "resourceService", "damageBookService", "bookService","blockBookService", function($scope, resourceService, damageBookService, bookService,blockBookService) {
        damageBookService.getDamageBooksService()
            .then(function(result) {
                $scope.damage_books = result.data;                
            });

        bookService.getbookServiceView()
            .then(function(result) {                
                $scope.damagebooks = result.data
            });

        $scope.showDamageBooks = function(){
            bookService.getbookServiceView()
                .then(function(result) {                   
                    $scope.damagebooks = result.data
                });
        };        

        $scope.Go = function(){
            blockBookService.getBooks($scope.myIsbn)
                .then(function(result) {
                    $scope.books=result.data;                    
                    $scope.bookName = result.data[0]['name']
                    $scope.authorName = result.data[0]['author']                   
                    $scope.book_id = result.data[0]['id']                                       
                }); 
        };

        $scope.submit = function(){            
            var isbn = $("#isbn").val()
            blockBookService.damageBooks($scope.book_id,$scope.myIsbn,$scope.bookName,$scope.authorName,$scope.bookStage,$scope.damageType,$scope.damageDescription)
                .then(function(result) {
                    $scope.books=result.data
                });
            $('#myModal').modal('hide');   
            $scope.showDamageBooks();
        };      

        $scope.destroy = function(damage_book){
            resourceService.DamageBook.delete({id: damage_book.id})
            $scope.showDamageBooks();
               
        };  

       
       
    }]);
})(angular, myApp)



