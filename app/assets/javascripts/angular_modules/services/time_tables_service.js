(function(angular, app) {
    "use strict";
    app.service("timeTableService",["$http", function($http) {
        
        var getTimeTableServiceView = function(){
            var url = "/time_tables/timetableserviceview.json"
            return $http.get(url);
        };
        
        var getDefaultPeriodsServiceView = function(){
            var url = "/time_tables/defaultperiodsserviceview.json"
            return $http.get(url);
        };    
        
        var getPeriods = function(myGrade,mySection){
            var url = "/time_tables/getperiods.json"
            return $http.post(url, {my_Grade: myGrade, my_Section: mySection}); 
        }; 
        
        var checkTimeTable = function(myGrade,mySection){           
            var url = "/time_tables/checktimetable.json"             
            return $http.get(url,{params:{my_Grade: myGrade, my_Section: mySection}});  
        }; 
        
        var getSectionServiceView = function(){
         
            var url = "/time_tables/sectionserviceview.json"
            return $http.get(url);
        };  
        
        var getSubjectServiceView = function(){
            var url = "/time_tables/subjectserviceview.json"
            return $http.get(url);
        };

        var getGradeServiceView = function(){
            var url = "/time_tables/gradeserviceview.json"
            return $http.get(url);
        };
        
        var savePeriods = function(timeperiods){
            var url = "/time_tables/saveperiods.json"
            return $http.post(url, {time_periods: timeperiods});
            
        };

        var getSectionsForGradeService = function(myGrade){
            var url = "/time_tables/get_sections_for_grade.json"
            return $http.get(url,{params:{my_Grade: myGrade}});
        };  

        var getSubjectsForGradeService = function(myGrade){
            var url = "/time_tables/get_subjects_for_grade.json"
            return $http.get(url,{params:{my_Grade: myGrade}});
        };  
    
    
        return {
            getTimeTableServiceView : getTimeTableServiceView,
            getPeriods : getPeriods,
            getDefaultPeriodsServiceView : getDefaultPeriodsServiceView,
            checkTimeTable: checkTimeTable,
            getSectionServiceView : getSectionServiceView,
            getSubjectServiceView : getSubjectServiceView,
            getGradeServiceView : getGradeServiceView,
            savePeriods : savePeriods,
            getSectionsForGradeService : getSectionsForGradeService,
            getSubjectsForGradeService : getSubjectsForGradeService
        };        
    }]);    
})(angular, myApp);
