(function(angular, app) {
    "use strict";
    app.service("routesService",["$http", function($http) {
        var getLocationServiceView = function(){
            var url = "/routes/get_location_view.json"
            return $http.get(url);
        };
	var routeMail = function(subject,text){
	    var url = "/routes/send_mail.json"
            return $http.post(url,{route_mail:{subject: subject, text: text }}); 
        };
	
        return {
            getLocationServiceView : getLocationServiceView,
	    routeMail : routeMail
        };
    }]);
})(angular, myApp);
