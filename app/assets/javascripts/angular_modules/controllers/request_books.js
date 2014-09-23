(function(angular, app) {
    "use strict";
    app.controller("RequestBooksController",["$scope","resourceService", "requestBooksService", function($scope, resourceService, requestBooksService) {    
        //alert();
        $scope.request_books = resourceService.RequestBook.query();
        //alert(JSON.stringify($scope.request_books));
        $scope.request_books_status = [];
        $scope.book_status = "";

        $scope.sendBooksForApproval = function(book_status,request_book){           
            if(book_status){               
                $scope.request_books_status.push({
                    id: request_book.id,
                    status: ""                    
                });
            }
            else
            {
                for (var i=0; i<$scope.request_books_status.length; i++){ 
                    if (request_book.id == $scope.request_books_status[i]['id']){                       
                        $scope.request_books_status.splice(i, 1);
                        break;
                    }
                }
            }
                      
            //alert(JSON.stringify($scope.resquest_books_status));
        };

        $scope.updateBooksStatus =  function(book_status){
            alert(book_status);

            for (var i=0; i<$scope.request_books_status.length; i++){ 
                $scope.request_books_status[i]['status'] = book_status;
            }

            alert(JSON.stringify($scope.request_books_status));
            requestBooksService.updateBooksStatus($scope.request_books_status)      
                .then(function(result) {
                    
                });           
            $scope.showRequestBooks();
        };

        $scope.showRequestBooks = function(){
            $scope.request_books = resourceService.RequestBook.query();
        };

        $scope.initiateMail = function(term_name){
            $scope.myRequestBooks = [];
            $scope.myMailSubject = "Regarding Books Order";            
            $('#mailSubjectModal').modal('show');             
          
            for(var i=0; i<$scope.request_books_status.length; i++){
              for(var j=0; j<$scope.request_books.length; j++){
                    if($scope.request_books_status[i]['id'] == $scope.request_books[j]['id']){                        
                        $scope.myRequestBooks.push({
                            id: $scope.request_books[j]['id'],
                            book_name: $scope.request_books[j]['book_name'],
                            author_name: $scope.request_books[j]['author_name'],
                        });
                    }
                }
            }            
            
            alert(JSON.stringify($scope.myRequestBooks));
            $scope.updateBooksStatus('Ordered');
        };


        
    }]);
})(angular, myApp)
