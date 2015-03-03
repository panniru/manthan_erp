(function(angular, app) {
    "use strict";
    app.service("labMappingService" , ["$http", function($http) {
        var getAllSubjects = function(){
            var url = "/lab_teacher_mappings/get_all_subjects.json"
            return $http.get(url);
        };
        var labMappings = function(){
            var url = "/lab_teacher_mappings/save_lab_mappings.json"
            return $http.get(url);
        };
        var saveMappings = function(mappings){
           
            var url = "/lab_teacher_mappings/savemappings.json"
            return $http.post(url, {mappings: mappings});            
        };
        
        var checkSubjectsTeachersMapping = function(mySubject){                      // alert(JSON.stringify(mySubject))
                                                                                     var url = "/lab_teacher_mappings/check_subjects_teachers_mapping.json"             
                                                                                     return $http.get(url,{params:{my_Subject: mySubject}});  
                                                              }; 
        
        var getMappings = function(mySubject){
            var url = "/lab_teacher_mappings/getmappings.json"
            return $http.post(url, {my_Subject: mySubject}); 
        }; 

        
        
        return {
            getAllSubjects : getAllSubjects,
            labMappings : labMappings,
            saveMappings : saveMappings,
            checkSubjectsTeachersMapping : checkSubjectsTeachersMapping,
            getMappings : getMappings
        };
    }]);
})(angular , myApp);


