(function(angular, app) {
    "use strict";
    app.controller("ParentChequesController",["$scope", "monthlyPdcService", function($scope,monthlyPdcService) {
        $scope.status_type = [
            { value: "pending", text: "Pending" },
            {value:"cleared", text: "Cleared"}
        ];
        $scope.parent_cheques = []
        $scope.submitSearch = function(){
            monthlyPdcService.search_pdcs($('form[name="parentChequesSearchForm"]').serialize())
                .then(function(responce){
                    $scope.parent_cheques = responce.data
                });
        };

        $scope.clearCheque = monthlyPdcService.clear_cheque
        
    }]);
    
})(angular, myApp);


