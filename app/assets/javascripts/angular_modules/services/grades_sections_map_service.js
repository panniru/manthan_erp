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

    app.service("sectionService",["$http", function($http) {
            var getSectionServiceView = function(){
                var url = "/time_tables/sectionserviceview.json"
                return $http.get(url);
            }; 

        return {
            getSectionServiceView : getSectionServiceView,
        }
        
    }]);   

  

})(angular, myApp);
