(function(angular, app) {
    "use strict";
    app.service("formService",["$http", function($http) {
	
	var saveForm = function(form_details){
	    var url = "/form24/save_form.json"
	    return $http.post(url,{form_details: form_details});
	};
	var getFormServiceView = function(){
	    var url = "/form24/get_tds.json"
	    return $http.get(url);
	};


	return {
	    saveForm :  saveForm,
	    getFormServiceView : getFormServiceView
	};
    }]);
})(angular,  myApp);
