(function(angular, app) {
    "use strict";
    app.service("classTeacherService",["$http", function($http) {
        var getClassTeacherMappings = function(myGrade){
            //alert("h");
            var url = "/class_teacher_mappings/get_class_teacher_mappings.json"
            return $http.get(url, {params:{my_Grade: myGrade}}); 
        };        

        var getGradeWiseMappings = function(myGrade){
            //alert("h");
            var url = "/class_teacher_mappings/get_grade_wise_mappings.json"
            return $http.get(url, {params:{my_Grade: myGrade}}); 
        };

        var getGradeWiseFacultyNames  = function(myGrade){
            //alert("h");
            var url = "/class_teacher_mappings/get_grade_wise_faculty_names.json"
            return $http.get(url, {params:{my_Grade: myGrade}}); 
        };

        var saveMappings = function(save_mappings){
            var url = "/class_teacher_mappings/save_mappings.json"
            return $http.post(url, {mappings: save_mappings});
            
        };
        
        var deleteMappings = function(delete_mapping_id){
            var url = "/class_teacher_mappings/deletemappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };
        
        var checkForTeacherMapping = function(faculty_ids){
            //alert("h");
            var url = "/class_teacher_mappings/check_for_teacher_mapping.json"
            return $http.get(url); 
        }; 

        return {
            getClassTeacherMappings : getClassTeacherMappings,
            getGradeWiseMappings : getGradeWiseMappings,
            getGradeWiseFacultyNames : getGradeWiseFacultyNames,
            saveMappings : saveMappings,
            deleteMappings : deleteMappings,
            checkForTeacherMapping : checkForTeacherMapping
            
        }


    }]);


})(angular, myApp);
