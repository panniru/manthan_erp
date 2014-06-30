(function(angular, app) {
    "use strict";
    app.service("teachersGradesService",["$http", function($http) {
        var getFacultyNamesServiceView = function(){
            var url = "/teachers_time_tables/get_faculty_names_view.json"
            return $http.get(url);
        };
        
        var checkTeachersGradesMapping = function(myTeacher){
            //alert("hello");
            var url = "/teacher_grade_mappings/check_teachers_grades_mapping.json"             
            return $http.get(url,{params:{my_Teacher: myTeacher}});  
        }; 

        var savePeriods = function(timeperiods){
            var url = "/teachers_time_tables/saveperiods.json"
            return $http.post(url, {time_periods: timeperiods});
            
        };
        
        var getPeriods = function(myTeacher){
            var url = "/teachers_time_tables/getperiods.json"
            return $http.post(url, {my_Teacher: myTeacher}); 
        }; 
       
        return {
            getFacultyNamesServiceView : getFacultyNamesServiceView,
            checkTeachersGradesMapping : checkTeachersGradesMapping,
            savePeriods : savePeriods,
            getPeriods : getPeriods
        };        
    }]);   

})(angular, myApp);
