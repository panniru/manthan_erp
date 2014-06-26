(function(angular, app) {
    "use strict";
    app.service("resourceService",["$resource", function($resource) {
        
        var FeeGradeBucket = $resource('/fee_grade_buckets/:id.json', {id: '@id'}, 
                                       {
                                           "bulk": { url: "/fee_grade_buckets/create_bulk", method:'POST'},
                                           "update": { method: "PUT"}
                                       }
                                      );

        var TermDefinition = $resource('/term_definitions/:id.json', {id: '@id'}, 
                                       {
                                           "bulk": { url: "/term_definitions/create_bulk", method:'POST'},
                                           "update": { method: "PUT"}
                                       }
                                      );
        var PostDatedCheque = $resource('/post_dated_cheques/:id.json', {id: '@id'}, 
                                       {
                                           "bulk": { url: "/post_dated_cheques/create_bulk", method:'POST'},
                                           "update": { method: "PUT"}
                                       }
                                      );
        
        return {
            FeeGradeBucket : FeeGradeBucket,
            TermDefinition : TermDefinition,
            PostDatedCheque : PostDatedCheque
        };
        
    }]);
})(angular, myApp);
