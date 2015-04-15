(function(angular, app) {
    "use strict";
    app.controller("LabTeacherMappingController", ["$scope" , "labMappingService", function($scope , labMappingService ){
       

        
        $scope.allSubjects = function(){
            labMappingService.getAllSubjects()
                .then(function(result){
                    $scope.subject_names = result.data
                });
        }

        $scope.saveLabMappings = function(){
            
            labMappingService.labMappings()
                .then(function(result){
                    $scope.faculty_names = result.data
     
                });
        }
        $scope.saveMappings = function(){  
            alert(' ') 
            $scope.save_mappings = [];
            for( var j = 0; j <  $scope.mapping['faculty_master_id'].length; j++ ){
                $scope.save_mappings.push({
                    id: $scope.mapping.id,
                    subject_master_id: $scope.mySubject,
                    faculty_master_id: $scope.mapping.faculty_master_id[j],
                    
                });
            }
            labMappingService.saveMappings($scope.save_mappings)
                .then(function(result){
                    $('#mymodal').modal('hide');
                    $scope.showMappings();
                    window.location.reload();
                });
        };
        $scope.saveEdit = function(){  
            $scope.save_mappings = []; 
            $scope.save_mappings.push({
                id: $scope.mapping.id, 
                subject_master_id: $scope.mySubject,
                faculty_master_id: $scope.mapping.faculty_master_id,
                
             
            });
            alert(JSON.stringify($scope.save_mappings))
            
            labMappingService.saveMappings($scope.save_mappings)
                .then(function(result) {
            
                    $('#myEditModal').modal('hide');
                    $scope.showMappings();
                    window.location.reload();
                });  
        };
        
        $scope.deleteMappings =  function($index){  
            if(confirm("Are you sure want to delete")){
                $scope.delete_Mapping_id = $scope.mappings[$index]['id']
                labMappingService.deleteMappings($scope.delete_Mapping_id)
                    .then(function(result) {   
                        $scope.showMappings();
                        window.location.reload();
                    });                 
            }else{
            }
        };


        $scope.showMappings = function(){ 
            // alert(' ') 
            $scope.myShowFormValue = true;
            labMappingService.checkSubjectsTeachersMapping($scope.mySubject)
            
                .then(function(result) {
                    $scope.check_subjects_teachers_mapping = result.data                    
                    
                    if ($scope.check_subjects_teachers_mapping == 0)
                    {
                        $scope.mappings = [];
                        $scope.addMapping();
                    }
                    else
                    {                          
                       labMappingService.getMappings($scope.mySubject)
                            .then(function(result) {  
                                
                                $scope.mappings = result.data;  
                                alert(JSON.stringify($scope.mappings))
                            });
                    }
                });
        };
        $scope.addMapping = function (mapping){
            $scope.faculty_names = [];
            $('#myModal').modal('show');
            $scope.mapping = mapping;  
        };
        $scope.editMapping = function (mapping){
            $scope.faculty_names = [];
            $scope.mapping = mapping; 
            $('#myEditModal').modal('show');                       
        };




    }]);
})(angular, myApp);



