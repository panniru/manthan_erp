(function(angular, app) {
    "use strict";
    app.controller('GradeController',["$scope","gradeService","subjectService", function($scope,gradeService,subjectService) {
        //$scope.grades=['Aa','B','C'];  
        gradeService.getGradeServiceView()
            .then(function(result) {
                //alert(result.data);
                $scope.grades=result.data
                
            });
        
        subjectService.getSubjectServiceView()
            .then(function(result) {
                //alert();
                $scope.subjects=result.data
                
            });
        
        $scope.addPeriods = function(period) { 
            alert($scope.period);
            $scope.myValue="true"
           
            // Time Period List Array
            $scope.timeperiods = [];
            // Add a periodItem to the Time Period List
            for ( var i = 0; i < $scope.period; i++ ) {
                $scope.timeperiods.push({
                    //periodid: $scope.periodid,
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
        
        
    }]);
    app.controller('SectionController',["$scope","getSectionService", function($scope,getSectionService) {
        //$scope.grades=['Aa','B','C'];  
        getSectionService.getSectionServiceView()
            .then(function(result) {
                //alert(result.data);
                $scope.sections=result.data
                
            });
    }]);
})(angular, myApp);
