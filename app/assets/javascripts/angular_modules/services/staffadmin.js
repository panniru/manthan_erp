(function(angular, app) {
    "use strict";
    app.service("staffadminsService",["$http", function($http) {
        var getCloseStatus = function(){
            var url = "/admissions/get_close_status.json"
            return $http.get(url);
        };
        
        var getStaffadminServiceView = function(){
            var url = "/staffadmins/get_faculty_names.json"
            return $http.get(url);
        };
        var getRoleAndHead = function(){
            var url = "/staffadmins/get_role_and_head.json"
            return $http.get(url);
        };
        var getPostServiceView = function(){
            var url = "/staffrecruits/get_post_view.json"
            return $http.get(url);
        };
        
        var getSubjects = function(){
            var url = "/staffrecruits/get_subject_view.json"
            return $http.get(url);
        };
        var getHeadServiceView = function(){
            var url = "/staffrecruits/get_head_view.json"
            return $http.get(url);
        };
        var getKlassServiceView = function(){
            var url = "/staffrecruits/get_klass_view.json"
            return $http.get(url);
        };


        return {
            getCloseStatus : getCloseStatus,
            getStaffadminServiceView : getStaffadminServiceView,
            getRoleAndHead : getRoleAndHead,
            getPostServiceView : getPostServiceView,
            getSubjects : getSubjects,
            getHeadServiceView : getHeadServiceView,
            getKlassServiceView : getKlassServiceView
            
        };
    }]);
})(angular, myApp);
