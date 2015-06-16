(function(angular, app) {
    "use strict";
    app.controller('AdmissionDashboardController',["$scope", "admission_dashboard_service",function($scope,admission_dashboard_service) {

        admission_dashboard_service.getCountStatus()
            .then(function(result) {
                $scope.reasons = result.data
            });

	$scope.showForms = function(status){
	    admission_dashboard_service.getForms(status)
                .then(function(result){
                    $('#show_form').modal('show');
                    $scope.filter_values = result.data;
                });
        }

        admission_dashboard_service.getStaffCountStatus()
            .then(function(result) {
                $scope.staff_reasons = result.data
            });

	$scope.showStaffForms = function(status){
	    admission_dashboard_service.getStaffForms(status)
                .then(function(result){
                    $('#staff_show_form').modal('show');
                    $scope.staff_filter_values = result.data;
                });
	}



        
    }]);
})(angular, myApp);
