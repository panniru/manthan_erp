function(angular, app) {
    "use strict";
    app.controller("BooksController",["$scope", function($scope) {
        $scope.books = []
        for(var i=0; i<5; i++){
            $scope.books.push({"Name":"", "ISBN" :"", "Type": ""});
        };
        
        $scope.addMoreterms = function(){
            var lnt = parseInt($scope.books.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.books.push({"Name":"", "ISBN" :"", "Type": ""});
            };
        }
    }]);
})(angular, myApp);
    
