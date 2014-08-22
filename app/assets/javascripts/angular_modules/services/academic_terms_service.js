(function(angular, app) {
    "use strict";
    app.service("academicTermsService",["$http", function($http) {
        var getAcademicTermsService = function(){
            var url = "/academic_terms/get_academic_terms_service.json"
            return $http.get(url);
        }; 

        return { 
            getAcademicTermsService : getAcademicTermsService,            
        }        
    }]);    
})(angular, myApp);
