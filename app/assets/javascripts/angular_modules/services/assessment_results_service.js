(function(angular, app) {
    "use strict";
    app.service("assessmentResultsService",["$http", function($http) {
      var getTeacherAssessmentsService = function(){
            var url = "/assessment_results/get_teacher_assessments_service.json"
            return $http.get(url);
        }; 

        var getStudentDetailsService = function(myGrade, mySection){
            var url = "/assessment_results/get_student_details_service.json"
            return $http.get(url,{params : {my_Grade: myGrade, my_Section: mySection}});
        };  
 
        var saveAssessmentResultsService = function(save_Assessment_Results){
            var url = "/assessment_results/save_assessment_results_service.json"
            return $http.post(url,{mappings: save_Assessment_Results});
        }; 
        
        var getAssessmentResultsService = function(assessmentListingId){            
            var url = "/assessment_results/get_assessment_results_service.json"
            return $http.get(url,{params : {assessment_Listing_Id: assessmentListingId}});
        };

        return { 
            getTeacherAssessmentsService : getTeacherAssessmentsService,
            getStudentDetailsService : getStudentDetailsService,
            saveAssessmentResultsService : saveAssessmentResultsService,
            getAssessmentResultsService : getAssessmentResultsService,
        }
        
    }]);    
})(angular, myApp);


