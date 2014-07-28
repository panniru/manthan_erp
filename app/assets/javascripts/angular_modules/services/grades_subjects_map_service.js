(function(angular, app) {
    "use strict";
    app.service("gradesSubjectsMapService",["$http", function($http) {
       
        var getGradesSubjectsServiceView = function(){
            var url = "/grades_subjects_mappings/get_grades_subjects_service_view.json"
            return $http.get(url);
        };  

        var saveSubjectsMappings = function(grades_subjects){
            //alert("in service");
            var url = "/grades_subjects_mappings/save_subjects_mappings.json"
            return $http.post(url, {mappings: grades_subjects});    
        };

        return {
            getGradesSubjectsServiceView : getGradesSubjectsServiceView,
            saveSubjectsMappings : saveSubjectsMappings
        }  
    }]);    

})(angular, myApp);
