(function(angular, app) {
    "use strict";
    app.controller('GradeController',["$scope","getGradeService", function($scope,getGradeService) {
        //$scope.grades=['Aa','B','C'];  
        getGradeService.getGradeServiceView()
            .then(function(result) {
//alert(result.data);
                $scope.grades=result.data
                
            });
        $scope.addPeriods = function(period) { 
            alert($scope.period);
            $scope.myValue="true"
           
            // Time Period List Array
            $scope.timeperiods = [];
            // Add a periodItem to the Time Period List
            for ( var i = 0; i < $scope.period; i++ ) {
                $scope.timeperiods.push({
                    periodid: $scope.periodid,
                    mon_sub: $scope.mon_sub,
                    tue_sub: $scope.tue_sub,
                    wed_sub: $scope.wed_sub,
                    thu_sub: $scope.thu_sub,
                    fri_sub: $scope.fri_sub,
                    sat_sub: $scope.sat_sub,
                    sun_sub: $scope.sun_sub,
                    });
                //alert($scope.timeperiods.length);
                }
            // Clear input fields after push
            $scope.periodid = "";
            $scope.mon_sub = "";
            $scope.tue_sub = "";
            $scope.wed_sub = "";
            $scope.thu_sub = "";
            $scope.fri_sub = "";
            $scope.sat_sub = "";
            $scope.sun_sub = "";
            
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
