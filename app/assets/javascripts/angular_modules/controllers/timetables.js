(function(angular, app) {
    "use strict";
    app.controller('GradeController',["$scope","gradeService","sectionService","subjectService","timeTableService",function($scope,gradeService,sectionService,subjectService,timeTableService) {
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
        timeTableService.getDefaultPeriodsServiceView()
            .then(function(result) {
                $scope.no_of_periods = result.data
            });
        
        $scope.addPeriods = function (){ 
            $scope.myShowValue="false"
            $scope.myValue="true"           
            $scope.timeperiods = [];
            // Add a periodItem to the Time Period List
            for ( var i = 0; i < $scope.no_of_periods; i++ ) {
                $scope.timeperiods.push({
                    grade_master_id:$scope.myGrade,
                    section_master_id:$scope.mySection,
                    mon_sub: "",
                    tue_sub: "",
                    wed_sub: "",
                    thu_sub: "",
                    fri_sub: "",
                    sat_sub: "",
                    sun_sub: "",
                    });              
                }            
        };
        
        $scope.savePeriods = function(){
            alert(JSON.stringify($scope.timeperiods));
            gradeService.savePeriods($scope.timeperiods)
                .then(function(result) {
                });
        }; 
        

        $scope.showPeriods = function(){         
            $scope.myValue="false"
            $scope.myShowValue="true"
           
            timeTableService.getTimeTableServiceView()
                .then(function(result) {   
                });
            timeTableService.getPeriods($scope.myGrade,$scope.mySection)
                .then(function(result) {  
                    $scope.timeperiods=result.data
                });          
        };        
        
    }]);

})(angular, myApp);
