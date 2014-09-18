(function(angular, app) {
    "use strict";
    app.service("damageBookService",["$http", function($http) {
        var getbookServiceView  = function(){
            var url = "/damagebooks/get_book_service_view.json"
            return $http.get(url);
        };

        var getDamageBooksService = function(){
            var url = "/damagebooks/get_damage_books.json"
            return $http.get(url);
        };
        
        return {
            getbookServiceView : getbookServiceView,   
            getDamageBooksService : getDamageBooksService
        };
    }]);

})(angular, myApp);
