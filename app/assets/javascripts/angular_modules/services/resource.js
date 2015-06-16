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
        var GradeMaster = $resource('/grade_masters/:id.json', {id: '@id'},
                                    {
                                        "sections": {url: "/grade_masters/:id/sections.json", id: '@id', method: "GET", isArray: false}
                                    }
                                   );        
        var Book = $resource('/books/:id.json', {id: '@id'}, 
                                       {
                                           "bulk": { url: "/books/create_bulk", method:'POST'},
                                           "update": { method: "PUT"},
                                           "add_bulk": { url: "/books/add_bulk", method:'POST'},
                                       }
                            );

        var Assess = $resource('/admissions/:id.json', {id: '@id'},
                               {
                                   "update": {method: "PUT"}
                               }
                              );
        var SetupMaster = $resource('/setup_masters/:id.json', {id: '@id'},
                               {
                                   "update": {method: "PUT"}
                               }
                              );


        var Recruitment = $resource('/staffrecruits/:id.json', {id: '@id'},
                                   {
                                       "update": {method: "PUT"}

                                   }
                                  );



        var Reason = $resource('/statuses/:id.json', {id: '@id'},
                               {
                                   "update": {method: "PUT"}
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
				  "locations": { url: "/routes/:id/locations.json", id:'@id', isArray: true},
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



        var Inventory = $resource('/inventories/:id.json', {id: '@id'}, 
                                  {
                                      "bulk": { url: "/inventories/create_bulk", method:'POST'},
                                      "update": { method: "PUT"}
                                  }
                                );
	
        var CanteenManagement = $resource('/canteen_managements/:id.json', {id: '@id'}, 
					  {
                                 "bulk": { url: "/canteen_managements/create_bulk", method:'POST'},
                                 "update": { method: "PUT"}
                             }
                            );

	var SpecialDayTransport = $resource('/special_day_transports/:id.json', {id: '@id'}, 
					  {
                                 "bulk": { url: "/special_say_transports/create_bulk", method:'POST'},
                                 "update": { method: "PUT"}
                             }
                            );
        var DamageBook = $resource('/damagebooks/:id.json', {id: '@id'});
        var BlockBook = $resource('/block_books/:id.json', {id: '@id'});
        var RequestBook = $resource('/request_books/:id.json', {id: '@id'},
            {                      "pending_requests": { url: "/request_books/pending_request_books.json", method:'GET', isArray: true},
                                   "delivered_requests": { url: "/request_books/delivered_request_books.json", method:'GET', isArray: true}
            }    
                                   );
        var DonateBook = $resource('/donate_books/:id.json', {id: '@id'});
        var SubjectMaster = $resource('/subject_masters/:id.json', {id: '@id'},
                                    { "bulk": { url: "/subject_masters/create_bulk.json", method:'POST', isArray: true},
                                      "update": { method: "PUT"}
                                    }  
                                   );
        var SectionMaster = $resource('/section_masters/:id.json', {id: '@id'},
                                    { "bulk": { url: "/section_masters/create_bulk.json", method:'POST', isArray: true},
                                      "update": { method: "PUT"}
                                    }  
                                   );
        var CommunicationMail = $resource('/communication_mails/:id.json', {id: '@id'},
                                          {
                                              "query": { url: "/communication_mails.json", method:'GET', isArray: false},
                                              "newMail": { url: "/communication_mails/new.json", method:'GET', isArray: false},
                                              "sendMail": { url: "/communication_mails/send_mail.json", method:'POST'},
                                              "mailDetail": { url: "/communication_mails/:id/mail_detail.json", method:'GET', isArray: false},
                                              "reply": {url: "/communication_mails/:id/reply.json", method: "POST"},
                                              "markAsRead": {url: "/communication_mails/:id/mark_as_read.json", method: "PUT"}
                                          }  
                                         );

        var ActivityMaster = $resource('/activity_masters/:id.json', {id: '@id'},
                                       { "bulk": { url: "/activity_masters/create_bulk.json", method:'POST', isArray: true},
                                        "update": { method: "PUT"}
                                      }  
                                     );
        
        var Designation = $resource('/designations/:id.json', {id: '@id'},
                                      { "bulk": { url: "/designations/create_bulk.json", method:'POST', isArray: true},
                                        "update": { method: "PUT"}
                                      }  
                                     );
        
        var FacultyMaster = $resource('/faculty_masters/:id.json', {id: '@id'},
                                    {
                                        "update": {method: "PUT"}

                                    }
                                   );
        var House = $resource('/school_houses/:id.json', {id: '@id'},
                                    { "bulk": { url: "/school_houses/create_bulk.json", method:'POST', isArray: true},
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
            Book : Book,
            Assess : Assess,
            Recruitment : Recruitment,
	    Route:Route,
            Reason : Reason, 
            RequestNewBook : RequestNewBook,           
            Mealtype: Mealtype,
            Mealname: Mealname,
            Inventory: Inventory,
            CanteenManagement: CanteenManagement,
	    SpecialDayTransport:SpecialDayTransport,
            DamageBook : DamageBook,
            BlockBook : BlockBook,
            RequestBook : RequestBook,
            DonateBook : DonateBook,
            SubjectMaster : SubjectMaster,
            SectionMaster : SectionMaster,
            CommunicationMail : CommunicationMail,
            ActivityMaster : ActivityMaster,
            SetupMaster : SetupMaster,
            Designation : Designation,
            FacultyMaster : FacultyMaster,
            House : House

        };
    }]);
})(angular, myApp);
