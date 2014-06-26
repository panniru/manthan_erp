(function(angular, app) {
    "use strict";
    app.controller('TermDefinitionsController',["$scope","resourceService", function($scope, resourceService) {
        $scope.termDefinitions = resourceService.TermDefinition.query();
        
        $scope.newTermDefinitions = function(){
            $scope.newTermDefinitions = []
            for(var i=0; i<3; i++){
                $scope.newTermDefinitions.push({"term_definition":"", "amount_per" :"", "termdate": "" });
            };
            $('#createModal').modal('show')
        }

        $scope.submitTermDefinitions = function(){
            angular.forEach($scope.newTermDefinitions, function(term, index){
                term.termdate = $("#date-"+index).val()
            });
            resourceService.TermDefinition.bulk({bulk_term: $scope.newTermDefinitions})
                .then(function(responce){
                    $scope.termDefinitions = resourceService.TermDefinition.query()
                    $('#createModal').modal('hide')
                })
        }

        $scope.destroy = function(termDefinition){
            termDefinition.$delete()
                .then(function(responce){
                    $scope.termDefinitions.splice($scope.termDefinitions.indexOf(termDefinition), 1)
                })
        };
        
        
	$scope.addMoreterms = function(){
            var lnt = parseInt($scope.newTermDefinitions.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newTermDefinitions.push({"term_definition":"", "amount_per" :"", "termdate": "" });
            };
        }
        
    }]);  
    
})(angular, myApp);


