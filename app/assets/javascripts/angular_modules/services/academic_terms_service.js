(function(angular, app) {
    "use strict";
    app.service("academicTermsService",["$http", function($http) {
        var getAcademicTermsService = function(){
            var url = "/academic_terms/get_academic_terms_service.json"
            return $http.get(url);
        }; 

        var saveAcademicTermsService = function(save_academic_terms){
            var url = "/academic_terms/save_academic_terms.json"
            return $http.post(url,{academic_terms: save_academic_terms});
        };

        var deleteAcademicService = function(delete_academic_term_id){
            var url = "/academic_terms/delete_academic_terms.json"
            return $http.post(url, {academic_term_id: delete_academic_term_id}); 
        };

        return { 
            getAcademicTermsService : getAcademicTermsService,
            saveAcademicTermsService : saveAcademicTermsService,
            deleteAcademicService : deleteAcademicService,
        }        
    }]);    
})(angular, myApp);
