(function(angular, app) {
    "use strict";
    app.service("classTeacherService",["$http", function($http) {

        var getGradeWiseMappings = function(myGrade){
            //alert("h");
            var url = "/class_teacher_mappings/get_grade_wise_mappings.json"
            return $http.get(url, {params:{my_Grade: myGrade}}); 
        };


        return {
            getGradeWiseMappings : getGradeWiseMappings
        }


    }]);


})(angular, myApp);
