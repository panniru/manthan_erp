(function(angular, app) {
    "use strict";
    app.service("assessmentCriteriaTeacherService",["$http", function($http) {

        var getGradeSubjectService = function(){
            var url = "/assessment_criterias/get_grade_subject_service.json"
            return $http.get(url);
        };
              
        var getAssessmentCriteria = function(grade_master_id,subject_master_id){
            var url = "/assessment_criterias/get_assessment_criteria.json"
            return $http.get(url,{params:{my_Grade: grade_master_id, my_Subject: subject_master_id}});
        };

        return {
            getGradeSubjectService : getGradeSubjectService,
            getAssessmentCriteria : getAssessmentCriteria
        };
    }]);    
})(angular, myApp);
