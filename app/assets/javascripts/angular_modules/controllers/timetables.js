(function(angular, app) {
    "use strict";
    app.controller('GradeController', function($scope) {
        $scope.grades=['Aa','B','C'];       
    });
    app.controller('GradeController',["$scope","getGradeService", function($scope,getGradeService) {
        //$scope.grades=['Aa','B','C'];  
        getGradeService.getGradeServiceView()
            .then(function(result) {
//alert(result.data);
                $scope.grades=result.data
                
            });
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
