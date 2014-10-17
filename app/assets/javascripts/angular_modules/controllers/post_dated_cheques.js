(function(angular, app) {
    "use strict";
    app.controller("PostDatedChequesController",["$scope","resourceService", "monthlyPdcService", function($scope, resourceService, monthlyPdcService) {
        
        $scope.postDatedCheques = resourceService.PostDatedCheque.query();
        $scope.invalidTotal = false;
        $scope.newPostDatedChequeErrors = [];
        $scope.newPostDatedCheques = []

        $scope.newPostDatedCheque = function(){
            $scope.reset();
            $('#createModal').modal({backdrop: 'static'})
        }

        $scope.editPostDatedCheques = function(){
            $scope.newPostDatedCheques = $scope.postDatedCheques;
            $('#createModal').modal({backdrop: 'static'})
        }

        
        
        $scope.submitPostDatedCheques = function(){
            setUpDates();
            if(valid()){
                resourceService.PostDatedCheque.bulk({bulk_post_dated_cheques: $scope.newPostDatedCheques})
                    .$promise.then(function(responce){
                        $scope.postDatedCheques = resourceService.PostDatedCheque.query()
                        $('#createModal').modal('hide')
                    })
            }else{
                return false;
            }
        }

        var valid = function(){
            remove_empty_rows();
            initializeErrorObj($scope.newPostDatedCheques.length)
            $scope.invalidTotal = false;
            valid_row();
            validate_dates();
            if(validate_amounts() != 100.00){
                $scope.invalidTotal = true;
                return false;
            }
            angular.forEach($scope.newPostDatedChequeErrors, function(pdc){
                if(pdc.date.length > 0 ||
                   pdc.amount_per.length > 0
                   ){
                    return false;
                }
            });
            return true;
        }
        
        var setUpDates = function(){
            angular.forEach($scope.newPostDatedCheques, function(cheque, index){
                var val = $("#date-"+index).val()
                if(typeof val != 'undefined' || val.length > 1){
                    cheque.date = val;
                }
            });
        }

        var validate_amounts = function(){
            var total_percentage = 0.0;
            angular.forEach($scope.newPostDatedCheques, function(cheque, index){
                if(!isNaN(cheque.amount_per) && cheque.amount_per != ''){
                    total_percentage += parseFloat(cheque.amount_per)
                }
            });
            return total_percentage;
        }

        var valid_row = function(){
            angular.forEach($scope.newPostDatedCheques, function(pdc, index){
                if(pdc.date != null ||  pdc.amount_per != null){
                    console.log(pdc.date)
                    if(pdc.date == null || !pdc.date.length > 0){
                        $scope.newPostDatedChequeErrors[index].date.push("Empty Date");
                    }
                    if(pdc.amount_per == null || !pdc.amount_per > 0){
                        $scope.newPostDatedChequeErrors[index].amount_per.push("Empty Amount Per");
                    }
                }
            });
            return true;
        }

        var validate_dates = function(){
            var prevDate = null
            for(var index=0; index < $scope.newPostDatedCheques.length; index++ ){
                console.log($scope.newPostDatedCheques[index].date)
                if(typeof $scope.newPostDatedCheques[index].date != 'undefined'){
                    var dateParts = $scope.newPostDatedCheques[index].date.split("/")
                    var currentDate = new Date(parseInt(dateParts[2]), parseInt(dateParts[1])-1, parseInt(dateParts[0]))
                    if(prevDate !=  null && prevDate > currentDate){
                        $scope.newPostDatedChequeErrors[index].date.push("Invalide Date");
                        return false;
                    }
                    prevDate = currentDate;
                }
            }
            return true;
        }



        
        var initializeErrorObj = function(count){
            $scope.newPostDatedChequeErrors = []
            for(var i=0; i< count; i++){
                $scope.newPostDatedChequeErrors.push({"date":[], "amount_per": []});
            }
        }

        var remove_empty_rows = function(){
            var invalidIndeces = []
            for(var i= 0; i <  $scope.newPostDatedCheques.length ; i++){
                if(($scope.newPostDatedCheques[i].date == null || !$scope.newPostDatedCheques[i].date.trim().length > 0) &&
                   $scope.newPostDatedCheques[i].amount_per == null
                  ){
                    invalidIndeces.push($scope.newPostDatedCheques[i])
                };
            }
            angular.forEach(invalidIndeces, function(pdc){
                $scope.newPostDatedCheques.splice($scope.newPostDatedCheques.indexOf(pdc), 1)
            });
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
                if(new_date.getFullYear() > parseInt(gon.academicYearTo)){
                    alert("Checque Dates are crosing this academic year..!!")
                    $scope.reset();
                    return false;
                }
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
                $scope.newPostDatedCheques.push({"date":null, "amount_per":null});
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

