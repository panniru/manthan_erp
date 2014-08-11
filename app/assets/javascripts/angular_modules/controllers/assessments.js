(function(angular, app) {
    "use strict";
    app.controller('AssessmentsController', ["$scope", "assessmentsService", "gradeService", "sectionService", function($scope, assessmentsService, gradeService, sectionService) {        
        assessmentsService.getAssessmentTypesService()
            .then(function(result) {                 
                $scope.assessment_types = result.data;                
            });       

        $scope.showAssessmentTypeMappings = function(){
            assessmentsService.getAssessmentTypesService()
                .then(function(result) {                 
                    $scope.assessment_types = result.data;                    
                });
        };

        $scope.editAssessmentTypeMappings = function(assessment_type){           
            $scope.edit_assessment_types = [];
            
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });                      
        };

        $scope.saveAssessmentTypeMappings = function(assessment_type){           
            $scope.save_assessment_types = [];

            $scope.save_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });

            assessmentsService.saveAssessmentTypeMappings($scope.save_assessment_types)
                .then(function(result) {                    
                });

            $scope.showAssessmentTypeMappings();     
        };

        $scope.deleteAssessmentTypeMappings = function(assessment_type){           
            $scope.delete_mappping_id =assessment_type.id;
            
            assessmentsService.deleteAssessmentTypeMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                });  
            
            $scope.showAssessmentTypeMappings();            
        };


        //ASSESSMENT-GRADE-MAPPING        
        assessmentsService.getAssessmentGrageMappingsService()
            .then(function(result) {                 
                $scope.assessment_grade_mappings = result.data;                
            });
        
        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data;               
            });

        $scope.showAssessmentGradeMappings = function(){
            assessmentsService.getAssessmentGrageMappingsService()
                .then(function(result) {                 
                    $scope.assessment_grade_mappings = result.data;                    
                });
        };

        $scope.editAssessmentGradeMappings = function(assessment_type){            
            $scope.edit_assessment_types = [];
            
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
            });           

            $scope.edit_assessment_grade_mappings = [];
            
            for (var i = 0; i < $scope.grades.length; i++){
               
                $scope.edit_assessment_grade_mappings.push({
                    id: "",
                    assessment_type_id: assessment_type.id,
                    grade_master_id: $scope.grades[i]['grade_master_id'],
                    no_of_times:"", 
                });             
            }
            
            for (var i = 0; i < $scope.assessment_grade_mappings.length; i++){
                if($scope.assessment_grade_mappings[i]['assessment_type_id'] == assessment_type.id){
                    for (var j = 0; j < $scope.edit_assessment_grade_mappings.length; j++){
                        if($scope.assessment_grade_mappings[i]['grade_master_id'] == $scope.edit_assessment_grade_mappings[j]['grade_master_id']){
                            $scope.edit_assessment_grade_mappings[j]['id'] = $scope.assessment_grade_mappings[i]['id'];
                            $scope.edit_assessment_grade_mappings[j]['no_of_times'] = $scope.assessment_grade_mappings[i]['no_of_times'];                  
                        }                 
                    }
                }
            }
        };

        $scope.saveAssessmentGradeMappings = function(){            
            $scope.save_assessment_grade_mappings = [];
            
            for (var i = 0; i < $scope.edit_assessment_grade_mappings.length; i++)
            {
                if($scope.edit_assessment_grade_mappings[i]['no_of_times'] != ""){
                    $scope.save_assessment_grade_mappings.push({
                        id: $scope.edit_assessment_grade_mappings[i]['id'],
                        assessment_type_id: $scope.edit_assessment_grade_mappings[i]['assessment_type_id'],
                        grade_master_id: $scope.edit_assessment_grade_mappings[i]['grade_master_id'],
                        no_of_times: $scope.edit_assessment_grade_mappings[i]['no_of_times'],
                    });
                }
            }
            
            assessmentsService.saveAssessmentGradeMappings($scope.save_assessment_grade_mappings)
                .then(function(result) {                    
                });
            
            $scope.showAssessmentGradeMappings(); 
        };
        //ADMIN VIEW OF ASSESSMNETS
        $scope.getSections = function (){
            sectionService.getSectionServiceView()
                .then(function(result) {
                    $scope.sections=result.data                    
                });
        };  

        $scope.showAssessmentMappings = function(myGrade,mySection){          
            assessmentsService.getAssessmentMappingsService(myGrade,mySection)
                .then(function(result) {  
                    $scope.assessments = result.data;                   
                }); 
        };

       


        
    }]);    
})(angular, myApp);
