(function(angular, app) {
    "use strict";
    app.controller('TermDefinitionsController',["$scope","resourceService", function($scope, resourceService) {
        $scope.termDefinitions = resourceService.TermDefinition.query();
        
        $scope.newTermDefinition = function(){
            $scope.newTermDefinitions = []
            for(var i=0; i<3; i++){
                $scope.newTermDefinitions.push({"term_definition":"", "amount_per" :"", "termdate": "" });
            };
            $('#createModal').modal('show')
        }
        
        $scope.editTermDefinitions = function(){
            $scope.newTermDefinitions = $scope.termDefinitions
            $('#createModal').modal('show')
        }

        $scope.submitTermDefinitions = function(){
            var total_percentage = 0.0;
            angular.forEach($scope.newTermDefinitions, function(term, index){
                term.termdate = $("#date-"+index).val()
                if(!isNaN(term.amount_per) && term.amount_per != ''){
                    total_percentage += parseFloat(term.amount_per)
                }
                
            });
            if(total_percentage == 100.00){
                resourceService.TermDefinition.bulk({bulk_term: $scope.newTermDefinitions})
                    .$promise.then(function(responce){
                        $scope.termDefinitions = resourceService.TermDefinition.query()
                        $('#createModal').modal('hide')
                    })
            }else{
                alert("Sum of the maount percentages are not 100.")
                return false;
            }
                
            
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


