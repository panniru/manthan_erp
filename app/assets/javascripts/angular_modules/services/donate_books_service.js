(function(angular, app) {
    "use strict";
    app.service("donateBooksService",["$http", function($http) {
        var updateDonateBook = function(donate_book){            
            var url = "/donate_books/update_donate_book.json"
            return $http.post(url, {donate_book: donate_book});    
        };
        var deleteDonateBook = function(donate_book){            
            var url = "/donate_books/delete_donate_book.json"
            return $http.post(url, {donate_book: donate_book});    
        };
             
        return{
            updateDonateBook : updateDonateBook,
            deleteDonateBook : deleteDonateBook
        }       
    }]);
})(angular, myApp);
