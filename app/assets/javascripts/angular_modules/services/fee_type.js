(function(angular, app) {
    "use strict";
    app.service("feeTypeService",["$http", function($http) {
        
        var index = function(){
            var url = "/fee_types.json"
            return $http.get(url);
        };
        
        var createBulkFeeTypes = function(fee_types){
            var url = "/fee_types/create_bulk.json?"
            return $http.post(url, {bulk_fee_types: fee_types});
        };
        
        var updateFeetype = function(fee_type){
            var url = "/fee_types/"+fee_type.id+".json"
            return $http.put(url, {fee_type: fee_type} );
        };
        
        var destroy = function(fee_type){
            var url = "/fee_types/"+fee_type.id+".json"
            return $http.delete(url);
        }
        return {
            createBulkFeeTypes : createBulkFeeTypes,
            updateFeetype : updateFeetype,
            index : index,
            destroy : destroy
        };
        
    }]);
})(angular, myApp);
