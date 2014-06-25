(function(angular, app) {
    "use strict";
    app.service("gradeBucketService",["$resource", function($resource) {
        
        var FeeGradeBucket = $resource('/fee_grade_buckets/:id.json', {id: '@id'}, 
                                       {
                                           "bulk": { url: "/fee_grade_buckets/create_bulk", method:'POST'},
                                           "update": { method: "PUT"}
                                       }
                                      );
        
        return {
            FeeGradeBucket : FeeGradeBucket
        };
        
    }]);
})(angular, myApp);
