(function(angular, app) {
    "use strict";
    app.service("gradesSectionsMapService",["$http", function($http) {

        var getGradesSectionsServiceView = function(){
         
            var url = "/grades_sections_mappings/get_grades_sections_service_view.json"
            return $http.get(url);
        }; 
        
        var saveGradesMappings = function(sections_grades){
            var url = "/grades_sections_mappings/save_grades_mappings.json"
            return $http.post(url, {mappings: sections_grades});    
        };

        return {
            getGradesSectionsServiceView : getGradesSectionsServiceView,
            saveGradesMappings : saveGradesMappings
        }  
    }]);   

})(angular, myApp);
