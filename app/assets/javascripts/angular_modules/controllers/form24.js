(function(angular, app) {
    "use strict";
    app.controller("FormTaxController",["$scope", "formService" , '$window'  , function($scope,formService ,$window) {
	
	$scope.get_tds = function(){
	    formService.getFormServiceView()
		.then(function(result) {
		    $scope.forms = result.data;
		    $scope.form_details = [];
		    for(var i=0; i<result.data.length; i++){
			$scope.form_details.push({
			    id: null,
			    payment_type: null,
			    challan_serial_no: null,
			    deposited_date: null,
			    status: null,
			    month: null,
			    year: null,
			    bsr_code: null,
			    cheque_no: null,
			    total_tax_deposited: null,
			    
			});
		    }
		    
		});
	}

	$scope.saveForm = function(){
	    formService.saveForm($scope.forms)
		.then(function(result) {
		    $window.location.href = '/form24';
		});
	}
	
 
    }]);
})(angular,  myApp);
