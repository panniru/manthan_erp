(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope","resourceService", "monthlyPdcService", function($scope, resourceService, monthlyPdcService) {
        
        $scope.postDatedCheques = resourceService.PostDatedCheque.query();
        
        $scope.newPostDatedCheques = function(){
            $scope.reset();
            $('#createModal').modal('show');
        }

        $scope.editPostDatedCheques = function(){
            $scope.newPostDatedCheques = $scope.postDatedCheques;
            $('#createModal').modal('show')
        }

        
        
        $scope.submitPostDatedCheques = function(){
            angular.forEach($scope.newPostDatedCheques, function(cheque, index){
                cheque.date = $("#date-"+index).val()
            });
            resourceService.PostDatedCheque.bulk({bulk_post_dated_cheques: $scope.newPostDatedCheques})
                .$promise.then(function(responce){
                    $scope.postDatedCheques = resourceService.PostDatedCheque.query()
                    $('#createModal').modal('hide')
                })
        }

        $scope.destroy = function(postDatedCheque){
            postDatedCheque.$delete()
                .then(function(responce){
                    $scope.postDatedCheques.splice($scope.postDatedCheques.indexOf(postDatedCheque), 1)
                })
        };
    }]);
})(angular, myApp);

