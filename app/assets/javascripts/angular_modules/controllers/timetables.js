(function(angular, app) {
    "use strict";

    options = [{
        name: 'Something Cool',
        value: 'something-cool-v\alue'
    }, {
        name: 'Something Else',
        value: 'something-else-value'
    }];

    app.controller('TimeTablesController', function($scope) {
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
