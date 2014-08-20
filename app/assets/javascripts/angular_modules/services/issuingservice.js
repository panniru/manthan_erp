(function(angular, app) {
    "use strict";
    app.service("bookService",["$http", function($http) {
        var getbookServiceView  = function(){
            var url = "/damagebooks/get_book_service_view.json"
            return $http.get(url);
        };
        return {
            getbookServiceView : getbookServiceView
        };
        
    }]);

})(angular, myApp);

