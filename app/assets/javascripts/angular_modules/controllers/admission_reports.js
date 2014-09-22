(function(angular, app) {
    "use strict";
    app.controller("AdmissionReportsController",["$scope", "admService","piChart", function($scope, admService,  piChart) {
        
        $scope.buildChart = function(){
            admService.status_report()
                .then(function(response){
                    piChart.drawChart("adm-flot-placeholder", response.data);
                })
        }

        $scope.gridAdmDataPoint = function(item){
            $scope.drilItem = item.series.label
            $(".admModal").modal('show')
            admService.getAdmissionsOnStatus(item.series.label)
                .then(function(response){
                    $scope.table_data = response.data;
                })
        }


    }]);
})(angular, myApp);
