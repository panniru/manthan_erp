(function(angular, app) {
    "use strict";
    app.service("payRollService",["$http", function($http) {
        var salaryBreakUps = function(ctc, basic, probation_date, designation){
            if(typeof probation_date == 'undefined' || probation_date == 'undefined'){
                probation_date = null
            }
            var url = "/salary_break_ups/break_up_report.json"
            return $http.get(url, {params: {ctc: ctc, basic: basic, probation_date: probation_date, designation: designation}});
        }
        
        return {
            salaryBreakUps : salaryBreakUps
        };
                    
    }]);
})(angular,  myApp);

