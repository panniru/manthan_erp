(function(angular, app) {
    "use strict";
    app.controller('AcademicTermsController', ["$scope", "academicTermsService", function($scope, academicTermsService) {        
        //alert();
        academicTermsService.getAcademicTermsService()
            .then(function(result) {                     
                $scope.academic_terms = result.data;
          //      alert(JSON.stringify($scope.academic_terms));
            });

       
    }]);    
})(angular, myApp);
