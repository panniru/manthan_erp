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

	var getinventoryView = function(){
            var url = "/inventories/get_inventory_view.json"
            return $http.get(url);
	};

	var updateStatus = function(status){
            var url = "/inventories/update_inventory_status.json"
            return $http.post(url, {status: status});
	};

	var requestInventoryMail =  function(inventories){
	    var url = "/inventories/mail_to_vendors.json"
            return $http.post(url, { inventories: inventories});
	    
	};
	
	var getmealnameView =  function(){
	    var url = "/mealnames/get_meal_names.json"
            return $http.get(url);
	};
	
	return {
            getMealtypeIdService: getMealtypeIdService,
	    getFoodWastage: getFoodWastage,
	    getinventoryView : getinventoryView,
	    updateStatus : updateStatus,
	    requestInventoryMail : requestInventoryMail,
	    getmealnameView : getmealnameView
          //  Mealname:  Mealname
        };
        
    }]); 
})(angular, myApp);
