(function(angular, app) {
    "use strict";
    app.controller("DonateBooksController",["$scope","resourceService", "donateBooksService", function($scope, resourceService, donateBooksService) {     
    
        $scope.donate_books = resourceService.DonateBook.query(); 
        $scope.showDonateBook = function(){
            $scope.donate_books = resourceService.DonateBook.query();  
        };
        
        donateBooksService.getGradesService()
            .then(function(result) {                
                $scope.grades = result.data;                
            });
       
        $scope.getGradeSections = function(){      
            donateBooksService.getGradeSectionsService($scope.myGrade)
                .then(function(result) {                
                    $scope.sections = result.data;
                });
        };

        $scope.getStudents = function(){
            donateBooksService.getStudentsService($scope.myGrade,$scope.mySection)
                .then(function(result) {                
                    $scope.students = result.data;
                });
        };
        
        $scope.editDonateBook = function(donate_book){
            $scope.donate_book = donate_book;
            $('#myEditModal').modal('show');            
        };
        
        $scope.updateDonateBook = function(donate_book){
            $('#myEditModal').modal('hide');
            donateBooksService.updateDonateBook($scope.donate_book)
                .then(function(result){
                });
            $scope.showDonateBook();
        };
        
        $scope.deleteDonateBook = function(donate_book){
            if(confirm("Are you sure want to delete")){
                donateBooksService.deleteDonateBook(donate_book)
                    .then(function(result){
                        $scope.showDonateBook();
                    });                
            }else{
            }
        }



    }]); 
})(angular, myApp);
