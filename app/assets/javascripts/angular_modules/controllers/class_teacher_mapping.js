(function(angular, app) {
    "use strict";
    app.controller('ClassTeacherMappingController',["$scope", "timeTableService", "classTeacherService", "teachersService", function($scope, timeTableService,  classTeacherService, teachersService) { 

        var initiateForm = function(){
            $scope.myFormValue = true;
            $scope.myShowFormValue = false;           
        };
        initiateForm();
        
        timeTableService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data; 
            });
        
        $scope.showClassTeacherMappings  = function (){             
            classTeacherService.getClassTeacherMappings($scope.myGrade)
                .then(function(result) {                   
                    $scope.mappings = result.data;
                    if(result.data.length>0){
                        $scope.myShowFormValue = true; 
                        $scope.showAddButton = true;   
                    } 
                    else{
                        $scope.myShowFormValue = false;   
                        $scope.showAddButton = true;  
                    }
                });    
           
        };

        $scope.editMapping = function (mapping){
            $scope.mapping = mapping; 
            $scope.getGradeSectionsFaculties();
            $('#myEditModal').modal('show');                       
        };
        
        $scope.addMapping = function (mapping){
            $scope.getGradeSectionsFaculties();
            $scope.mapping = mapping; 
            $('#myModal').modal('show');                
        };

        $scope.getGradeSectionsFaculties = function (){ 
            timeTableService.getSectionsForGradeService($scope.myGrade)
                .then(function(result) {
                    $scope.sections=result.data;
                });
            
            classTeacherService.getGradeWiseFacultyNames($scope.myGrade)
                .then(function(result) {                     
                    $scope.faculty_names = result.data;
                });
        };         
        
        $scope.deleteMappingsA =  function($index){ 
            $scope.delete_mappping_id = $scope.mappings[$index]['id']

            classTeacherService.deleteMappings($scope.delete_mappping_id)
                .then(function(result) { 
                    $scope.showClassTeacherMappings();
                });   
        };
        
        $scope.saveMapping = function(){
            $scope.save_mapping = [];
            
            $scope.save_mapping.push({
                id: $scope.mapping.id,
                grade_master_id:  $scope.myGrade,
                section_master_id:  $scope.mapping.section_master_id,
                faculty_master_id:  $scope.mapping.faculty_master_id
            });
            
            classTeacherService.saveMappings($scope.save_mapping)
                .then(function(result) {
                    $('#myModal').modal('hide');  
                    $('#myEditModal').modal('hide');  
                    $scope.showClassTeacherMappings();
                });             
        };
        
   
    }]);    
})(angular, myApp);
