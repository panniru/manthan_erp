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
                    $scope.books=result.data;
                    $('#myModal').modal('hide');   
                    $scope.showDamageBooks();
                });
           
        };      

        $scope.destroy = function(damage_book){
            if(confirm("Are you sure want to delete")){
                $scope.damage_books.splice($scope.damage_books.indexOf(damage_book), 1);
                resourceService.DamageBook.delete({id: damage_book.id});
                $scope.showDamageBooks();
            }else{
            }
        };  
        
        $scope.viewBookStage = function(){
            if ($scope.bookStage == 'LOSS'){
                $scope.viewDamageType = true;
                $scope.viewDamageDesc = false;              
            }
            if ($scope.bookStage == 'DAMAGE'){
                $scope.viewDamageType = false;
                $scope.viewDamageDesc = true;
            }
        };
            
       
       
    }]);
})(angular, myApp)



