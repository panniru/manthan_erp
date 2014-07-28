(function(angular, app) {
    "use strict";
    app.controller("DamagebooksController",["$scope","bookService", function($scope, bookService) {
        bookService.getbookServiceView()
            .then(function(result) {
                alert(JSON.stringify(result.data))
                $scope.damage_books = result.data
            });
          $scope.Go = function(){       
                $scope.getbooks = function (myIsbn){
                    bookService.getbooks(myIsbn)
                        .then(function(result) {
                            $scope.books=result.data
                            $scope.myShowValue="true"
                        });
                };
          }
    }]);
})(angular, myApp);        


