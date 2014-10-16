(function(angular, app) {
    "use strict";
    app.controller("AssessmentController",["$scope", "resourceService","assessService", function($scope, resourceService,  assessService) {
       
        $scope.ass = resourceService.Assess.query();
        $scope.getModal = function(assess){
            $scope.assess = assess;
            $('#getModal').modal('show');
         
        };

    
        $scope.submit = function(){
            $scope.assess.$update()
                .then(function(response){
                    alert();
                    $scope.ass = resourceService.Assess.query(); 
                    window.location.reload();    
                    
        
            })
        }
            
        $scope.showModal = function(){
            $scope.ass = resourceService.Assess.query();
        }
    }]);
})(angular, myApp);
