(function(angular, app) {
    "use strict";
    app.service("designationService",["$http", function($http) {
	var getDesignationServiceView = function(page){
	    var url = "/designation_masters/map.json?page="+page
	    return $http.get(url);
	};
	
	var saveDesignation = function(designation_details){
	    var url = "/designation_masters/save_designation.json"
	    return $http.post(url,{designation_details: designation_details});
	};

	var getDayEndsServiceView = function(day_ends){
	    var url = "/default_masters/days.json"
	    return $http.put(url,{day_ends: day_ends});
	};
	
	var getDayEndView = function(){
	    var url = "/default_masters/day_ends.json"
	    return $http.get(url);
	};



	return {
	    getDesignationServiceView : getDesignationServiceView,
	    saveDesignation :  saveDesignation,
	    getDayEndsServiceView : getDayEndsServiceView,
	    getDayEndView : getDayEndView
	};
    }]);
})(angular,  myApp);
