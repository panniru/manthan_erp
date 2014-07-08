(function(angular, app) {
    "use strict";
    app.controller("TeachingPlansController",["$scope", "gradeService","sectionService", function($scope, gradeService, sectionService) {
      //  $scope.myGrade = ""
             
     //   $scope.map_grades = []
      //  gradeService.getGradeServiceMapView()
        //    .then(function(result) {
                
          //      $scope.map_grades=result.data
                
           // });
       // $scope.map_sections = []
       // sectionService.getSectionServiceMapView()
         //   .then(function(result) {
                //alert(result.data)
           //     $scope.map_sections=result.data
           // });
        
        
        gradeService.getFacultyIdService()
            .then(function(result) {  
                //alert("welcome");
                $scope.faculty_id = result.data
                $scope.faculty_id = $scope.faculty_id[0]['id']
                alert($scope.faculty_id);
                //alert(JSON.stringify($scope.faculty_id[0]['id']));
                
                $scope.grades_sections = []
                gradeService.getGradesSectionsService($scope.faculty_id)
                
                    .then(function(result) {  
                       // alert(result.data);
                        alert(JSON.stringify(result.data))
                        $scope.grades_sections=result.data 
                        $scope.map_grades = result.data
                        $scope.map_sections = result.data
                    });
            });
        

    }]);
    
})(angular, myApp);



