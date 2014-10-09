(function(angular, app) {
    "use strict";
    app.controller('TeachersTimeTablesController',["$scope","teachersService","timeTableService",function($scope,teachersService,timeTableService) {
        //alert("hello");
        
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
                $scope.faculty_names=result.data;    
                //alert(JSON.stringify($scope.faculty_names));
            });
        timeTableService.getDefaultPeriodsServiceView()
            .then(function(result) {
                $scope.no_of_periods = result.data;
                //alert(JSON.stringify($scope.no_of_periods));
            });
        teachersService.getFacultyGradeSectionsServiceView()
            .then(function(result) {
                $scope.faculty_grade_sections = result.data;   
                alert(JSON.stringify($scope.faculty_grade_sections));
            });       
        
        $scope.showTimeTable = function(){            
            
            teachersService.checkTeachersTimeTable($scope.myTeacher)
                .then(function(result) {                   
                    $scope.check_teachers_time_table = result.data 
                    if ($scope.check_teachers_time_table == 0)
                    {                        
                        $scope.myValue = "false"
                        $scope.myShowValue = "false"
                        $scope.addPeriods();
                    }
                    else
                    {                        
                        $scope.myValue="false"
                        $scope.myShowValue="true"           
                        $scope.getPeriods($scope.myTeacher);
                    }
                });
        };
        
        $scope.getPeriods = function (myTeacher){           
            teachersService.getPeriods(myTeacher)
                .then(function(result) {  
                    $scope.timeperiods=result.data                   
                    $scope.myShowValue="true" 
                });
        };


        $scope.addPeriods = function (){
            
            $scope.myValue="true"
            $scope.timeperiods = [];
           
            for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                $scope.timeperiods.push({ 
                    faculty_master_id: $scope.myTeacher,
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
            $scope.save_timeperiods = [];
            for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                $scope.save_timeperiods.push({
                    id: $scope.timeperiods[i]['id'],  
                    faculty_master_id: $scope.myTeacher,
                    mon_grade_section: $scope.timeperiods[i]['mon_grade_section'] == 0 ? null : $scope.timeperiods[i]['mon_grade_section'],
                    tue_grade_section: $scope.timeperiods[i]['tue_grade_section'] == 0 ? null : $scope.timeperiods[i]['tue_grade_section'],
                    wed_grade_section: $scope.timeperiods[i]['wed_grade_section'] == 0 ? null : $scope.timeperiods[i]['wed_grade_section'],
                    thu_grade_section: $scope.timeperiods[i]['thu_grade_section'] == 0 ? null : $scope.timeperiods[i]['thu_grade_section'],
                    fri_grade_section: $scope.timeperiods[i]['fri_grade_section'] == 0 ? null : $scope.timeperiods[i]['fri_grade_section'],
                    sat_grade_section: $scope.timeperiods[i]['sat_grade_section'] == 0 ? null : $scope.timeperiods[i]['sat_grade_section'],
                    sun_grade_section: $scope.timeperiods[i]['sun_grade_section'] == 0 ? null : $scope.timeperiods[i]['sun_grade_section'],
                });              
            }
            
            teachersService.savePeriods($scope.save_timeperiods)
                .then(function(result) {
                    
                }); 
            $scope.showTimeTable();
        };
        
        $scope.editPeriods = function(){ 
            $scope.myShowValue="false"
            $scope.myValue="true"
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
