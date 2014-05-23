(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope", function($scope) {
        $scope.post_dated_cheques = []
        for(var i=0; i<12; i++){
            $scope.post_dated_cheques.push({"date":""});
        };
        
        $scope.addMoreterms = function(){
            var lnt = parseInt($scope.date.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.post_dated_cheques.push({"amount":""});
            };
        }
    }]);
    
})(angular, myApp);



