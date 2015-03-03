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
            $scope.save_mappings = [];
            for( var j = 0; j <  $scope.mapping['faculty_master_id'].length; j++ ){
                $scope.save_mappings.push({
                    id:$scope.mapping.id,
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
                            });
                    }
                });
        };
        $scope.addMapping = function (mapping){
            $scope.faculty_names = [];
            $('#myModal').modal('show');
            $scope.mapping = mapping;  
        };




    }]);
})(angular, myApp);



