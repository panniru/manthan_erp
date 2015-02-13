(function(angular, app) {
    "use strict";
    app.controller('ActivityTeachersMapController', ["$scope", "nonAcademicService", "activityTeachersMapService", "teachersService", function($scope, nonAcademicService, activityTeachersMapService, teachersService) {

        var initiateForm = function(){
            $scope.showFormValue = false;
        };
        initiateForm();

        nonAcademicService.getActivities()
            .then(function(result) {
                $scope.activity_names = result.data;
            });
        
        
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
                $scope.faculty_names = result.data;
            });
        
        $scope.showMappings = function(){
            activityTeachersMapService.checkActivityTeachersMapping($scope.myActivity)
                .then(function(result) {                  
                    if (result.data == 0)
                    {
                        $scope.showFormValue = false;
                        $scope.mappings = [];
                        $scope.addMapping({});
                    }
                    else
                    {        
                        activityTeachersMapService.getMappings($scope.myActivity)
                            .then(function(result) {  
                                $scope.mappings = result.data;
                            });
                        $scope.showFormValue = true;
                    }
                });
        };
        
        $scope.addMapping = function (mapping){
            mapping['activity_master_id'] = $scope.myActivity;
            $('#myModal').modal('show');
            $scope.mapping = mapping;  
        };

        $scope.editMapping = function (mapping){
            mapping['id'] = mapping.id;
            $scope.mapping = mapping; 
            $('#myEditModal').modal('show');                       
        };

        $scope.saveMappings = function(){ 
            $scope.save_mapping =  $scope.mapping;            
            activityTeachersMapService.saveMappings($scope.save_mapping)
                .then(function(result) {
                    $('#myModal').modal('hide');   
                    $('#myEditModal').modal('hide');        
                    $scope.showMappings();
                }); 
        };
        
        $scope.deleteMappings =  function($index){  
            if(confirm("Are you sure want to delete")){
                $scope.delete_Mappping_id = $scope.mappings[$index]['id']
                activityTeachersMapService.deleteMapping($scope.delete_Mappping_id)
                    .then(function(result) {   
                        $scope.showMappings();
                    });                 
            }else{
            }
        };       
        
    }]);   
})(angular, myApp);
