(function(angular, app) {
    "use strict";
    app.service("assessmentsTeacherService",["$http", function($http) {
        var getAssessmentTypesService = function(){
            var url = "/assessments/get_assessment_types_service.json"
            return $http.get(url);
        }; 
        var getTeacherAssessmentsService = function(myGrade, mySection, mySubject){
            var url = "/assessments/get_teacher_assessments_service.json"
            return $http.get(url, {params:{my_Grade: myGrade, my_Section: mySection, my_Subject: mySubject}});                  
        }; 
        var getTeacherGradeMappings = function(){
            var url = "/assessments/get_teacher_grade_mappings.json"
            return $http.get(url);            
        }; 

        var saveTeacherAssessmentMappings = function(save_teacher_assessments){            
            var url = "/assessments/save_teacher_assessments.json"
            return $http.post(url, {mappings: save_teacher_assessments});    
        };

        var deleteTeacherAssessmentMappings = function(delete_mapping_id){
            var url = "/assessments/delete_teacher_assessment_mappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };
     
        return { 
            getAssessmentTypesService : getAssessmentTypesService, 
            getTeacherAssessmentsService : getTeacherAssessmentsService,
            getTeacherGradeMappings : getTeacherGradeMappings,
            saveTeacherAssessmentMappings : saveTeacherAssessmentMappings,
            deleteTeacherAssessmentMappings : deleteTeacherAssessmentMappings,
        } 



        
    }]);    
})(angular, myApp);


