(function(angular, app) {
    "use strict";
    app.controller("MonthlyPdcsGridController",["$scope","monthlyPdcService", function($scope, monthlyPdcService) {
        $scope.getGridView = function(){
            resetGrid();
        };

        var resetGrid = function(){
            $scope.monthlyPdcs = [];
            $scope.columnHeaders = [];
            $scope.rowHeaders = [];
            $scope.sumTotals = [];
            $scope.defaultAmounts = "true";
            $scope.isErrorsAt = [];
            monthlyPdcService.getMonthyPdcView()
                .then(function(result) {
                    var colHeads = new Set();
                    var rowHeads = new Set();
                    result.data.forEach(function(buckets){
                        var total_amount = 0.0;
                        buckets.forEach(function(bctWiseFee){
                            colHeads.add(bctWiseFee.post_dated_month);
                            rowHeads.add(bctWiseFee.fee_grade_bucket_name);
                            // on doing sum of the parseFloat giving long precessions so i am increasing the value by multiplying 1000 and devinding finally with 1000 
                            total_amount += isNaN(parseFloat(bctWiseFee.amount_in_rupees)) ? 0 : parseFloat((bctWiseFee.amount_in_rupees)*1000);

                        });
                        $scope.isErrorsAt.push(false)
    
                        $scope.sumTotals.push(total_amount/1000) 
                    });
                    
                    colHeads.forEach(function(val){
                        $scope.columnHeaders.push(val);
                    });
                    
                    rowHeads.forEach(function(val){
                        $scope.rowHeaders.push(val);
                    })

                    $scope.monthlyPdcs = result.data;
                });
        }

        $scope.saveMonthlyPdc = function(){
            if(checkSumTotal() ){
                monthlyPdcService.saveMonthlyPdc($scope.monthlyPdcs)
                    .then(function(result) {
                        window.location.href = "/grade_wise_fees"
                    });
            }
        };

        var checkSumTotal = function(){
            var status = true; 
            for(var i=0 ; i< $scope.monthlyPdcs.length ; i++){
                var row_total = 0; 
                $scope.monthlyPdcs[i].forEach(function(unit){
                    row_total += parseFloat(unit.amount_in_rupees);
                });
                if( row_total != $scope.sumTotals[i]){
                    $scope.isErrorsAt[i] = true
                    return false
                }
                $scope.isErrorsAt[i] = false
            }
            return true
        }

        $scope.showError = function(index){
            return $scope.isErrorsAt[index]
        }

        $scope.toggleAmounts = function(){
            if($scope.defaultAmounts == "true"){
                resetGrid();
            }else{
                $scope.monthlyPdcs.forEach(function(buckets){
                    buckets.forEach(function(bctWiseFee){
                        bctWiseFee.amount_in_rupees = 0 ; 
                    });
                });
            }
            
        };
    }]);
})(angular, myApp);


