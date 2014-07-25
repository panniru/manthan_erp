(function(angular, app) {
    "use strict";
    app.service("assessmentCriteriaService",["$http", function($http) {
       
        var getAssessmentCriteriaService = function(myGrade){
            var url = "/assessment_criterias/get_assessment_criteria_service.json"
            return $http.get(url,{params:{my_Grade: myGrade}});
        };         

        return {
            getAssessmentCriteriaService : getAssessmentCriteriaService,
        }  
    }]);     
    
})(angular, myApp);
   
