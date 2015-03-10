(function(angular, app) {
    "use strict";
    app.service("assessmentsService",["$http", function($http) {
        var getAssessmentTypesService = function(){
            var url = "/assessments/get_assessment_types_service.json"
            return $http.get(url);
        }; 

        var saveAssessmentTypeMappings = function(save_assessment_types){            
            var url = "/assessments/save_assessment_type_mappings.json"
            return $http.post(url, {mappings: save_assessment_types});    
        }; 

        var deleteAssessmentTypeMappings = function(delete_mapping_id){
            var url = "/assessments/delete_assessment_type_mappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };

        //ASSESSMENT-GRADE-MAPPING
        var getAssessmentGrageMappingsService = function(){
            var url = "/assessments/get_assessment_grade_mappings_service.json"
            return $http.get(url);
        }; 
        
        var saveAssessmentGradeMappings = function(save_assessment_grade_mappings){            
            var url = "/assessments/save_assessment_grade_mappings.json"
            return $http.post(url, {mappings: save_assessment_grade_mappings});    
        }; 

        // var getAssessmentMappingsService = function(myGrade,mySection){
        //     var url = "/assessments/get_assessment_mappings_service.json"
        //     return $http.get(url, {params: {my_Grade: myGrade, my_Section: mySection}});
        // };   
        
       
        //ADMIN VIEW OF ASSESSMENTS

        //ASSESSMENT SUBJECT MAPPING
        var getAssessmentGradeMappings = function(){
            var url = "/assessments/get_assessment_grade_mappings.json"
            return $http.get(url);
        };

        var saveAssessments = function(assessments){
            var url = "/assessments/save_assessments.json"
            return $http.post(url, {assessments: assessments});
        };

        var getAssessments = function(){
            var url = "/assessments/get_assessments.json"
            return $http.get(url);
        };

        var saveAssessmentCriteria = function(criteria){
            var url = "/assessments/save_assessment_criteria.json"
            return $http.post(url, {criteria: criteria});
        };

        var getAssessmentCriteria = function(assessment_id){
            var url = "/assessments/get_assessment_criteria.json"
            return $http.get(url,{params:{assessment_id: assessment_id}});
        };

        
        return { 
            getAssessmentTypesService : getAssessmentTypesService,
            deleteAssessmentTypeMappings : deleteAssessmentTypeMappings,
            saveAssessmentTypeMappings : saveAssessmentTypeMappings,
            getAssessmentGrageMappingsService : getAssessmentGrageMappingsService,  
            saveAssessmentGradeMappings : saveAssessmentGradeMappings,
            // getAssessmentMappingsService : getAssessmentMappingsService,
            getAssessmentGradeMappings : getAssessmentGradeMappings,
            saveAssessments : saveAssessments,
            getAssessments : getAssessments,
            saveAssessmentCriteria : saveAssessmentCriteria,
            getAssessmentCriteria : getAssessmentCriteria
        }         
    }]);    
})(angular, myApp);


