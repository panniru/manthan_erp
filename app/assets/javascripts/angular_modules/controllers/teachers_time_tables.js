(function(angular, app) {
    "use strict";
    app.controller('TeachersTimeTablesController',["$scope","teachersService",function($scope,teachersService) {
        
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
                $scope.faculty_names=result.data                
            });
        teachersService.getFacultyGradeSectionsServiceView()
            .then(function(result) {
                $scope.faculty_grade_sections = result.data                
            });

        $scope.showTimeTable = function (){
            
            //alert();
            $scope.myValue="true"
            $scope.timeperiods = [];
            // Add a periodItem to the Time Period List
            for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                $scope.timeperiods.push({ 
                    grade_master_id: $scope.myTeacher,
                    mon_grade_section: "",
                    tue_grade_section: "",
                    wed_grade_section: "",
                    thu_grade_section: "",
                    fri_grade_section: "",
                    sat_grade_section: "",
                    sun_grade_section: "",
                });              
            }            
            };

        $scope.savePeriods = function(){
            //alert(JSON.stringify($scope.timeperiods));
            gradeService.savePeriods($scope.save_timeperiods)
                .then(function(result) {
                    
                });            
        };

        $scope.clearPeriods = function($index){
            $scope.timeperiods[$index]['mon_grade_section']= "";
            $scope.timeperiods[$index]['tue_grade_section']= "";
            $scope.timeperiods[$index]['wed_grade_section']= "";
            $scope.timeperiods[$index]['thu_grade_section']= "";
            $scope.timeperiods[$index]['fri_grade_section']= "";
            $scope.timeperiods[$index]['sat_grade_section']= "";
        }; 
        
    }]);
    
})(angular, myApp);
