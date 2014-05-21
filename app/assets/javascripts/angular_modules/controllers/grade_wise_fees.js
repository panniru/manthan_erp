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
                    var colHeads = new Set();
                    var rowHeads = new Set();
                    result.data.forEach(function(buckets){
                        var total_amount = 0;
                        buckets.forEach(function(bctWiseFee){
                            colHeads.add(bctWiseFee.fee_type_name);
                            rowHeads.add(bctWiseFee.fee_grade_bucket_name);
                            total_amount += isNaN(parseInt(bctWiseFee.amount_in_rupees)) ? 0 : parseInt(bctWiseFee.amount_in_rupees) ;
                        });
                        $scope.sumTotals.push(total_amount)
                    });
                    $scope.columnHeaders = [c for (c of colHeads)]
                    $scope.rowHeaders = [r for (r of rowHeads)]
                    $scope.gradeWiseFees = result.data;
                });
        };
        
        $scope.sumTotal = function(index){
            var totalAmount = 0;
            $scope.gradeWiseFees[index].forEach(function(bctWiseFee){
                totalAmount += isNaN(parseInt(bctWiseFee.amount_in_rupees)) ? 0 : parseInt(bctWiseFee.amount_in_rupees);
            });
            
            $scope.sumTotals[index] = totalAmount;
        };

        $scope.saveBucketWiseFee = function(){
            gradeWiseFeeService.saveBucketWiseFee($scope.gradeWiseFees)
                .then(function(result) {
                    alert(result);
                });
        }
    }]);
    
})(angular, myApp);


