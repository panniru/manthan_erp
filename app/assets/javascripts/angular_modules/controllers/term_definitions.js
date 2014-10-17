(function(angular, app) {
    "use strict";
    app.controller('TermDefinitionsController',["$scope","resourceService", function($scope, resourceService) {
        $scope.termDefinitions = resourceService.TermDefinition.query();
        $scope.newTermDefinition = function(){
            $scope.newTermDefinitions = []
            $scope.newTermDefinitionErrors = []
            $scope.invalidTotal = false
            for(var i=0; i<3; i++){
                $scope.newTermDefinitions.push({"term_definition":null, "amount_per" :null, "termdate": null });

            };
            $('#createModal').modal({backdrop: 'static'})
        }

        var initializeErrorObj = function(count){
            $scope.newTermDefinitionErrors = []
            for(var i=0; i< count; i++){
                $scope.newTermDefinitionErrors.push({"term_definition":[], "amount_per" :[], "termdate": [] });
            }
        }
        
        $scope.editTermDefinitions = function(){
            $scope.newTermDefinitions = $scope.termDefinitions
            $('#createModal').modal({backdrop: 'static'})
        }

        $scope.submitTermDefinitions = function(){
            setUpDates();
            if(valid()){
                resourceService.TermDefinition.bulk({bulk_term: $scope.newTermDefinitions})
                    .$promise.then(function(responce){
                        $scope.termDefinitions = resourceService.TermDefinition.query()
                        $('#createModal').modal('hide')
                    })
            }else{
                return false;
            }
        }

        var errorPopover = function(id, data){
            $("#"+id).popover({
                html: true,
                content: data, 
                placement: "right",
            })
            $("#"+id).popover('show')
        }
        
        $scope.destroy = function(termDefinition){
            termDefinition.$delete()
                .then(function(responce){
                    $scope.termDefinitions.splice($scope.termDefinitions.indexOf(termDefinition), 1)
                })
        };
        
        
	$scope.addMoreterms = function(){
            var lnt = parseInt($scope.newTermDefinitions.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newTermDefinitions.push({"term_definition": null , "amount_per" : null, "termdate": null });
            };
            initializeErrorObj($scope.newTermDefinitions.length)
        }

        
        var setUpDates = function(){
            angular.forEach($scope.newTermDefinitions, function(term, index){
                var val = $("#date-"+index).val()
                if(typeof val != 'undefined' || val.length > 1){
                    term.termdate = $("#date-"+index).val()
                }
            });
        }

        var valid = function(){
            initializeErrorObj($scope.newTermDefinitions.length)
            $scope.invalidTotal = false;
            remove_empty_rows()
            validate_dates()
            valid_row()
            if(validate_amounts() != 100.00){
                $scope.invalidTotal = true;
                return false;
            }
            angular.forEach($scope.newTermDefinitionErrors, function(term){
                if(term.term_definition.length > 0 ||
                   term.termdate.length > 0 ||
                   term.amount_per.length > 0
                   ){
                    return false;
                }
            });
            return false;
        }
       
        var validate_dates = function(){
            var prevDate = null
            for(var index=0; index < $scope.newTermDefinitions.length; index++ ){
                console.log($scope.newTermDefinitions[index].termdate)
                if(typeof $scope.newTermDefinitions[index].termdate != 'undefined'){
                    var dateParts = $scope.newTermDefinitions[index].termdate.split("/")
                    var currentDate = new Date(parseInt(dateParts[2]), parseInt(dateParts[1])-1, parseInt(dateParts[0]))
                    if(prevDate !=  null && prevDate > currentDate){
                        $scope.newTermDefinitionErrors[index].termdate.push("Invalide Term Date");
                        return false;
                    }
                    prevDate = currentDate;
                }
            }
            return true;
        }

        var valid_row = function(){
            angular.forEach($scope.newTermDefinitions, function(term, index){
                if(term.term_definition != null || term.termdate != null ||  term.amount_per != null){
                    if(term.term_definition == null || !term.term_definition.length > 0){
                        $scope.newTermDefinitionErrors[index].term_definition.push("Empty Term Defination");
                    }
                    if(term.termdate == null || !term.termdate.length > 0){
                        $scope.newTermDefinitionErrors[index].termdate.push("Empty Term Date Not Allowed");
                    }
                    if(term.amount_per == null || !term.amount_per.length > 0){
                        $scope.newTermDefinitionErrors[index].amount_per.push("Empty Amount Percent");
                    }
                }
            });
            return true;
        }

        var validate_amounts = function(){
            var total_percentage = 0.0
            angular.forEach($scope.newTermDefinitions, function(term, index){
                term.termdate = $("#date-"+index).val()
                if(!isNaN(term.amount_per) && term.amount_per != ''){
                    total_percentage += parseFloat(term.amount_per)
                }
            });
            return total_percentage
        }

        var remove_empty_rows = function(){
            var invalidIndeces = []
            for(var i= 0; i <  $scope.newTermDefinitions.length ; i++){
                if($scope.newTermDefinitions[i].term_definition == null &&
                   ($scope.newTermDefinitions[i].termdate == null || 
                    typeof $scope.newTermDefinitions[i].termdate === 'undefined' || 
                    $scope.newTermDefinitions[i].termdate === "")&&
                   $scope.newTermDefinitions[i].amount_per == null
                  ){
                    invalidIndeces.push($scope.newTermDefinitions[i])
                };
            }
            angular.forEach(invalidIndeces, function(term){
                $scope.newTermDefinitions.splice($scope.newTermDefinitions.indexOf(term), 1)
            });
        }
        
    }]);  
    
})(angular, myApp);


