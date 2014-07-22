(function(angular, app) {
    "use strict";
    app.service("recruitmentsService",["$http", function($http) {
        var getSubjectServiceView = function(){
            var url = "/recruitments/get_subject_view.json"
            return $http.get(url);
        };
        return {
            getSubjectServiceView : getSubjectServiceView
        };
   
    }]);
})(angular, myApp);
