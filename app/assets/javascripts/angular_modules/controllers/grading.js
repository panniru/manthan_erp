(function(angular, app) {
    "use strict";
    app.controller('GradingController',["$scope", "gradingService", function($scope, gradingService) {   

        $scope.initialize = function(){
            $scope.myShowFormValue  = true;
            $scope.myEditFormValue  = false;
            $scope.show_gradings = [];
            for (var i=0; i < $scope.gradings.length; i++){
                $scope.show_gradings.push({
                    id: $scope.gradings[i]['id'],
                    grading_name: $scope.gradings[i]['grading_name'],
                    grading_desc: $scope.gradings[i]['grading_desc'],
                    grading_show_value : true,
                    grading_edit_value : false,
                });                
            }            
        };

        gradingService.getGradingServiceView()
            .then(function(result) {                
                $scope.gradings = result.data;               
                $scope.initialize();
            });

        $scope.editGradingMappings = function($index){          
            $scope.myShowFormValue  = false;
            $scope.myEditFormValue  = true;

            for(var i =0; i<$scope.show_gradings.length; i++){
                $scope.show_gradings[i]['grading_show_value'] = true;
                $scope.show_gradings[i]['grading_edit_value'] = false;
            }

            $scope.show_gradings[$index]['grading_show_value'] = false;
            $scope.show_gradings[$index]['grading_edit_value'] = true;
        };        

        $scope.saveGradingMappings = function(grading){
            
            $scope.save_gradings = [];
            
            $scope.save_gradings.push({
                id: grading.id,
                grading_name: grading.grading_name,
                grading_desc: grading.grading_desc,
            });            
            
            gradingService.saveGradingMappings($scope.save_gradings)
                .then(function(result) {                    
                });

            $scope.showGradingMappings();           
        };

        $scope.showGradingMappings = function(){
            gradingService.getGradingServiceView()
                .then(function(result) {                     
                    $scope.gradings = result.data;                   
                    $scope.initialize();
                });
        };

        $scope.addGradingMappings = function(grading){
            
            $scope.myShowFormValue  = false;
            $scope.myEditFormValue  = true;

            $scope.show_gradings.push({
                id: "",
                grading_name: "",
                grading_desc: "",
                grading_show_value : false,
                grading_edit_value : true,
            });            
        };

        $scope.deleteGradingMappings = function(grading){           
            $scope.delete_mappping_id = grading.id;
           
            gradingService.deleteGradingMappings($scope.delete_mappping_id)
                    .then(function(result) {
                        
                    });             
            $scope.showGradingMappings();            
        };

    }]);    
})(angular, myApp);
