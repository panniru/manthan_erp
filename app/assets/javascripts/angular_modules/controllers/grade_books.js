(function(angular, app) {
    "use strict";
    app.controller("GradeBooksController",["$scope", "gradeBooksService", function($scope,  gradeBooksService) {
        
        gradeBooksService.getGradesService()
            .then(function(result) {                
                $scope.grades=result.data;
            });

        gradeBooksService.getGradeBooksService()
            .then(function(result) {                
                $scope.grade_books=result.data;
            });

        $scope.editGradeBooks = function(grade){
            $scope.grade_master_id = grade.id;
            $scope.myNoOfBooks = "";
            $scope.grade_book_id = "";

            for (var i =0; i<$scope.grade_books.length;i++){
                if (grade.id == $scope.grade_books[i]['grade_master_id']){
                    $scope.myNoOfBooks= $scope.grade_books[i]['no_of_books']
                    $scope.grade_book_id = $scope.grade_books[i]['id']
                }
            } 
            $('#myModal').modal('show');
        };
        
        $scope.updateGradeBooks = function(){
            $('#myModal').modal('hide');
            $scope.save_grade_book = [];

            $scope.save_grade_book.push({
                id: $scope.grade_book_id,
                grade_master_id: $scope.grade_master_id,
                no_of_books: $scope.myNoOfBooks
            });

            gradeBooksService.saveGradeBooksService($scope.save_grade_book)
                .then(function(result) {  
                    $scope.showGradeBooks();                    
                });
        };

        $scope.showGradeBooks = function(){            
            gradeBooksService.getGradeBooksService()
                .then(function(result) {                
                    $scope.grade_books=result.data;
                });
        };


   
    }]);
})(angular, myApp);

