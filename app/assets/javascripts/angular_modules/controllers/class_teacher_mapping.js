(function(angular, app) {
    "use strict";
    app.controller('ClassTeacherMappingController',["$scope", "classTeacherService", "teachersService", function($scope, classTeacherService, teachersService) { 

        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
                $scope.faculty_names=result.data                
            });       

        $scope.getGrade = function (){
            $scope.myShowFormValue = "true"
            $scope.myFormValue = "false"
            $scope.grade="2"
            $scope.myGrade = $scope.grade 
            //alert($scope.myGrade);            
            classTeacherService.getGradeWiseMappings($scope.myGrade)
                .then(function(result) { 
                    //alert("a");
                    $scope.mappings = result.data  
                    //alert(JSON.stringify($scope.mappings));
                });           
        };
        
        $scope.editMappings = function(){
            $scope.myFormValue = "true"
            $scope.myShowFormValue = "false"           
        };
        
        $scope.saveMappings = function(){

            $scope.getGrade();

        };
        
        $scope.deleteMappings =  function($index){
                        
            $scope.getGrade();            
        }
       
        
    }]);


    
})(angular, myApp);
