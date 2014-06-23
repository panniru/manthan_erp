(function(angular, app) {
    "use strict";
    app.controller("FeeGradeBucketsController",["$scope", "gradeService",  function($scope, gradeService) {
        $scope.feeGradeBuckets = []

        $scope.newfeeGradeBuckets = function(){
            for(var i=0; i<5; i++){
                $scope.feeGradeBuckets.push({"gradeFrom": null, "gradeTo":null, "optionsFrom":[], "optionsTo":[] });
            };
            $('#createModal').modal('show')
        };
        
        feeTypeService.index()
            .then(function(responce){
                $scope.fee_types = responce.data
            });
        

        $scope.addMorefeeTypes = function(){
            var lnt = parseInt($scope.fee_types.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.new_fee_types.push({"fee_type":""});
            };
        }
        
        $scope.create = function(){
            feeTypeService.createBulkFeeTypes($("form#createFeeTypes").serialize())
                .then(function(responce){
                    angular.forEach(responce.data, function(value) {
                        this.push(value);
                    }, $scope.fee_types);
                    $('#createModal').modal('hide')
                });
        }

        $scope.edit = function(fee_type){
            $scope.fee_type = fee_type
            $("#editModal").modal("show")
        }
        

        $scope.update = function(fee_type){
            feeTypeService.updateFeetype(fee_type)
                .then(function(responce){
                    $('#editModal').modal('hide')
                });
        };

        $scope.destroy = function(fee_type){
            feeTypeService.destroy(fee_type)
                .then(function(responce){
                    $scope.fee_types.splice($scope.fee_types.indexOf(fee_type), 1)
                });
        };

        for(var i=0; i<3; i++){
            $scope.feeGradeBuckets.push({"gradeFrom": null, "gradeTo":null, "optionsFrom":[], "optionsTo":[] });
        };
        
        gradeService.allGrades()
            .then(function(responce){
                $scope.grades = responce.data
                $scope.feeGradeBuckets[0]['optionsFrom'] = responce.data
            });

        $scope.gradeChangeActionFrom = function(index){
            var gradeBucket = $scope.feeGradeBuckets[index]
            gradeBucket.optionsTo = getOptions(gradeBucket.gradeFrom,$scope.grades);
        };
        
        $scope.gradeChangeActionTo = function(index){
            var gradeBucket = $scope.feeGradeBuckets[index]
            if(typeof $scope.feeGradeBuckets[index+1] != 'undefined'){
                var nextBucket = $scope.feeGradeBuckets[index+1]
                nextBucket.optionsFrom = getOptions(gradeBucket.gradeTo,$scope.grades);
            }
        };

        $scope.isValidFromOption = function(index){
            var gradeBucket = $scope.feeGradeBuckets[index]
            if(typeof $scope.feeGradeBuckets[index-1] != 'undefined'){
                var prevBucket = $scope.feeGradeBuckets[index-1]
                return (gradeBucket.gradeFrom - prevBucket.gradeTo === 1)
            }else{
                return (gradeBucket.gradeFrom === $scope.grades[0].id)
            }
        }

        $scope.isValidToOption = function(index){
            var gradeBucket = $scope.feeGradeBuckets[index]
            return (gradeBucket.gradeTo > gradeBucket.gradeFrom)
        }


        var raiseErrorMessage = function(gradeBucket){
            alert(this)
        };
        
        var getOptions = function(lowerLimit, grades){
            var options = []
            angular.forEach(grades, function(grade){
                if(grade.id > lowerLimit){
                    options.push(grade)
                }
            });
            return options;
        };

        var isFormValid = function(feeGradeBuckets){
            for(var i = $scope.feeGradeBuckets.length-1; i >= 0; i--){
                var gradeBucket = $scope.feeGradeBuckets[i]
                if(gradeBucket.gradeTo != null){
                    return gradeBucket.gradeTo === $scope.grades[$scope.grades.length-1].id
                }else{
                    if(gradeBucket.gradeTo != null){
                    }
                }
            }
        }

        $scope.submitGradeBuckets = function(){
            $("#gradeBucketsForm").serialize()
            alert(isFormValid($scope.feeGradeBuckets))
        }
        
    }]);
	
})(angular, myApp);
