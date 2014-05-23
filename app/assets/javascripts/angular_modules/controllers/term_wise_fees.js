(function(angular, app) {
    "use strict";
    app.controller("TermWiseFeesController",["$scope","termWiseFeeService", function($scope, termWiseFeeService) {
        $scope.getGridView = function(){
            resetGrid();
        };


        var resetGrid = function(){
            $scope.termWiseFees = [];
            $scope.columnHeaders = [];
            $scope.rowHeaders = [];
            $scope.sumTotals = [];
            $scope.defaultAmounts = "true";
            $scope.isErrorsAt = [];
            termWiseFeeService.getTermWiseFeeView()
                .then(function(result) {
                    var colHeads = new Set();
                    var rowHeads = new Set();
                    result.data.forEach(function(buckets){
                        var total_amount = 0;
                        buckets.forEach(function(bctWiseFee){
                            colHeads.add(bctWiseFee.term_definition_name);
                            rowHeads.add(bctWiseFee.fee_grade_bucket_name);
                            // on doing sum of the parseFloat giving long precessions so i am increasing the value by multiplying 1000 and devinding finally with 1000 
                            total_amount += isNaN(parseFloat(bctWiseFee.amount_in_rupees)) ? 0 : parseFloat(bctWiseFee.amount_in_rupees*1000) ;
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

                    $scope.termWiseFees = result.data;
                });
        }

        $scope.saveTermWiseFee = function(){
            if(checkSumTotal() ){
                termWiseFeeService.saveTermWiseFee($scope.termWiseFees)
                    .then(function(result) {
                        alert(result)
                    });
            }
        };

        var checkSumTotal = function(){
            var status = true; 
            for(var i=0 ; i< $scope.termWiseFees.length ; i++){
                var row_total = 0; 
                $scope.termWiseFees[i].forEach(function(unit){
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
                $scope.termWiseFees.forEach(function(buckets){
                    buckets.forEach(function(bctWiseFee){
                        bctWiseFee.amount_in_rupees = 0 ; 
                    });
                });
            }
            
        };
    }]);
    
})(angular, myApp);


