(function(angular, app) {
    "use strict";
    app.controller("RequestBooksController",["$scope","resourceService", "requestBooksService", function($scope, resourceService, requestBooksService) {    
        //alert();
        $scope.request_books = resourceService.RequestBook.query();
        //alert(JSON.stringify($scope.request_books));
        $scope.resquest_books_status = [];
        $scope.book_status = "";

        $scope.sendBooksForApproval = function(book_status,request_book){
            //alert(JSON.stringify(request_book));
            //alert($scope.resquest_books_status.length);
            //$scope.resquest_books_status.push(request_book.id);
            alert(book_status);
            
            
            for (var i=0; i<$scope.resquest_books_status.length; i++){ 
                if (request_book.id == $scope.resquest_books_status[i]){
                    alert("in");
                    $scope.resquest_books_status.splice(i, 1);
                    break;
                }
                else{
                    alert("else");
                    $scope.resquest_books_status.push(request_book.id);
                    break;
                    //alert(JSON.stringify($scope.resquest_books_status));
                }
            }

            if ($scope.resquest_books_status.length == 0){
                alert("out");
                $scope.resquest_books_status.push(request_book.id);
            }
            alert(JSON.stringify($scope.resquest_books_status));
            //alert($scope.resquest_books_status[$scope.resquest_books_status.length-1]+"ll");

        };

        
    }]);
})(angular, myApp)
