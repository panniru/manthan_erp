(function(angular, app) {
    "use strict";
    app.controller('InventoriesController',["$scope","resourceService","canteenManagementService", function($scope, resourceService,canteenManagementService) {
	//$scope.inventories = resourceService.Inventory.query();    
        
	$scope.request_status = [];

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
                    window.location.reload();
		})
        }
	
	$scope.addMoreinventories = function(){
            var lnt = parseInt($scope.newInventories.length)
            for(var i=lnt; i< lnt+1; i++){
                $scope.newInventories.push({"name":"", "quantity" :"", "inventory_type": "", "status": ""});
            };
        }
        
	 $scope.sendForApproval = function(status,inventory){
	     if(status){               
                 $scope.request_status.push({
                     id: inventory.id,
                     status: ""                    
                 });
             }
             else
             {
                 for (var i=0; i<$scope.request_status.length; i++){ 
                     if (inventory.id == $scope.request_status[i]['id']){                       
                         $scope.request_status.splice(i, 1);
                         break;
                     }
                 }
             }           
         };
	
	
	canteenManagementService.getinventoryView()
	    .then(function(response){
		$scope.inventories = response.data
	    });
	
	$scope.updateStatus = function(status){
	    for (var i=0; i<$scope.request_status.length; i++){ 
                $scope.request_status[i]['status'] = status;
	    }
	    canteenManagementService.updateStatus($scope.request_status)      
                .then(function(result) {
		    window.location.reload();
                });           
	};
	
	$scope.initiateMail = function(){
	    alert(term_name)
            $scope.myRequestBooks = [];
            $scope.myMailSubject = "Regarding Inventory Order";            
            alert($scope.newInventories.length)
            for(var i=0; i<$scope.request_status.length; i++){
		for(var j=0; j<$scope.newInventories.length; j++){
                    if($scope.request_status[i]['id'] == $scope.newInventories[j]['id']){                        
                        $scope.myRequestBooks.push({
                            id: $scope.newInventories[j]['id'],
                            inventory_type: $scope.newInventories[j]['inventory_type'],
                            name: $scope.newInventories[j]['name'],
			    quantity: $scope.newInventories[j]['quantity'],
                        });
                    }
                }
            }            
            $scope.updateStatus('Ordered');
        };
        
    }]);
})(angular, myApp);

