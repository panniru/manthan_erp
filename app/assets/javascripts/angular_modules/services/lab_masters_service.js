(function(angular, app) {
    "use strict";
    app.service("labService" , ["$http", function($http) {

        var getLabNames = function(){
	    var url = "/lab_criterias/get_lab_masters.json"
	    return $http.get(url);
        };

	var getGradeNames = function(){
	    var url = "/lab_criterias/get_all_grades.json"
	    return $http.get(url);
        };
	var saveCriteria = function(assessment_criterias){
            var url = "/lab_criterias/save_assessment_criterias.json"
            return $http.post(url, {criterias: assessment_criterias});          
        };
	var getAssessmentCriteria = function(labName){
	    var url = "/lab_criterias/get_assessment_criteria.json"
	    return $http.get(url,{params:{lab_name: labName}});
	};
	var deleteAssessmentCriteriaMappings = function(delete_mapping_id){
            var url = "/lab_criterias/deletemappings.json"
            return $http.post(url, {delete_mapping_id: delete_mapping_id}); 
        };
        // LABASSESSMENT 
        var getAssessmentTypesService = function(){
            var url = "/lab_assessments/get_assessment_types_service.json"
            return $http.get(url);
        }; 
        var saveAssessmentTypeMappings = function(save_assessment_types){            
            var url = "/lab_assessments/save_assessment_type_mappings.json"
            return $http.post(url, {mappings: save_assessment_types});    
        }; 
        var deleteAssessmentTypeMappings = function(delete_mapping_id){
            var url = "/lab_assessments/delete_assessment_type_mappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };
        //MAPPINGS
        var getAssessmentGradeMappingsService = function(){
            var url = "/lab_assessments/get_grade_mappings_service.json"
            return $http.get(url);
        }; 
        var saveAssessmentGradeMappings = function(save_assessment_grade_mappings){            
            var url = "/lab_assessments/save_assessment_grade_mappings.json"
            return $http.post(url, {mappings: save_assessment_grade_mappings});    
        }; 
        //ASSESSMENT SUBJECT MAPPINGS

        var getAssessmentSubjectsService = function(){
            var url = "/lab_assessments/get_subjects_service.json"
            return $http.get(url);
        };
         
        var saveAssessments = function(assessments){
            var url = "/lab_assessments/save_assessments.json"
            return $http.post(url, {assessments: assessments});
        };
        // grade-subject
        var getTeacherSubjectMapping = function(){
            var url = "/lab_assessments/get_assessment_subjects.json"
            return $http.get(url);
        };
     

        // var getMapping = function(){
        //     var url = "/lab_assessments/get_subjects.json"
        //     return $http.get(url);
        // };
        
        var saveTeacherMappings = function(save_teacher_assessments){            
            var url = "/assessments/save_teacher_mappings.json"
            return $http.post(url, {mappings: save_teacher_assessments});    
        };

        var getTeacherService = function(myGrade, mySubject){
            var url = "/lab_assessments/get_teacher_service.json"
            return $http.get(url, {params:{my_Grade: myGrade, my_Subject: mySubject}});                  
        }; 
        var getBothValue = function(selected_user){
            var url = "/listings/get_values.json?selected_user="+selected_user
            return $http.get(url);
        };
        // var getValue = function(date){
        //     var url = "/lab_results/get_value.json?date="+date
        //     return $http.get(url);
        // };
        var getStudent = function(grade_master_id,listing_id){
            var url = "/lab_results/get_names.json?grade_master_id="+grade_master_id
            return $http.get(url);
        };
        var save_all = function(listing_id,grading,student_id){
            
            var url = "/lab_results/save_all.json"
            return $http.post(url, {student_master_id: student_id,grading_master_id : grading ,listing_id : listing_id});
        };
        
      
	
	return {
	    getLabNames : getLabNames,
	    getGradeNames : getGradeNames,
	    saveCriteria : saveCriteria,
	    getAssessmentCriteria : getAssessmentCriteria ,
	    deleteAssessmentCriteriaMappings : deleteAssessmentCriteriaMappings,
            saveAssessmentTypeMappings :saveAssessmentTypeMappings,
            getAssessmentTypesService :getAssessmentTypesService,
            deleteAssessmentTypeMappings :deleteAssessmentTypeMappings,
            getAssessmentGradeMappingsService :getAssessmentGradeMappingsService,
            saveAssessmentGradeMappings :saveAssessmentGradeMappings,
            getAsessmentSubjectsService :getAssessmentSubjectsService,
            saveAssessments :saveAssessments,
            getTeacherSubjectMapping :getTeacherSubjectMapping,
            saveTeacherMappings :saveTeacherMappings,
            getTeacherService :getTeacherService,
            getBothValue : getBothValue,
            getStudent :getStudent,
            save_all :save_all
            // get_value :get_value
            // get_mapping :get_mapping 
        


	};
    }]);
})(angular, myApp);
