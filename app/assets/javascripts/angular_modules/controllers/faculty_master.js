(function(angular, app) {
    "use strict";
    app.controller('FacultyMasterController',["$scope","resourceService","faculty_master_service",function($scope, resourceService, faculty_master_service) {


        $scope.getFilterValues = function(value) {
            faculty_master_service.getFilterValue(value)
                .then(function(result){
                    $scope.filter_values = result.data;
                });
        }


        faculty_master_service.getResignedStaffs()
            .then(function(result) {
                $scope.resigned_staffs = result.data
            });

        $scope.assessments = resourceService.FacultyMaster.query(); 
	$scope.editAssessments = function(assessment){
	    $scope.assessment = assessment
	    $('#editplan').modal('show');
	}


        $scope.planupdate = function(){
            // alert(JSON.stringify($scope.date))
            $scope.assessment.status = 'Resigned';
            $scope.assessment.resignation_date = $scope.date;
            $scope.assessment.$update()
                .then(function(response){                  
                })
            $('#editplan').modal('hide');
            $scope.assessments = resourceService.FacultyMaster.query();
            window.location.reload();
        };  
    }]);
})(angular, myApp);

