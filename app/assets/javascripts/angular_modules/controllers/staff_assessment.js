(function(angular, app) {
    "use strict";
    app.controller('StaffAssessmentController',["$scope","resourceService","staffassessmentService",function($scope, resourceService, staffassessmentService) {
        
        staffassessmentService.getDesignations()
            .then(function(result) {
                $scope.teacher_designations = result.data
            });
       
        $scope.assessments = resourceService.Recruitment.query(); 
	$scope.editAssessments = function(assessment){
	    $scope.assessment = assessment
	    $('#edit').modal('show');
	}


        $scope.update = function(){
            $scope.assessment.status = 'Management Reviewed';
            // alert($scope.assessment.designation.name)
            
          //  alert($scope.assessment.status)
            $scope.assessment.$update()
                .then(function(response){                  
                })
            $('#edit').modal('hide');
            $scope.assessments = resourceService.Recruitment.query();
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
            $scope.assessments = resourceService.Recruitment.query();
            window.location.reload();
        };  

        $scope.editResults = function(assessment){
	    $scope.assessment = assessment
	    $('#editresult').modal('show');
	}


        $scope.updateresult = function(){
            $scope.assessment.status = 'Completed';
          //  alert($scope.assessment.status)
            $scope.assessment.designation = $scope.assessment.designation.name;
            $scope.assessment.ctc = $scope.assessment.ctc;


            $scope.assessment.$update()
                .then(function(response){                  
                })
            $('#editresult').modal('hide');
            $scope.assessments = resourceService.Recruitment.query();
            window.location.reload();
        };  


    }]);
})(angular, myApp);
