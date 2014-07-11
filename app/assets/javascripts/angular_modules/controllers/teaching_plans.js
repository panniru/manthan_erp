(function(angular, app) {
    "use strict";
    app.controller("TeachingPlansController",["$scope", "teachingPlanService", function($scope, teachingPlanService) {
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
        //alert("hey......");
        
        teachingPlanService.getFacultyIdService()
            .then(function(result) {  
                //alert("welcome");
                $scope.faculty_id = result.data
                $scope.faculty_id = $scope.faculty_id[0]['id']
                //alert($scope.faculty_id);
                //alert(JSON.stringify($scope.faculty_id[0]['id']));                
                
                $scope.grades_sections = []
                teachingPlanService.getGradesSectionsService($scope.faculty_id)
                
                    .then(function(result) {  
                       // alert(result.data);
                        //alert(JSON.stringify(result.data))
                        $scope.grades_sections=result.data 
                        $scope.map_grades = result.data
                        $scope.map_sections = result.data
                    });

                $scope.grades_sections_subjects = []
                teachingPlanService.getGradesSectionSubjectService($scope.faculty_id)
                
                    .then(function(result) {                         
                        alert(JSON.stringify(result.data))
                        $scope.grades_sections_subjects =result.data 
                       // $scope.map_grades = result.data
                       // $scope.map_sections = result.data
                    });
            });
        

    }]);
    
})(angular, myApp);



