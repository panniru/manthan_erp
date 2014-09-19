(function(angular, app) {
    "use strict";
    app.service("requestBooksService",["$http", function($http) {
        var getRequestBooksService = function(){
            var url = "/request_books/get_request_books.json"
            return $http.get(url);
        }; 
     
        var saveBooksService = function(bookId,myBlock,myIsbn,bookName,authorName){
            var url = "/block_books/savebooks.json"
            return $http.post(url,{book_Id: bookId, my_Block: myBlock,my_Isbn: myIsbn,book_Name: bookName,author_Name: authorName});
        };         
            
        return {
            getRequestBooksService : getRequestBooksService,
            saveBooksService : saveBooksService,
        };
    }]);
})(angular, myApp);
