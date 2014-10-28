(function(angular, app) {
    "use strict";
    app.controller('StudentAssessmentController',["$scope","resourceService", function($scope, resourceService) {
        
        
        $scope.assessments = resourceService.Assess.query(); 
	$scope.editAssessments = function(assessment){
	    $scope.assessment = assessment
	    $('#editass').modal('show');
	}


        $scope.update = function(){
            $scope.assessment.status = 'Management Reviewed';
          //  alert($scope.assessment.status)
            $scope.assessment.$update()
                .then(function(response){                  
                })
            $('#editass').modal('hide');
            $scope.assessments = resourceService.Assess.query();
            window.location.reload();
        };  

        $scope.editPlans = function(assessment){
	    $scope.assessment = assessment
	    $('#editplan').modal('show');
	}


        $scope.planupdate = function(){
            $scope.assessment.status = 'Assessment Completed';
            //alert($scope.assessment.status)
            $scope.assessment.$update()
                .then(function(response){                  
                })
            $('#editplan').modal('hide');
            $scope.assessments = resourceService.Assess.query();
            window.location.reload();
        };  

        $scope.editResults = function(assessment){
	    $scope.assessment = assessment
	    $('#editresult').modal('show');
	}


        $scope.updateresult = function(){
            $scope.assessment.status = 'Completed';
          //  alert($scope.assessment.status)
            $scope.assessment.$update()
                .then(function(response){                  
                })
            $('#editresult').modal('hide');
            $scope.assessments = resourceService.Assess.query();
            window.location.reload();
        };  


    }]);
})(angular, myApp);
