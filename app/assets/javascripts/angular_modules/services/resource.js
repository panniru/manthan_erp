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
                                          "approve": { url: "/approval_items/:id/approve.json", id:'@id', method: "PUT"},
                                          "reject": { url: "/approval_items/:id/reject.json", id:'@id', method: "PUT"}
                                      }
                                    );
        var StudentMaster = $resource('/student_masters/:id.json', {id: '@id'}, 
                                      {
                                          "belongs_to_parent": { url: "/student_masters/belongs_to_parent.json", isArray: true}
                                      }
                                    );
        var GradeMaster = $resource('/grade_masters/:id.json', {id: '@id'});
        var SectionMaster = $resource('/grade_masters/:grade_master_id/section_masters/:id.json', {id: '@id', grade_master_id: '@grade_master_id'});
        var Book = $resource('/books/:id.json', {id: '@id'}, 
                                       {
                                           "bulk": { url: "/books/create_bulk", method:'POST'},
                                           "update": { method: "PUT"}
                                       }
                            );
        var RequestNewBook = $resource('/request_new_books/:id.json', {id: '@id'},
                             {
                                 "bulk": { url: "/request_new_books/create_bulk", method:'POST'},
                                 "update": { method: "PUT"}
                             }
                                      );
	var Route = $resource('/routes/:id.json', {id: '@id'}, 
			      {
                                  "update": { method: "PUT"}
                              }
                             );
        var Mealtype = $resource('/mealtypes/:id.json', {id: '@id'}, 
                             {
                                 "bulk": { url: "/mealtypes/create_bulk", method:'POST'},
                                 "update": { method: "PUT"}
                             }
                            );
        var Mealname = $resource('/mealnames/:id.json', {id: '@id'}, 
                                 {
                                     "bulk": { url: "/mealnames/create_bulk", method:'POST'},
                                     "update": { method: "PUT"}
                                 }
                                );
        
        
       
        return {
            FeeGradeBucket : FeeGradeBucket,
            TermDefinition : TermDefinition,
            PostDatedCheque : PostDatedCheque,
            DefaultMaster : DefaultMaster,
            ApprovalItem : ApprovalItem,
            StudentMaster : StudentMaster,
            GradeMaster : GradeMaster,
            SectionMaster : SectionMaster,
            Book : Book,
	    Route:Route,
            RequestNewBook : RequestNewBook,           
            Mealtype: Mealtype,
            Mealname: Mealname
        };
    }]);
})(angular, myApp);
