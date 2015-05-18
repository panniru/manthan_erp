(function(angular, app) {
    "use strict";    
    app.service("canteenManagementService",["$http",function($http) {

        var getMealtypeIdService = function(){
            var url = "/mealnames/getmealtypeidservice.json"
            return $http.get(url);
        };
       // var Mealname = $resource('/mealnames/:id.json', {id: '@id'}, //
    //                             {
      //                               "bulk": { url: "/mealnames/create_bulk", method:'POST'},
        //                             "update": { method: "PUT"}
          //                       }
            //                    );
        var getFoodWastage = function(){
            var url = "/food_wastages/get_food_wastage.json"
            return $http.get(url);
	};
	
	var getInventoryType = function(){
	    var url = "/mealtypes/home_index.json"
	    return $http.get(url);
	};

	var getinventoryView = function(){
            var url = "/inventories/get_inventory_view.json"
            return $http.get(url);
	};

	var updateStatus = function(status){
            var url = "/inventories/update_inventory_status.json"
            return $http.post(url, {status: status});
	};

	var requestInventoryMail =  function(myMailSubject,myMailMessage,myVendor,inventories){
	    var url = "/inventories/mail_to_vendors.json"
            return $http.post(url, { myMailSubject: myMailSubject, myMailMessage:myMailMessage, myVendor:myVendor, inventories: inventories});	    
	};
	
	var getmealnameView =  function(){
	    var url = "/mealnames/get_meal_names.json"
            return $http.get(url);
	};

        
	var getCanteenVendors =  function(){
	    var url = "/inventories/get_canteen_vendors.json"
            return $http.get(url);
	    
	};
	
	return {
            getMealtypeIdService: getMealtypeIdService,
	    getFoodWastage: getFoodWastage,
	    getinventoryView : getinventoryView,
	    updateStatus : updateStatus,
	    requestInventoryMail : requestInventoryMail,
	    getmealnameView : getmealnameView,
            getCanteenVendors : getCanteenVendors,
	    getInventoryType : getInventoryType
            //  Mealname:  Mealname
        };
        
    }]); 
})(angular, myApp);
