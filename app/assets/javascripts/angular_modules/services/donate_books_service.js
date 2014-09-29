(function(angular, app) {
    "use strict";
    app.service("donateBooksService",["$http", function($http) {
        var updateDonateBook = function(donate_book){            
            var url = "/donate_books/update_donate_book.json"
            return $http.post(url, {donate_book: donate_book});    
        };
             
        return{
            updateDonateBook : updateDonateBook,
        }       
    }]);
})(angular, myApp);
