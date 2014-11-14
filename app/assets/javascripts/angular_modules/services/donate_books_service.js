(function(angular, app) {
    "use strict";
    app.service("donateBooksService",["$http", function($http) {

        var getGradesService = function(){
            var url = "/donate_books/get_grades.json"
            return $http.get(url);
        };

        var getGradeSectionsService = function(myGrade){
            var url = "/donate_books/get_grade_sections.json"
            return $http.get(url,{params : {my_Grade : myGrade}});
        }; 

        var getStudentsService = function(myGrade,mySection){
            var url = "/donate_books/get_students.json"
            return $http.get(url,{params : {my_Grade : myGrade, my_Section : mySection}});
        }; 

        var updateDonateBook = function(donate_book){            
            var url = "/donate_books/update_donate_book.json"
            return $http.post(url, {donate_book: donate_book});    
        };
        
        var deleteDonateBook = function(donate_book){            
            var url = "/donate_books/delete_donate_book.json"
            return $http.post(url, {donate_book: donate_book});    
        };
             
        return{
            getGradesService : getGradesService,
            getGradeSectionsService : getGradeSectionsService,
            getStudentsService : getStudentsService,
            updateDonateBook : updateDonateBook,
            deleteDonateBook : deleteDonateBook
        }       
    }]);
})(angular, myApp);
