(function(angular, app) {
    "use strict";
    app.controller('RequestsController',["$scope","resourceService", function($scope, resourceService) {
        $scope.request_new_books = resourceService.RequestNewBook.query();
        $scope.newRequests = []
        $scope.newRequest = function(){
            for(var i=0; i<3; i++){
                $scope.newRequests.push({"book_name":"", "author_name" :"" });
            };
            $('#createModal').modal('show')
        }

        $scope.submitBooks = function(){
            alert(JSON.stringify($scope.newRequests))
            resourceService.RequestNewBook.bulk({bulk_book: $scope.newRequests})
                .$promise.then(function(responce){
                    $scope.request_new_books = resourceService.RequestNewBook.query()
                    //alert("hi")
                    
                   // alert ("welcome")
                    $('#createModal').modal('hide')
                })
        }    
        
        $scope.destroy = function(book){
            book.$delete()
                .then(function(responce){
                    $scope.books.splice($scope.books.indexOf(book), 1)
                })
        };      
	$scope.addMorebooks = function(){
            var lnt = parseInt($scope.newRequests.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newRequests.push({"book_name":"", "author_name" :"" });
            };
        }
        
        // $scope.update = function(request_new_book){
        //     resourceService.updateRequestNewBook  (request_new_book)
        //         .then(function(responce){
        //             $('#editModal').modal('hide')
        //         });
        // };
    }]);  
    
})(angular, myApp);
