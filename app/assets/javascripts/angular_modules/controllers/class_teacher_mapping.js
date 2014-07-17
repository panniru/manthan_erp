(function(angular, app) {
    "use strict";
    app.controller('ClassTeacherMappingController',["$scope", "classTeacherService", "teachersService", function($scope, classTeacherService, teachersService) { 

        $scope.showMappings  = function (grade_id){                   
            $scope.myGrade = grade_id             
            classTeacherService.getGradeWiseFacultyNames($scope.myGrade)
                .then(function(result) {                     
                    $scope.faculty_names = result.data;
                });
            
            classTeacherService.getClassTeacherMappings($scope.myGrade)
                .then(function(result) {                   
                    $scope.mappings = result.data               
                           
                    if (result.data.length == 0)
                    {                       
                        $scope.myFormValue = "false"
                        $scope.myShowFormValue = "false"            
                        $scope.addMappings();
                    }
                    else
                    {                        
                        $scope.myFormValue = "false"
                        $scope.myShowFormValue = "true"           
                    } 
                }); 
           
        };

        $scope.addMappings = function (){
            $scope.mappings = [];
            $scope.myFormValue = "true"                 
            classTeacherService.getGradeWiseMappings($scope.myGrade)
                .then(function(result) {                     
                    $scope.mappings = result.data                    
                });                        
        };
        
        $scope.editMappings = function(){               
            $scope.myFormValue = "true"
            $scope.myShowFormValue = "false"           
        };
        
        $scope.saveMappings = function(){           
            $scope.save_mappings = [];
            for ( var i = 0; i <  $scope.mappings.length; i++ ) {    
                
                if ( $scope.mappings[i]['grade_master_id'] != 0 && $scope.mappings[i]['section_master_id'] != 0 && $scope.mappings[i]['faculty_master_id'] != 0)
                {                 
                    $scope.save_mappings.push({
                        id: $scope.mappings[i]['id'],             
                        grade_master_id: $scope.mappings[i]['grade_master_id'],
                        section_master_id: $scope.mappings[i]['section_master_id'],
                        faculty_master_id: $scope.mappings[i]['faculty_master_id']['faculty_master_id'],                     
                    });
                }             
            }             

            classTeacherService.checkForTeacherMapping()
                .then(function(result) {                    
                    $scope.check_faculty_ids = result.data
                    for ( var i = 0; i <  $scope.save_mappings.length; i++ ){                             

                        for ( var j = 0; j <$scope.check_faculty_ids.length; j++ ){                          

                            if ($scope.save_mappings[i]['faculty_master_id'] ==$scope.check_faculty_ids[j]['faculty_id']){
                                alert("Teacher "+JSON.stringify($scope.mappings[i]['faculty_master_id']['faculty_name'])+" Already Assigned For A Class");
                            }
                        }
                       
                    }  
                });

            classTeacherService.saveMappings($scope.save_mappings)
                .then(function(result) {
                    
                });          

            $scope.showMappings($scope.myGrade);
        };       
        
        $scope.deleteMappings =  function($index){           
            $scope.delete_mappping_id = $scope.mappings[$index]['id']

            classTeacherService.deleteMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                }); 
             
            $scope.showMappings($scope.myGrade);            
        };
        
        
       
        
    }]);


    
})(angular, myApp);
