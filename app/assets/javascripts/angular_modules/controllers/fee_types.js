(function(angular, app) {
    "use strict";
    app.controller("FeeTypesController",["$scope", "feeTypeService", function($scope,feeTypeService) {

        $scope.newFeeTypes = function(){
            $scope.new_fee_types = []
            for(var i=0; i<5; i++){
                $scope.new_fee_types.push({"fee_type":""});
            };
            $('#createModal').modal('show')
        };
        
        $scope.index = function(){
            feeTypeService.index()
                .then(function(responce){
                    $scope.fee_types = responce.data
                });
        }
        

        $scope.addMorefeeTypes = function(){
            var lnt = parseInt($scope.fee_types.length)
            for(var i=lnt; i< lnt+5; i++){
                $scope.new_fee_types.push({"fee_type":""});
            };
        }
        
        $scope.create = function(){
            feeTypeService.createBulkFeeTypes($scope.new_fee_types)
                .then(function(responce){
                    angular.forEach(responce.data, function(value) {
                        this.push(value);
                    }, $scope.fee_types);
                    $('#createModal').modal('hide')
                });
        }

        $scope.edit = function(fee_type){
            $scope.fee_type = angular.copy(fee_type)
            $("#editModal").modal("show")
        }
        

        $scope.update = function(fee_type){
            $scope.error = null
            if(typeof fee_type.fee_type != 'undefined' && fee_type.fee_type.length > 0){
                feeTypeService.updateFeetype(fee_type)
                    .then(function(responce){
                        $scope.index();
                        $('#editModal').modal('hide')
                    });
            }else{
                $scope.error = "Fee Type Cant be blank"
            }

        };

        $scope.destroy = function(fee_type){
            if(confirm("Are You Sure..??")){
                feeTypeService.destroy(fee_type)
                    .then(function(responce){
                        $scope.fee_types.splice($scope.fee_types.indexOf(fee_type), 1)
                    });
            }
        };
    }]);
    
})(angular, myApp);


