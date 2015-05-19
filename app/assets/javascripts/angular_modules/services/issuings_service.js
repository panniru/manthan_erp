(function(angular, app) {
    "use strict";
    app.service("issuingService",["$http", function($http) {
        var getGradeServiceView = function(){
            var url = "/issuings/gradeserviceview.json"
            return $http.get(url);
        };
        
        var getGradeSectionServiceView = function(myGrade){
            var url = "/issuings/grade_section_service.json"
            return $http.get(url,{params : {my_Grade : myGrade}});
        }; 

        var getMappings = function(){
            var url = "/issuings/get_mappings.json"
            return $http.get(url);
        };
        var getValue = function(selected_user){
          
            var url = "/issuings/get_students.json?selected_user="+selected_user
            return $http.get(url);
        };

        var save_values = function(student_id,book_id,grade_master_id,section_master_id,date){
           
            var url = "/issuings/save_values.json"
            return $http.post(url, {student_id: student_id,book_id: book_id,grade_master_id: grade_master_id,section_master_id: section_master_id,book_return_date: date});
        };
        var update_values = function(issuing_id){
            alert(JSON.stringify(issuing_id))
            var url = "/issuings/"+issuing_id+"/update_values.json"
            return $http.put(url, {issuing_id: issuing_id});
        };
        var get_issuings = function(){
            var url = "/issuings/get_issuings.json"
            return $http.get(url);
        };

        
        return {
            getGradeServiceView : getGradeServiceView,
            getGradeSectionServiceView : getGradeSectionServiceView,
            getMappings : getMappings,
            getValue : getValue,
            save_values :save_values,
            get_issuings :get_issuings,
            update_values :update_values     
        };


        
    }]);
})(angular, myApp);
