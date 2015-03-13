(function(angular, app) {
    "use strict";
    app.controller("SalaryBreakUpsController",["$scope", "$http", function($scope, $http) {
        
	$scope.months = [{name: "January", value: 1 }, {name:"February",value: 2 } , {name: "March", value: 3}, {name: "April", value: 4}, {name: "May", value: 5}, {name: "June", value: 6} , {name: "July", value: 7} , {name: "August", value: 8}, {name: "September", value: 9}, {name: "November", value: 11} , {name: "December", value: 12}, {name: "October", value: 10}];
	
	$scope.initialize = function(type){
            $scope.editable = false;
	    $scope.type = type;
            $http.get("/salary_break_ups.json?type="+type)
                .then(function(response){
                    $scope.salary_break_ups = response.data
                })
        }
	$scope.myMatch = function(componentCode){
	    return componentCode.indexOf('month') != '-1'
	}
	
        $scope.update = function(){
	    $http.put("/salary_break_ups/update_all.json", {salary_break_ups: $scope.salary_break_ups})
                .then(function(response){
                    if(response.status){
                        $scope.editable = false
			$scope.initialize($scope.type);
                    }
                })
        };
        
        
    }]);

    app.controller("SalaryBreakUpInitializeController",["$scope", "$compile", "$element", function($scope, $compile, $element) {
        $scope.isClicked = false
        $scope.generate_salary_break_up = function(ctc, basic, probation_date, designation){
            $scope.isClicked = true
            
	    if(typeof designation == 'undefined'){
               
		designation = "\""+$("#designation_name").val()+"\""
            }
	    var directive_to_add = $compile("<salary-break-up ctc='"+ctc+"', basic='"+basic+"', probation_date= '\""+probation_date+"\"', designation= '"+designation+"'></salary-break-up>")($scope);
	    
            angular.element(document.getElementById('salaryBreakUpShowDiv')).html(directive_to_add);
        }

    }]);
})(angular,  myApp);
