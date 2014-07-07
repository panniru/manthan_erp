(function(angular, app) {
    "use strict";
    app.controller("FeeGradeBucketsController",["$scope", "gradeService", "gradeBucketService",  function($scope, gradeService, gradeBucketService) {
        $scope.feeGradeBuckets = []
        //alert(gradeBucketService.FeeGradeBucket.query())
        $scope.feeGradeBuckets = gradeBucketService.FeeGradeBucket.query()
        
        $scope.newGradeBuckets = function(){
            $scope.newFeeGradeBuckets = [] 
            for(var i=0; i<3; i++){
                $scope.newFeeGradeBuckets.push({"grade_from": null, "grade_to":null, "optionsFrom":[], "optionsTo":[] });
            }
            load_grades();
            $('#createModal').modal('show')
        }

        $scope.editGradeBuckets = function(){
            $scope.newFeeGradeBuckets = $scope.feeGradeBuckets;
            load_grades();
            $('#createModal').modal('show');
        }

        var load_grades = function(){
            gradeService.allGrades()
                .then(function(responce){
                    $scope.grades = responce.data
                    $scope.newFeeGradeBuckets[0]['optionsFrom'] = responce.data
                });
        }

        $scope.submitGradeBuckets = function(){
            angular.forEach($scope.newFeeGradeBuckets, function(bucket){
                delete bucket["optionsFrom"]
                delete bucket["optionsTo"]
            })
            if (isFormValid()){
                gradeBucketService.FeeGradeBucket.bulk({bulk_fee_grade_buckets: $scope.newFeeGradeBuckets})
                    .$promise.then(function(responce){
                        $scope.feeGradeBuckets = gradeBucketService.FeeGradeBucket.query()
                        $('#createModal').modal('hide')
                    })
            }else{
                alert("All the grades are not included")
            }
            
        };
        
        $scope.destroy = function(feeGradeBucket){
            feeGradeBucket.$delete()
                .then(function(responce){
                    $scope.feeGradeBuckets.splice($scope.feeGradeBuckets.indexOf(feeGradeBucket), 1)
                })
        };
        
        $scope.gradeChangeActionFrom = function(index){
            var gradeBucket = $scope.newFeeGradeBuckets[index]
            gradeBucket.optionsTo = getOptions(gradeBucket.grade_from,$scope.grades);
        };
        
        $scope.gradeChangeActionTo = function(index){
            var gradeBucket = $scope.newFeeGradeBuckets[index]
            if(typeof $scope.newFeeGradeBuckets[index+1] != 'undefined'){
                var nextBucket = $scope.newFeeGradeBuckets[index+1]
                nextBucket.optionsFrom = getOptions(gradeBucket.grade_to,$scope.grades);
            }
        };

        $scope.isValidFromOption = function(index){
            var gradeBucket = $scope.newFeeGradeBuckets[index]
            if(typeof $scope.newFeeGradeBuckets[index-1] != 'undefined'){
                var prevBucket = $scope.newFeeGradeBuckets[index-1]
                return (gradeBucket.grade_from - prevBucket.grade_to === 1)
            }else{
                return (gradeBucket.grade_from === $scope.grades[0].id)
            }
        }

        $scope.isValidToOption = function(index){
            var gradeBucket = $scope.newFeeGradeBuckets[index]
            return (gradeBucket.grade_to > gradeBucket.grade_from)
        }


        var getOptions = function(lowerLimit, grades){
            var options = []
            angular.forEach(grades, function(grade){
                if(grade.id > lowerLimit){
                    options.push(grade)
                }
            });
            return options;
        };

        var isFormValid = function(){
            var gradeBucket = $scope.newFeeGradeBuckets[$scope.newFeeGradeBuckets.length-1]
            if(gradeBucket.grade_to != null){
                return gradeBucket.grade_to === $scope.grades[$scope.grades.length-1].id
            }else{
                return gradeBucket.grade_from === $scope.grades[$scope.grades.length-1].id
            }
        }
    }]);
	
})(angular, myApp);
