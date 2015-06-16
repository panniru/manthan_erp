(function(angular, app) {
    "use strict";
    app.service("na_assessmentResultsService",["$http", function($http) {

      var getTeacherAssessmentsService = function(){
            var url = "/na_assessment_results/get_non_teacher_assessments_service.json"
            return $http.get(url);
        }; 

        var getStudentDetailsService = function(myGrade, mySection){
            var url = "/na_assessment_results/get_non_student_details_service.json"
            return $http.get(url,{params : {my_Grade: myGrade, my_Section: mySection}});
        };  
 
        var saveAssessmentResultsService = function(save_Assessment_Results){
            var url = "/na_assessment_results/save_non_assessment_results_service.json"
            return $http.post(url,{mappings: save_Assessment_Results});
        }; 
        
        var getAssessmentResultsService = function(assessmentListingId){            
            var url = "/na_assessment_results/get_non_assessment_results_service.json"
            return $http.get(url,{params : {assessment_Listing_Id: assessmentListingId}});
        };

        var getNonAssessmentsService = function(){
            var url = "/na_assessment_results/get_non_assessments_service.json"
            return $http.get(url);
        }; 


        return { 
            getTeacherAssessmentsService : getTeacherAssessmentsService,
            getStudentDetailsService : getStudentDetailsService,
            saveAssessmentResultsService : saveAssessmentResultsService,
            getAssessmentResultsService : getAssessmentResultsService,
            getNonAssessmentsService : getNonAssessmentsService,
        }
        
    }]);    
})(angular, myApp);

