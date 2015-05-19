(function(angular, app) {
    "use strict";
    app.controller('BooksController',["$scope","resourceService", function($scope, resourceService) {
        
        var initiateForm = function(){
            $scope.books = resourceService.Book.query(); 
            $scope.delivered_requests = resourceService.RequestBook.delivered_requests(); 
        };
        initiateForm();
               
        $scope.getPurchaseDate = function(){ 
            $scope.dateFormat = $scope.purchasedDate.getFullYear()+"-"+($scope.purchasedDate.getMonth()+1)+"-"+$scope.purchasedDate.getDate();             
        }     
   
        $scope.getEditPurchaseDate = function(){
            $scope.dateFormat = $scope.book.purchased_date.getFullYear()+"-"+($scope.book.purchased_date.getMonth()+1)+"-"+$scope.book.purchased_date.getDate();             
        }
       
        $scope.newBook = function(){             
            $scope.newBooks = [];
            $scope.getPurchaseDate = "";

            if($scope.delivered_requests.length){
                $scope.moreBooks = true;   
                for(var i=0; i<$scope.delivered_requests.length; i++){
                    $scope.newBooks.push({"request_book_id": $scope.delivered_requests[i]['id'], "name": $scope.delivered_requests[i]['book_name'], "isbn": "", "author": $scope.delivered_requests[i]['author_name'], "year_of_publishing": "", "book_type": "", "purchased_date": ""});
                }                
            }
            else{                
                for(var i=0; i<3; i++){
                    $scope.newBooks.push({"name": "", "isbn": "", "author": "", "year_of_publishing": "", "book_type": "", "purchased_date": ""});
                };
            }
            $('#createModal').modal('show')
        };

        $scope.submitBooks = function(){    
            if($scope.delivered_requests.length){                   
                for(var i=0; i< $scope.newBooks.length; i++){
                    $scope.newBooks[i]['purchased_date'] =  $scope.dateFormat;
                };           
                resourceService.Book.add_bulk({bulk_book: $scope.newBooks})
                    .$promise.then(function(responce){                    
                        $('#createModal').modal('hide')                   
                    })
            }
            else{
                for(var i=0; i< $scope.newBooks.length; i++){
                    $scope.newBooks[i]['purchased_date'] =  $scope.dateFormat;
                };           
                resourceService.Book.bulk({bulk_book: $scope.newBooks})
                    .$promise.then(function(responce){
                        $scope.books = resourceService.Book.query()
                        alert(JSON.stringify($scope.books))
                        $('#createModal').modal('hide')
                    })
            }
        };
        
        $scope.editBooks = function(book){
            $scope.book = book;                     
            $('#editBookModal').modal('show')
        };  
        
        $scope.destroy = function(book){
            if(confirm("Are you sure want to delete")){
                $scope.books.splice($scope.books.indexOf(book), 1);
                book.$delete()
                    .then(function(responce){                     
                        $scope.showBooks();
                    })                
            }else{
            }
        };  
        
        $scope.update = function(){
            $scope.book.$update()
                .then(function(responce){                  
                })
            $('#editBookModal').modal('hide');
            $scope.showBooks();
        };  
    
	$scope.addMorebooks = function(){           
            var lnt = parseInt($scope.newBooks.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newBooks.push({"name": "", "isbn": "", "author": "", "year_of_publishing": "", "book_type": "", "purchased_date": $scope.dateFormat});
            };
        };
        
	$scope.showBooks = function(){
            $scope.books = resourceService.Book.query(); 
        }       
    }]);    
})(angular, myApp);
