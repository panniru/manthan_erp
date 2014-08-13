(function(angular, app) {
    "use strict";
    app.controller("AdmissionReportsController",["$scope", "feeReportService",  "piChart", function($scope, feeReportService,  piChart) {
        $scope.buildChart = function(){
            alert('hi');
            feeReportService.status_new()
                .then(function(response){
                    alert(JSON.stringify(response.data));
                    var count_chart_data= []
                    var sum_chart_data= []
                    var colors = ["#005CDE", "#00A36A", "#7D0096", "#992B00", "#DE000F", "#ED7B00"]
                    $scope.chartData = response.data; 
                    angular.forEach(response.data, function(value, index){
                        var label = value.status_new
                        count_chart_data.push({label: label, data: value.count, color: colors[index]})
                        sum_chart_data.push({label: label, data: value.total, color: colors[index]})
                    });
                    piChart.drawChart("flot-placeholder", count_chart_data);
                    piChart.drawChart("flot-placeholder1", sum_chart_data);
                })
        }
    }]);
})(angular, myApp);
