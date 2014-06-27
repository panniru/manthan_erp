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
        var DefaultMaster = $resource('/default_masters/:id.json', {id: '@id'}, 
                                       {
                                           "update": { method: "PUT"}
                                       }
                                      );
        var ApprovalItem = $resource('/approval_items/:id.json', {id: '@id'}, 
                                      {
                                          "update": { method: "PUT"},
                                          "fee_structure_approval_item": { url: '/approval_items/fee_structure_approval_item.json', method: "GET"},
                                          "approve": { url: "/approval_items/:id/approve.json", id:'@id', method: "PUT"}
                                      }
                                    );
        
        return {
            FeeGradeBucket : FeeGradeBucket,
            TermDefinition : TermDefinition,
            PostDatedCheque : PostDatedCheque,
            DefaultMaster : DefaultMaster,
            ApprovalItem : ApprovalItem
        };
        
    }]);
})(angular, myApp);
