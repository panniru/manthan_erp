(function(angular, app) {
    "use strict";
    app.controller("StaffReportsController",["$scope", "staService","piChart", function($scope, staService,  piChart) {
        
        $scope.buildChart = function(){
            staService.status_report()
                .then(function(response){
                    piChart.drawChart("sta-flot-placeholder", response.data);
                })
        }

        $scope.gridStaDataPoint = function(item){
            $scope.drilItem = item.series.label
            $("#staModal").modal('show')
            staService.getStaffrecruitsOnStatus(item.series.label)
                .then(function(response){
                    $scope.table_data = response.data;
                })
        }


    }]);
})(angular, myApp);
