(function(angular, app) {
    "use strict";
    app.service("feeReportService",["$http", function($http) {
        var payment_status_report = function(grade){
            return $http.get("/fee_reports/payment_status_report.json", {params: {grade_id: grade}})
        }
        
        var payment_type_details = function(grade, payment_type){
            return $http.get("/fee_reports/payment_type_details.json", {params: {grade_id: grade, payment_type_id: payment_type}})
        }
        
        
        var status_new = function(){
            alert("service hi");
            return $http.get("/admission_reports/get_status_view.json")
        }
        return {
            payment_status_report : payment_status_report,
            payment_type_details : payment_type_details,
            status_new : status_new
        }; 
    }]);
})(angular, myApp);
