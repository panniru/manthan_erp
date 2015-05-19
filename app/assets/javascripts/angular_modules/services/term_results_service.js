(function(angular, app) {
    "use strict";
    app.service("termResultsService",["$http", function($http) {
        
        var getTermResultsService = function(academic_Term_Id,myGrade, mySection, mySubject){
            var url = "/term_results/get_term_results.json"
            return $http.get(url, {params: {academic_Term_Id: academic_Term_Id, my_Grade: myGrade, my_Section: mySection, my_Subject: mySubject}});
        }; 

        var getStudentDetailsService = function(myGrade, mySection){
            var url = "/term_results/get_student_details.json";           
            return $http.get(url,{params : {my_Grade: myGrade, my_Section: mySection}});           
        };  

        var getSubjectAssessmentCriteriaService = function(myGrade, mySubject){
            var url = "/term_results/get_subject_assessment_criteria.json"
            return $http.get(url,{params : {my_Grade: myGrade, my_Subject: mySubject}});
        };  
        
        var saveTermResultsService = function(term_results){
            var url = "/term_results/save_term_results.json"
            return $http.post(url,{term_results: term_results});            
        };

        var getGradesSectionsService = function(){
            var url = "/term_results/get_grades_sections.json"
            return $http.get(url);
        }; 

        var getGradeSubjectsService = function(myGrade){
            var url = "/term_results/get_grade_subjects.json"
            return $http.get(url,{params : {my_Grade: myGrade}});
        };

        var getStudentTermResultsService = function(academic_Term_Id, myStudent, myGrade, mySection){
            var url = "/term_results/get_student_term_results.json"
            return $http.get(url,{params: {academic_Term_Id: academic_Term_Id, my_Student: myStudent, my_Grade: myGrade, my_Section: mySection}});
        };
        

        var getResults = function(){
            var url = "/student_results/get_results.json"
            return $http.get(url);
        };
        var getUsers = function(selected_user){
            alert(selected_user)
            var url = "/student_results/get_users.json?selected_user="+selected_user
            return $http.get(url);
        };
        var getStudent = function(student_master_id){
            var url = "/student_results/get_names.json?grade_master_id="+grade_master_id
            return $http.get(url);
        };

        return {
            getTermResultsService : getTermResultsService,
            getStudentDetailsService : getStudentDetailsService,
            getSubjectAssessmentCriteriaService : getSubjectAssessmentCriteriaService,
            saveTermResultsService : saveTermResultsService,
            getGradesSectionsService : getGradesSectionsService,
            getGradeSubjectsService : getGradeSubjectsService,
            getStudentTermResultsService : getStudentTermResultsService,
            getResults : getResults,
            getUsers : getUsers,
            getStudent : getStudent
        }

    }]);
})(angular, myApp);
