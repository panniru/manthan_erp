(function(angular, app) {
    "use strict";
    app.controller('InventoriesController',["$scope","resourceService","canteenManagementService", function($scope, resourceService,canteenManagementService) {
	//$scope.inventories = resourceService.Inventory.query();    
        $scope.request_status = [];
	

	$scope.newInventory = function(){
	    $scope.newInventories = []
            $scope.newInventories.push({"name":"", "quantity":"","inventory_type":"", "status":"" });
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
	    $scope.isMailActionFired = true            
	    $scope.myStatus = [];
            for(var i=0; i<$scope.request_status.length; i++){
		for(var j=0; j<$scope.inventories.length; j++){
                    if($scope.request_status[i]['id'] == $scope.inventories[j]['id']){                        
                        $scope.myStatus.push({
                            id: $scope.inventories[j]['id'],
                            inventory_type: $scope.inventories[j]['inventory_type'],
                            name: $scope.inventories[j]['name'],
			    quantity: $scope.inventories[j]['quantity'],
                        });
		    }
                }
            }
	   
	    canteenManagementService.requestInventoryMail($scope.myStatus)
	    	.then(function(responce){
                    var alert_msg = '<div class="alert alert-success alert-dismissable">'+
			'<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
			responce.data+'</div>'
                    $("#appAlert").html(alert_msg)
		});  
            $scope.updateStatus('Ordered');
        };
	
	
        
    }]);
})(angular, myApp);

