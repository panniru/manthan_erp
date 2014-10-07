(function(angular, app) {
    "use strict";
    app.controller("RequestBooksController",["$scope","resourceService", "requestBooksService", function($scope, resourceService, requestBooksService) {        
        $scope.AddBook = [];
        $scope.request_books = resourceService.RequestBook.query();       
        $scope.request_books_status = [];
        $scope.book_status = "";

        $scope.sendBooksForApproval = function(book_status,request_book){
            alert(JSON.stringify(book_status));
            alert(JSON.stringify(request_book));
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
        };

        $scope.updateBooksStatus =  function(book_status){             
            for (var i=0; i<$scope.request_books_status.length; i++){ 
                $scope.request_books_status[i]['status'] = book_status;
            }
            
            requestBooksService.updateBooksStatus($scope.request_books_status)      
                .then(function(result) {
                    
                });           
            $scope.showRequestBooks();
        };

        $scope.showRequestBooks = function(){
            $scope.request_books = resourceService.RequestBook.query();
            $scope.request_books_status = [];
            $scope.book_status = "";
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
            $scope.updateBooksStatus('Ordered');
        };

        $scope.pendingRequests = function(){           
            $scope.pending_requests = resourceService.RequestBook.pending_requests();           
        };

        $scope.acceptBooksDeliver = function(book_status){
            $scope.updateBooksStatus(book_status);           
            $scope.pending_requests = resourceService.RequestBook.pending_requests();           
        };   

        $scope.newBook = function(){           
            $scope.newBooks = [];           
            $('#createModal').modal('show');
            alert(JSON.stringify($scope.pending_requests[0]['id']));
            alert($scope.pending_requests.length);
            alert($scope.request_books_status.length);
            $scope.moreBooks = true;            

            for(var i=0; i<$scope.pending_requests.length; i++){              
                for(var j=0; j<$scope.request_books_status.length; j++){                   
                    if($scope.pending_requests[i]['id'] == $scope.request_books_status[j]['id']){
                        $scope.newBooks.push({"request_book_id": $scope.pending_requests[i]['id'], "name": $scope.pending_requests[i]['book_name'], "isbn": "", "author": $scope.pending_requests[i]['author_name'], "year_of_publishing": "", "book_type": "", "purchased_date": ""});
                        
                    }   
                }             
            }                        
        };
        $scope.msfFun = function(){  alert("dynamic");       };

        $scope.submitBooks = function(){           
            for(var i=0; i< $scope.newBooks.length; i++){
                $scope.newBooks[i]['purchased_date'] =  $scope.dateFormat;
            };           
            resourceService.Book.add_bulk({bulk_book: $scope.newBooks})
                .$promise.then(function(responce){                    
                    $('#createModal').modal('hide')                   
                })
            $scope.pendingRequests();
        };
        
        $scope.getPurchaseDate = function(){           
            $scope.dateFormat = $scope.purchasedDate.getFullYear()+"-"+($scope.purchasedDate.getMonth()+1)+"-"+$scope.purchasedDate.getDate();             
        } 
    }]);
})(angular, myApp)
