(function(angular, app) {
    "use strict";
    app.service("donationService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/donation_of_books/gradeserviceview.json"
            return $http.get(url);
        };
        
        
        var getSectionServiceView = function(){
            var url = "/donation_of_books/sectionserviceview.json"
            return $http.get(url);
        }; 
        
        
        return {
            getGradeServiceView : getGradeServiceView,
            getSectionServiceView : getSectionServiceView
            
        };
        
    }]);
})(angular, myApp);
