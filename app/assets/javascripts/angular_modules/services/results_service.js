(function(angular, app) {
    "use strict";
    app.service("resultsService",["$http", function($http) {

        var getStudentForms = function(id){
            var url = "/results/get_student_forms.json?id="+id
            return $http.get(url);
        };



        var getGradesAndSections = function(){
            var url = "/results/get_grades_and_sections.json"
            return $http.get(url);
        };


        var getAllResults = function(klass){
            var url = "/results/get_all_results.json?klass="+klass
            return $http.get(url);
        };

        var getGrades = function(){
            var url = "/results/get_klasses.json"
            return $http.get(url);
        };

        var getGradeAssessmentMapping = function(){
            var url = "/final_results/get_assessment_grade_mappings_service.json"
            return $http.get(url);
        };
        var getBothValue = function(selected_user){
            var url = "/final_results/get_values.json?selected_user="+selected_user
            return $http.get(url);
        };
        var getGradingDefaults = function(f){
            var url = "/final_results/grading_defaults.json?f="+f
            return $http.get(url);
        };
        var saveTodayResult = function(save_result_details){
            var url = "/final_results/save_result_details.json"
            return $http.post(url,{save_result_details: save_result_details});
        };


        return {
            getAllResults : getAllResults,
            getGrades : getGrades,
            getGradeAssessmentMapping : getGradeAssessmentMapping,
            getBothValue : getBothValue,
            getGradingDefaults : getGradingDefaults,
            saveTodayResult : saveTodayResult,
            getGradesAndSections : getGradesAndSections,
            getStudentForms : getStudentForms
           
        };
    }]);
})(angular, myApp);
