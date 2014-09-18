(function(angular, app) {
    "use strict";
    app.service("blockBookService",["$http", function($http) {
        var getbookServiceView = function(){
            var url = "/block_books/get_book_service_view.json"
            return $http.get(url);
        };

        var getBooks = function(myIsbn){
            var url = "/block_books/getbooks.json"
            return $http.get(url,{params:{my_Isbn: myIsbn}}); 
        }; 
      
        var saveBooks = function(bookId,myBlock,myIsbn,bookName,authorName){
            var url = "/block_books/savebooks.json"
            return $http.post(url,{book_Id: bookId, my_Block: myBlock,my_Isbn: myIsbn,book_Name: bookName,author_Name: authorName});
        };

        var damageBooks = function(bookId,myIsbn,bookName,authorName,bookStage,damageType,damageDescription){
            var url = "/damagebooks/damagebooks.json"
            return $http.post(url,{book_Id: bookId, my_Isbn: myIsbn,book_Name: bookName,author_Name: authorName,book_Stage: bookStage,damage_Type: damageType,damage_Description: damageDescription});
        };       
            
        return {
            getbookServiceView : getbookServiceView,
            getBooks : getBooks,
            saveBooks : saveBooks,
            damageBooks : damageBooks
        };
    }]);
})(angular, myApp);
