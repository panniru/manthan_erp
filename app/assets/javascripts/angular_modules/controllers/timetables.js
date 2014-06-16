(function(angular, app) {
    "use strict";
    app.controller('GradeController',["$scope","gradeService","sectionService","subjectService","timeTableService",function($scope,gradeService,sectionService,subjectService,timeTableService) {
        //$scope.grades=['Aa','B','C'];  
        gradeService.getGradeServiceView()
            .then(function(result) {
                //alert(result.data);
                $scope.grades=result.data
                
            });
        sectionService.getSectionServiceView()
            .then(function(result) {
                //alert(result.data);
                $scope.sections=result.data
                
            });
        
        subjectService.getSubjectServiceView()
            .then(function(result) {
                //alert();
                $scope.subjects=result.data
                
            });
        
        $scope.addPeriods = function (){ 
            alert($scope.myGrade);
            alert($scope.mySection);
            alert($scope.period);
           
            $scope.myValue="true"
           
            // Time Period List Array
            $scope.timeperiods = [];
            // Add a periodItem to the Time Period List
            for ( var i = 0; i < $scope.period; i++ ) {
                $scope.timeperiods.push({
                    //periodid: $scope.periodid,
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
            alert("hi");
            gradeService.savePeriods($scope.timeperiods)
                .then(function(result) {
                });
        };  

        $scope.showPeriods = function() { 
            alert($scope.myGrade);
            alert($scope.mySection);
            timeTableService.getTimeTableServiceView()
                .then(function(result) {
                    //alert(result.data);
                    $scope.timetables=result.data
                    
                });
            $scope.myValue="true"
            $scope.timeperiods=$scope.timetables
        };
        
        
    }]);

})(angular, myApp);
