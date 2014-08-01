(function(angular, app) {
    "use strict";    
    app.service("teachingPlanService",["$http","$q", function($http, $q) {
        var getFacultyNamesServiceView = function(){
            var url = "/teachers_time_tables/get_faculty_names_view.json"
            return $http.get(url);
        };
        
    	var getGradeServiceMapView = function(){
            var url = "/teaching_plans/gradeserviceview.json"
            return $http.get(url);
        };
        var getGradesSectionsService = function(faculty_id){
            //alert(faculty_id);
            var url = "/teaching_plans/getgradessectionsservice.json"           
            return $http.get(url,{params:{_faculty_id: faculty_id}});
        };

        var getGradesSectionSubjectService = function(faculty_id){
            //alert(faculty_id);
            var url = "/teaching_plans/get_grade_section_subject_service.json"           
            return $http.get(url,{params:{_faculty_id: faculty_id}});
        };

        
        
        var getFacultyIdService = function(){
            var url = "/teaching_plans/getfacultyidservice.json"
            return $http.get(url);
        };
        
        var getSectionServiceMapView = function(){
            var url = "/teaching_plans/sectionserviceview.json"
            return $http.get(url);
        };
        var getMonthlyCalendarService = function(){
            var url = "/teaching_plans/getmonthlycalendarservice.json"
            return $http.get(url);
        };
        var getMonthDataService = function(month, faculty_master_id, grade_section_subject){
            var section_master_id = typeof grade_section_subject.section_master_id == 'undefined' ? "" : grade_section_subject.section_master_id
            var subject_master_id = typeof grade_section_subject.subject_master_id == 'undefined' ? "" : grade_section_subject.subject_master_id
            var grade_master_id = typeof grade_section_subject.grade_master_id == 'undefined' ? "" : grade_section_subject.grade_master_id
            var url = "/teaching_plans/getmonthdataservice.json?month="+month.month+"&faculty_master_id="+faculty_master_id+"&grade_master_id="+grade_master_id+"&section_master_id="+section_master_id+"&subject_master_id="+subject_master_id
            return $http.get(url);
        };
        
        var student_teaching_plans = function(student_id, date){
            var deferred = $q.defer();
            $http.get("/teaching_plans/student_teaching_plans.json?student_id="+student_id+"&dated_on="+date)
                .then(function(data){
                    deferred.resolve(data)
                },function(error){
                    deferred.reject(data)
                });
            
            return deferred.promise;
        }

        var getFacultyDatesService  = function(month){
            var url = "/teaching_plans/getfacultydatesservice.json"
            return $http.get(url);
        };
        
    	return {
    	    getGradeServiceMapView : getGradeServiceMapView,
            getFacultyIdService : getFacultyIdService,
            getGradesSectionsService : getGradesSectionsService,
            getSectionServiceMapView : getSectionServiceMapView ,
            getGradesSectionSubjectService : getGradesSectionSubjectService ,
            getMonthlyCalendarService : getMonthlyCalendarService,
            getMonthDataService :  getMonthDataService,                
            student_teaching_plans : student_teaching_plans,
            getFacultyNamesServiceView :  getFacultyNamesServiceView,
            getFacultyDatesService : getFacultyDatesService

        }; 
        
    }]); 
})(angular, myApp);
