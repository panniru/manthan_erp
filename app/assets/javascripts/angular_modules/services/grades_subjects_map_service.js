(function(angular, app) {
    "use strict";
    app.service("gradesSubjectsMapService",["$http", function($http) {
        var getGradesSubjectsServiceView = function(){
            var url = "/grades_subjects_mappings/get_grades_subjects_service_view.json"
            return $http.get(url);
        }; 
        
        var saveGradesMappings = function(subjects_grades){
            var url = "/grades_subjects_mappings/save_grades_mappings.json"
            return $http.post(url, {mappings: subjects_grades});    
        };

        return {
            getGradesSubjectsServiceView : getGradesSubjectsServiceView,
            saveGradesMappings : saveGradesMappings
        }  
    }]);    

})(angular, myApp);
