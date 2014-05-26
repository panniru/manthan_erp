(function(angular, app) {
    "use strict";
    app.controller('TermDefinitionsController', function($scope) {
        $scope.term_definitions = []
        for(var i=0; i<3; i++){
            $scope.term_definitions.push({"term_definition":"", "amount_per" :"" });
        };
	

	$scope.addMoreterms = function(){
            var lnt = parseInt($scope.term_definitions.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.term_definitions.push({"term_definition":""});
            };

        }
        
    });  
})(angular, myApp);
