(function(angular, app) {
    "use strict";
    app.service("gradesSectionsMapService",["$http", function($http) {

        var saveSectionsMappings= function(grades_sections){
            var url = "/grades_sections_mappings/save_sections_mappings.json"
            return $http.post(url, {mappings: grades_sections});          
        };



        return {
            saveSectionsMappings : saveSectionsMappings,
        }     



    }]);   

})(angular, myApp);
