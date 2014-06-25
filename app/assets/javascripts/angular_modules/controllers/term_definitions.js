(function(angular, app) {
    "use strict";
    app.controller('TermDefinitionsController',["$scope","resourceService", function($scope, resourceService) {
        $scope.termDefinitions = resourceService.TermDefinition.query();

        $scope.newTermDefinitions = function(){
            $scope.newTermDefinitions = []
            for(var i=0; i<3; i++){
                $scope.newTermDefinitions.push({"term_definition":"", "amount_per" :"" });
            };
            $('#createModal').modal('show')
        }

        $scope.submitTermDefinitions = function(){
            resourceService.TermDefinition.bulk({bulk_fee_grade_buckets: $scope.newTermDefinitions})
                .$promise.then(function(responce){
                    $scope.feeGradeBuckets = gradeBucketService.TermDefinition.query()
                    $('#createModal').modal('hide')
                })
        }

        $scope.destroy = function(feeGradeBucket){
            feeGradeBucket.$delete()
                .$promise.then(function(responce){
                    $scope.feeGradeBuckets.splice($scope.feeGradeBuckets.indexOf(feeGradeBucket), 1)
                })
        };
        
        
	$scope.addMoreterms = function(){
            var lnt = parseInt($scope.term_definitions.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newTermDefinitions.push({"term_definition":"", "amount_per" :""});
            };
        }
        
    }]);  
    
})(angular, myApp);


