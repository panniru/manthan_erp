(function(angular, app) {
    "use strict";
    app.controller('TeacherGradeMapController', ["$scope", "teachersGradesService", "teachersService","gradeService", "sectionService", "subjectService", function($scope, teachersGradesService, teachersService, gradeService, sectionService, subjectService) {
        
        teachersService.getFacultyNamesServiceView()
            .then(function(result) {
                $scope.faculty_names=result.data                
            });
        
        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data                
            });

        sectionService.getSectionServiceView()
            .then(function(result) {
                $scope.sections=result.data
                
            });  
        
        subjectService.getSubjectServiceView()
            .then(function(result) {
                $scope.subjects=result.data
                
            });
        
        $scope.showMappings = function(){            
            teachersGradesService.checkTeachersGradesMapping($scope.myTeacher)
                .then(function(result) {
                    $scope.check_teachers_grades_mapping = result.data 
                    if ($scope.check_teachers_grades_mapping == 0)
                    {
                        $scope.error_code = 2
                        $scope.myValue = "false"
                        $scope.myShowValue = "false"
                        $scope.addPeriods();
                    }
                    else
                    {
                        $scope.error_code = 0
                        $scope.myValue="false"
                        $scope.myShowValue="true"           
                        teachersService.getPeriods($scope.myTeacher)
                            .then(function(result) {  
                                $scope.timeperiods=result.data
                            });
                    }
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
        
    }]);
    
})(angular, myApp);
