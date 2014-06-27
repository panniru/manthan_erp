(function(angular, app) {
    "use strict";
    app.controller('TeachersTimeTablesController',["$scope","teachersService","timeTableService",function($scope,teachersService,timeTableService) {
        
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
                $scope.faculty_names=result.data                
            });
        timeTableService.getDefaultPeriodsServiceView()
            .then(function(result) {
                $scope.no_of_periods = result.data
            });
        teachersService.getFacultyGradeSectionsServiceView()
            .then(function(result) {
                $scope.faculty_grade_sections = result.data                
            });

        $scope.showTimeTable = function (){
            
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

        $scope.clearRowPeriods = function($index){
            $scope.timeperiods[$index]['mon_grade_section']= "";
            $scope.timeperiods[$index]['tue_grade_section']= "";
            $scope.timeperiods[$index]['wed_grade_section']= "";
            $scope.timeperiods[$index]['thu_grade_section']= "";
            $scope.timeperiods[$index]['fri_grade_section']= "";
            $scope.timeperiods[$index]['sat_grade_section']= "";
        }; 
        
        $scope.clearColumnPeriods = function($index){
            
            if ($index == 0)
            {
                for ( var i = 0; i < 8; i++ ) {
                    $scope.timeperiods[i]['mon_grade_section']= "";
                }
            }
            else if ($index == 1)
            {
                for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                    $scope.timeperiods[i]['tue_grade_section']= "";
                }                
            }
            else if ($index == 2)
            {
                for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                    $scope.timeperiods[i]['wed_grade_section']= "";
                }                
            }
            else if ($index == 3)
            {
                for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                    $scope.timeperiods[i]['thu_grade_section']= "";
                }                
            }
            else if ($index == 4)
            {
                for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                    $scope.timeperiods[i]['fri_grade_section']= "";
                }                
            }
            else if ($index == 5)
            {
                for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                    $scope.timeperiods[i]['sat_grade_section']= "";
                }                
            }            
        };

        $scope.clearAllPeriods = function(){
            for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                $scope.timeperiods[i]['mon_grade_section']= "";
                $scope.timeperiods[i]['tue_grade_section']= "";
                $scope.timeperiods[i]['wed_grade_section']= "";
                $scope.timeperiods[i]['thu_grade_section']= "";
                $scope.timeperiods[i]['fri_grade_section']= "";
                $scope.timeperiods[i]['sat_grade_section']= "";            
            }
        };
        
    }]);
    
})(angular, myApp);
