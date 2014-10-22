(function(angular, app) {
    "use strict";
    app.controller('DefaultMastersController',["$scope","resourceService", function($scope, resourceService) {
        $scope.defaultMasters = resourceService.DefaultMaster.query();
        
        $scope.newDefaultMaster = function(){
            $scope.isNew = true;
            $scope.defaultMaster = new resourceService.DefaultMaster({default_name: "", default_value: "", default_desc: ""});
            $('#createModal').modal('show')
        }

        $scope.submitForm = function(){
            if(validate($scope.defaultMaster)){
                $scope.defaultMaster.$save()
                    .then(function(responce){
                        $scope.defaultMasters = resourceService.DefaultMaster.query();
                        $('#createModal').modal('hide')
                    })
            }
        };

        $scope.update = function(){
            $scope.isNew = false;
            if(validate($scope.defaultMaster)){
                $scope.defaultMaster.$update()
                    .then(function(responce){
                        $scope.defaultMasters = resourceService.DefaultMaster.query();
                        $('#createModal').modal('hide')
                    })
            }
        };

        var validate = function(dafaultMaster){
            if(dafaultMaster.default_name === 'discount' && dafaultMaster.default_value > 100){
                $scope.defaultValueError = "Invalid Default Value"
                return false;
            }
            return true;
        }
        
        $scope.edit = function(defaultMaster){
            $scope.defaultValueError = null
            $scope.defaultMaster = angular.copy(defaultMaster)
            $('#createModal').modal('show')
        };
        

        $scope.destroy = function(defaultMaster){
            defaultMaster.$delete()
                .then(function(responce){
                    $scope.defaultMasters.splice($scope.defaultMasters.indexOf(defaultMaster), 1)
                })
        };
        
        
	$scope.addMoreterms = function(){
            var lnt = parseInt($scope.newDefaultMasters.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newDefaultMasters.push({"term_definition":"", "amount_per" :"", "termdate": "" });
            };
        }
        
    }]);  
    
})(angular, myApp);


