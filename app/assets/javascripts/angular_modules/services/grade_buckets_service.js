(function(angular, app) {
    "use strict";
    app.service("gradeBucketsService",["$http", function($http) {
        
        var index = function(){
            var url = "/fee_grade_buckets.json"
            return $http.get(url);
        };
        
        var createBulkGradeBuckets = function(serailized_form){
            var url = "/fee_grade_buckets/create_bulk.json?"+serailized_form
            return $http.post(url);
        };
        
        var updateFeeGradeBucket = function(fee_grade_bucket){
            var url = "/fee_grade_buckets/"+fee_grade_bucket.id+".json"
            return $http.put(url, {fee_grade_bucket: fee_grade_bucket} );
        };
        
        var destroy = function(fee_grade_bucket){
            var url = "/fee_grade_buckets/"+fee_grade_bucket.id+".json"
            return $http.delete(url);
        }
        return {
            createBulkGradeBuckets : createBulkGradeBuckets,
            updateFeeGradeBucket : updateFeeGradeBucket,
            index : index,
            destroy : destroy
        };
        
    }]);
})(angular, myApp);
