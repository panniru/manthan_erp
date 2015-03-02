(function(angular, app) {
    "use strict";
    app.service("academicsService",["$http", function($http) {

        var getGrades = function(){
            var url = "/academics/get_grades.json"
            return $http.get(url);
        };

        var getAcademicsSubjects = function(){
            var url = "/academics/get_academics_subjects.json"
            return $http.get(url);
        };

        var getSectionsForGradeService = function(myGrade){
            var url = "/academics/get_sections_for_grade.json"
            return $http.get(url,{params:{my_Grade: myGrade}});
        };  

        var getAcademicsSubjectsForGradeService = function(myGrade){
            var url = "/academics/get_academics_subjects_for_grade.json"
            return $http.get(url,{params:{my_Grade: myGrade}});
        };  

        return {
            getAcademicsSubjects : getAcademicsSubjects,
            getGrades : getGrades,
            getSectionsForGradeService : getSectionsForGradeService,
            getAcademicsSubjectsForGradeService : getAcademicsSubjectsForGradeService
        };    
        
    }]);    
})(angular, myApp);
