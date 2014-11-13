(function(angular, app) {
    "use strict";
    app.service("issuingService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/issuings/gradeserviceview.json"
            return $http.get(url);
        };
        
        var getGradeSectionServiceView = function(myGrade){
            var url = "/issuings/grade_section_service.json"
            return $http.get(url,{params : {my_Grade : myGrade}});
        }; 
        
        return {
            getGradeServiceView : getGradeServiceView,
            getGradeSectionServiceView : getGradeSectionServiceView,           
        };


        
    }]);
})(angular, myApp);
