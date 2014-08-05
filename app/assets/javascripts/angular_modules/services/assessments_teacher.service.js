(function(angular, app) {
    "use strict";
    app.service("assessmentsTeacherService",["$http", function($http) {
        var getAssessmentTypesService = function(){
            var url = "/assessments/get_assessment_types_service.json"
            return $http.get(url);
        }; 
        var getTeacherAssessmentsService = function(){
            var url = "/assessments/get_teacher_assessments_service.json"
            return $http.get(url);            
        };      
       
        return { 
            getAssessmentTypesService : getAssessmentTypesService, 
            getTeacherAssessmentsService : getTeacherAssessmentsService,
        } 



        
    }]);    
})(angular, myApp);


