(function(angular, app) {
    "use strict";
    app.controller("AssessmentController",["$scope", "resourceService","assessService", function($scope, resourceService,  assessService) {
        // assessService.getStudentAssessment()
        //     .then(function(result) {
        //         $scope.ass = result.data;
        //     });
        
        $scope.ass = resourceService.Assess.query();
        
        $scope.getModal = function(assess){
            $scope.assess = assess;
            //$scope.action = "edit"
            $('#getModal').modal('show');
            
        };

    
        $scope.submit = function(){
            $scope.assess.$update()
                .then(function(response){
                    $scope.ass = resourceService.Assess.query(); 
                    $('#getModal').modal('hide')
                    window.location.reload();
            })
        }
                                           
        // $scope.submit = function(){
        //     if($scope.action === 'edit'){
        //         update();
        //     }
        //     else{   }
        // }

        $scope.showModal = function(){
            $scope.ass = resourceService.Assess.query();
        }
    }]);
})(angular, myApp);
