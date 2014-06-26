(function(angular, app) {
    "use strict";
    app.controller('DefaultMastersController',["$scope","resourceService", function($scope, resourceService) {
        $scope.defaultMasters = resourceService.DefaultMaster.query();
        
        $scope.newDefaultMaster = function(){
            $scope.isNew = true;
            $scope.defaultMaster = new resourceService.DefaultMaster({default_name: "", default_value: "", default_desc: ""});
            $('#createModal').modal('show')
        }

        $scope.submitForm = function(){
            $scope.defaultMaster.$save()
                .then(function(responce){
                    $scope.defaultMasters = resourceService.DefaultMaster.query();
                    $('#createModal').modal('hide')
                })
        };

        $scope.update = function(){
            $scope.isNew = false;
            $scope.defaultMaster.$update()
                .then(function(responce){
                    $scope.defaultMasters = resourceService.DefaultMaster.query();
                    $('#createModal').modal('hide')
                })
        };
        
        $scope.edit = function(defaultMaster){
            $scope.defaultMaster = defaultMaster
            $('#createModal').modal('show')
        };
        

        $scope.destroy = function(defaultMaster){
            defaultMaster.$delete()
                .then(function(responce){
                    $scope.defaultMasters.splice($scope.defaultMasters.indexOf(defaultMaster), 1)
                })
        };
        
        
	$scope.addMoreterms = function(){
            var lnt = parseInt($scope.newDefaultMasters.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newDefaultMasters.push({"term_definition":"", "amount_per" :"", "termdate": "" });
            };
        }
        
    }]);  
    
})(angular, myApp);


