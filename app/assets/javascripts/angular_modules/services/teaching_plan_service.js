(function(angular, app) {
    "use strict";
    app.service("teachingPlanService",["$http", function($http) {
        
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
        
    	return {
    	    getGradeServiceMapView : getGradeServiceMapView,
            getFacultyIdService : getFacultyIdService,
            getGradesSectionsService : getGradesSectionsService,
            getSectionServiceMapView : getSectionServiceMapView ,
            getGradesSectionSubjectService : getGradesSectionSubjectService           
        }; 
        
    }]); 
})(angular, myApp);
