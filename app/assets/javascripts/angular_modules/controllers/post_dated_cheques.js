(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope","resourceService", "monthlyPdcService", function($scope, resourceService, monthlyPdcService) {
        
        $scope.postDatedCheques = resourceService.PostDatedCheque.query();
        
        $scope.newPostDatedCheques = function(){
            $scope.reset();
            $('#createModal').modal('show')
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

        $scope.fillFor100 = function(){
            var first_value = $scope.newPostDatedCheques[0];
            var amount_per = parseFloat(first_value.amount_per);
            var date; 
            var dateStr = $("#date-0").val()
            if(typeof dateStr != 'undefined'){
                var dateSplit = dateStr.split('/')
                date = new Date(dateSplit[2], dateSplit[1]-1, dateSplit[0]);
            }
            var count = parseInt(100/parseFloat(first_value.amount_per));
            var left_per = (100%parseFloat(first_value.amount_per));
            for(var i = 0; i < count; i++){
                var new_date = monthlyPdcService.next_month_date(date, i);
                $scope.newPostDatedCheques[i].date = (new_date.getDate()+'/'+(new_date.getMonth()+1)+'/'+new_date.getFullYear()) ;
                $scope.newPostDatedCheques[i].amount_per =  amount_per ;
            }
            if(left_per != 0.0){
                var new_date = monthlyPdcService.next_month_date(date, count);
                $scope.newPostDatedCheques[count].date = (new_date.getDate()+'/'+(new_date.getMonth()+1)+'/'+new_date.getFullYear());
                $scope.newPostDatedCheques[count].amount_per =  left_per;
            }

        };

        $scope.reset = function(){
            $scope.newPostDatedCheques = []
            for(var i=0; i<12; i++){
                $scope.newPostDatedCheques.push({"date":"", "amount_per":""});
            }
        }
        
        $scope.isEligleToShow = function(){
            var first_value = $scope.newPostDatedCheques[0]
            var dateStr = $("#date-0").val()
            if (typeof first_value != 'undefined'){
                return ( dateStr != "" && first_value.amount_per != "") 

            }else{
                return false
            }
        };

        
    }]);
})(angular, myApp);

