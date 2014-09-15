(function(angular, app) {
    "use strict";
    app.controller('InventoriesController',["$scope","resourceService","canteenManagementService", function($scope, resourceService,canteenManagementService) {
       // $scope.inventories = resourceService.Inventory.query();    
        $scope.newInventory = function(){
            $scope.newInventories = []
            for(var i=0; i<1; i++){
                $scope.newInventories.push({"name":"", "quantity":"","inventory_type":"", "status":"" });
            };
            $('#createModal').modal('show')     
        };
        $scope.submitInventories = function(){                       
            resourceService.Inventory.bulk({bulk_inventory: $scope.newInventories})          
                .$promise.then(function(responce){                                
                    $('#createModal').modal('hide')
                })
        }
	
	$scope.addMoreinventories = function(){
            var lnt = parseInt($scope.newInventories.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newInventories.push({"name":"", "quantity" :"", "inventory_type": "", "status": ""});
            };
        }
        

        
    }]);
})(angular, myApp);

