(function(angular, app) {
    "use strict";
    app.service("termResultsService",["$http", function($http) {
        
        var getTermResultsService = function(academic_Term_Id,myGrade, mySection, mySubject){
            var url = "/term_results/get_term_results.json"
            return $http.get(url, {params: {academic_Term_Id: academic_Term_Id, myGrade: myGrade, mySection: mySection, mySubject: mySubject}});
        }; 

        var getStudentDetailsService = function(myGrade, mySection){
            var url = "/term_results/get_student_details.json"
            return $http.get(url,{params : {my_Grade: myGrade, my_Section: mySection}});
        };  

        var getSubjectAssessmentCriteriaService = function(myGrade, mySubject){
            var url = "/term_results/get_subject_assessment_criteria.json"
            return $http.get(url,{params : {my_Grade: myGrade, my_Subject: mySubject}});
        };  
        
        return {
            getTermResultsService : getTermResultsService,
            getStudentDetailsService : getStudentDetailsService,
            getSubjectAssessmentCriteriaService : getSubjectAssessmentCriteriaService,
        }
    }]);
})(angular, myApp);
