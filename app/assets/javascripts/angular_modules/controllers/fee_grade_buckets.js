(function(angular, app) {
    "use strict";
    app.controller("FeeGradeBucketsController",["$scope", "gradeService", "gradeBucketService",  function($scope, gradeService, gradeBucketService) {
        $scope.feeGradeBuckets = []
        $scope.feeGradeBuckets = gradeBucketService.FeeGradeBucket.query()

        
        $scope.newGradeBuckets = function(){
            $scope.newFeeGradeBuckets = [] 
            addBuckets(3);
            load_grades();
            $('#createModal').modal('show')
        }

        $scope.addMoreBuckets = function(){
            if(!isLastGradeMatched()){
                var prev_len = $scope.newFeeGradeBuckets.length
                addBuckets(3);
                $scope.gradeChangeActionTo(prev_len-1)
            }
        }
        
        var addBuckets = function(count){
            for(var i=0; i<count; i++){
                $scope.newFeeGradeBuckets.push({"grade_from": null, "grade_to":null, "optionsFrom":[], "optionsTo":[] });
            }
        }

        $scope.editGradeBuckets = function(){
            $scope.newFeeGradeBuckets = angular.copy($scope.feeGradeBuckets);
            load_grades();
            $('#createModal').modal('show');
        }

        var load_grades = function(){
            if(typeof $scope.grades != 'undefined' && $scope.grades.length > 0){
                angular.forEach($scope.newFeeGradeBuckets, function(value){
                    value.grade_from = parseInt(value.grade_from)
                    value.grade_to = parseInt(value.grade_to)
                    value.optionsFrom = $scope.grades
                    value.optionsTo = $scope.grades
                });
            }else{
                gradeService.allGrades()
                    .then(function(responce){
                        $scope.grades = responce.data
                        angular.forEach($scope.newFeeGradeBuckets, function(value){
                            value.grade_from = parseInt(value.grade_from)
                            value.grade_to = parseInt(value.grade_to)
                            value.optionsFrom = $scope.grades
                            value.optionsTo = $scope.grades
                        })
                    });
            }
            
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
                    }, function(error){
                        alert(error.status +": " +error.statusText )
                        load_grades();
                    });
            }else{
                alert("Invalid grade buckets. Please verify..!!")
                load_grades();
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
            gradeBucket.optionsTo = getOptions(gradeBucket.grade_from,$scope.grades, "to");
        };
        
        $scope.gradeChangeActionTo = function(index){
            var gradeBucket = $scope.newFeeGradeBuckets[index]
            if(typeof $scope.newFeeGradeBuckets[index+1] != 'undefined'){
                var nextBucket = $scope.newFeeGradeBuckets[index+1]
                nextBucket.optionsFrom = getOptions(gradeBucket.grade_to,$scope.grades, "from");
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
            return (gradeBucket.grade_to >= gradeBucket.grade_from)
        }


        var getOptions = function(lowerLimit, grades, type){
            var options = []
            angular.forEach(grades, function(grade){
                if(type === 'to' && grade.id >= lowerLimit){
                    options.push(grade)
                }else if(type === 'from' && grade.id > lowerLimit){
                    options.push(grade)
                }
            });
            return options;
        };

        var isFormValid = function(){
            deleteEmptyGrades();
            for(var i= 0; i <  $scope.newFeeGradeBuckets.length ; i++){
                if(!($scope.isValidFromOption(i) && $scope.isValidToOption(i))){
                    return false;
                }
            }
            return isLastGradeMatched()
        }

        var isLastGradeMatched = function(){
            var gradeBucket = $scope.newFeeGradeBuckets[$scope.newFeeGradeBuckets.length-1]
            if(gradeBucket.grade_to != null){
                return gradeBucket.grade_to === $scope.grades[$scope.grades.length-1].id
            }else{
                return gradeBucket.grade_from === $scope.grades[$scope.grades.length-1].id
            }

        }

        var deleteEmptyGrades = function(){
            var invalidIndeces = []
            for(var i= 0; i <  $scope.newFeeGradeBuckets.length ; i++){
                if($scope.newFeeGradeBuckets[i].grade_from == null ||
                    angular.equals($scope.newFeeGradeBuckets[i].grade_to,NaN )  ||
                   $scope.newFeeGradeBuckets[i].grade_to == null ||
                   angular.equals($scope.newFeeGradeBuckets[i].grade_to,NaN )){
                    invalidIndeces.push($scope.newFeeGradeBuckets[i])
                };
            }
            angular.forEach(invalidIndeces, function(grade){
                $scope.newFeeGradeBuckets.splice($scope.newFeeGradeBuckets.indexOf(grade), 1)
            });
        }
    }]);
	
})(angular, myApp);
