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
	return {
            getMealtypeIdService: getMealtypeIdService,
	    getFoodWastage: getFoodWastage,
	    getinventoryView : getinventoryView,
	    updateStatus : updateStatus
          //  Mealname:  Mealname
        };
        
    }]); 
})(angular, myApp);
