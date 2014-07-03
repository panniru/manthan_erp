(function(angular, app) {
    "use strict";
    app.controller("approvalsController",["$scope", "resourceService", function($scope, resourceService) {
        $scope.isMailActionFired = false
        $scope.approvals = []
        
        $scope.index = function(){
            $scope.approvals = resourceService.ApprovalItem.query()
        }
        
        $scope.fee_structure_item = function(){
            $scope.approval_item = resourceService.ApprovalItem.fee_structure_approval_item()
        } 
        
        $scope.approve = function(approval_item){
            approval_item.$approve()
                .then(function(responce){
                    approval_item = responce.data
                })
        }
        
        $scope.reject = function(approval_item){
            approval_item.$reject()
                .then(function(responce){
                    approval_item = responce.data
                })
        }

        $scope.create = function(){
            $scope.approval_item.status = "pending"
            $scope.approval_item.$save()
        }
        
        $scope.feeStructureMail = function(){
            $scope.isMailActionFired = true
            mailService.feeStructureMail()
            .then(function(responce){
                var alert_msg = '<div class="alert alert-success alert-dismissable">'+
                    '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
                    responce.data+'</div>'
                $("#appAlert").html(alert_msg)
            });
            
        };
        
    }]);
    
})(angular, myApp);


