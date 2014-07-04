(function(angular, app) {
    "use strict";
    app.controller("GradeWiseFeesController",["$scope","gradeWiseFeeService", function($scope, gradeWiseFeeService) {
        $scope.getGridView = function(){
            $scope.gradeWiseFees = [];
            $scope.columnHeaders = [];
            $scope.rowHeaders = [];
            $scope.sumTotals = [];
            gradeWiseFeeService.getGradewiseFeeView()
                .then(function(result) {
                    var colHeads = [];
                    var rowHeads = [];
                    result.data.forEach(function(buckets){
                        var total_amount = 0;
                        buckets.forEach(function(bctWiseFee){
                            if(colHeads.indexOf(bctWiseFee.fee_type_name) == -1){
                                colHeads.push(bctWiseFee.fee_type_name);
                            }
                            if(rowHeads.indexOf(bctWiseFee.fee_grade_bucket_name) == -1){
                                rowHeads.push(bctWiseFee.fee_grade_bucket_name);
                            }
                            
                            // on doing sum of the parseFloat giving long precessions so i am increasing the value by multiplying 1000 and devinding finally with 1000 
                            total_amount += isNaN(parseFloat(bctWiseFee.amount_in_rupees)) ? 0 : parseFloat(bctWiseFee.amount_in_rupees*1000) ;
                        });
                        $scope.sumTotals.push(total_amount/1000)
                    });
                    colHeads.forEach(function(val){
                        $scope.columnHeaders.push(val);
                    });
                    
                    rowHeads.forEach(function(val){
                        $scope.rowHeaders.push(val);
                    })

                    $scope.gradeWiseFees = result.data;
                });
        };
        
        $scope.sumTotal = function(index){
            var totalAmount = 0;
            $scope.gradeWiseFees[index].forEach(function(bctWiseFee){
                totalAmount += isNaN(parseFloat(bctWiseFee.amount_in_rupees)) ? 0 : parseFloat(bctWiseFee.amount_in_rupees);
            });
            
            $scope.sumTotals[index] = totalAmount;
        };

        $scope.saveBucketWiseFee = function(){
            gradeWiseFeeService.saveBucketWiseFee($scope.gradeWiseFees)
                .then(function(result) {
                    window.location.href = "/grade_wise_fees";
                });
        }
    }]);
    
})(angular, myApp);


