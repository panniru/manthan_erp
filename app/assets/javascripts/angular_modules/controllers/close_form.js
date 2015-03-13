(function(angular, app) {
    "use strict";
    app.controller('CloseController',["$scope","resourceService", function($scope, resourceService) {
        $scope.reasons = resourceService.Reason.query(); 
        
        $scope.newReasons = function(){ 
            

            $scope.newReasons = [];
       
            for(var i=0;i<$scope.newReasons.length; i++)
            {
                // $scope.newReasons.push({"reason": ""});
                $scope.statuses.push({"reason": ""});
            }
            $('#create').modal('show');
        };

        $scope.update = function(){
            $scope.reason.$update()
                .then(function(response){                  
                })
            $('#edit').modal('hide');
            $scope.reasons = resourceService.Reason.query()
            window.location.reload();
        };  

        // $scope.save = function(newReasons){
        
        //     for(var i=0;i< $scope.newReasons.length; i++){
        //         $scope.save_reasons[i]['reason'] = $scope.reasons[i]['reason'];
        //     };
        //     $('#create').modal('hide');
        //     $scope.reasons = resourceService.Reason.query()
         
        //     window.location.reload();
        // };
        
        $scope.save = function(){ 
            alert(' ')         
               $scope.reasons = resourceService.Reason.query()

            alert(JSON.stringify($scope.reasons))
                .$promise.then(function(response){
                    if(response[0] == "success"){
                        alert("Bulk Subjects Added Successfully");
                        $scope.reasons();
                        $('#myModal').modal('hide');
                        // $scope.showErrorMessage = false;
                    }
                    else
                    {
                        // $scope.showErrorMessage = true; 
                    }
                });

        };                                      

      
	
	$scope.editReasons = function(reason){
	    $scope.reason = reason
	    $('#edit').modal('show');
		
	}
	
	$scope.destroy = function(reason){
            window.location.reload();
            reason.$delete()
            	.then(function(response){
                    
                    $scope.reasons.splice(reason, 1)
                    
         
		});
	};
    }]);
})(angular, myApp);
