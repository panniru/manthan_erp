(function(angular, app) {
    "use strict";
    app.service("gradeService",["$http", function($http) {

        var getGradeServiceView = function(){
            var url = "/time_tables/gradeserviceview.json"
            return $http.get(url);
        };
  
        var savePeriods = function(timeperiods){
            var url = "/time_tables/saveperiods.json"
            return $http.post(url, {time_periods: timeperiods});
            
        };

        var allGrades = function(){
            var url = "/fee_grade_buckets/all_grades.json"
            return $http.get(url);
        } 
       
        return {
            getGradeServiceView : getGradeServiceView,
            savePeriods : savePeriods,
            allGrades : allGrades,            
        };
        
    }]);
    
    app.service("sectionService",["$http", function($http) {

        var getSectionServiceView = function(){
            var url = "/time_tables/sectionserviceview.json"
            return $http.get(url);
        };        

        
        return {
            getSectionServiceView : getSectionServiceView        
        };
        
    }]);

    app.service("subjectService",["$http", function($http) {

        var getSubjectServiceView = function(){
            var url = "/time_tables/subjectserviceview.json"
            return $http.get(url);
        };
        
        return {
            getSubjectServiceView : getSubjectServiceView
        };
        
    }]);

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

        return {
            getTimeTableServiceView : getTimeTableServiceView,
            getPeriods : getPeriods,
            getDefaultPeriodsServiceView : getDefaultPeriodsServiceView,
            checkTimeTable: checkTimeTable
        };
        
    }]);   

})(angular, myApp);
