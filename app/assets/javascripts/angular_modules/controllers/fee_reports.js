(function(angular, app) {
    "use strict";
    app.controller("FeeReportsController",["$scope", "feeReportService", "resourceService", "piChart", function($scope, feeReportService, resourceService,  piChart) {
        $scope.report_types = [{value: "payment_status", name: "Payment Status Report"}]
        $scope.grades = resourceService.GradeMaster.query();

        $scope.buildChart = function(){
            alert('drawing.....')
            feeReportService.payment_status_report($scope.grade)
                .then(function(response){
                    var count_chart_data= []
                    var sum_chart_data= []
                    var colors = ["#005CDE", "#00A36A", "#7D0096", "#992B00", "#DE000F", "#ED7B00"]
                    $scope.chartData = response.data; 
                    angular.forEach(response.data, function(value, index){
                        var label = value.payment_type 
                        count_chart_data.push({label: label, data: value.count, color: colors[index]})
                        sum_chart_data.push({label: label, data: value.total, color: colors[index]})
                        
                    });
                    piChart.drawChart("flot-placeholder", count_chart_data);
                    piChart.drawChart("flot-placeholder1", sum_chart_data);
                })
        }

        $scope.gridDataPoint = function(item){
            $("#drillModal").modal('show')
            var match = getMatchedElement(item.series.label)
            $scope.payment_type_id = match.payment_type_id
            $scope.payment_type = match.payment_type
            feeReportService.payment_type_details(1, match.payment_type_id)
                .then(function(response){
                    $scope.table_header = []
                    $scope.table_data = response.data
                    angular.forEach(response.data[0], function(value, key){
                        $scope.table_header.push(key)
                    });
                    console.log(JSON.stringify(response.data))
                    console.log(JSON.stringify(response.data))
                    $("#drillModal").modal('show')
                });
        }
        
        $scope.gridDataPoint1 = function(item){
            alert('Hey Dude.....Wassup..?? You are out of scope..!!' + JSON.stringify($scope.grades))
        }

        var getMatchedElement = function(label){
            for(var i =0 ; i < $scope.chartData.length; i++){
                if(label === $scope.chartData[i].payment_type){
                    return $scope.chartData[i];
                }
            }
    }
        
    }]);
})(angular, myApp);

