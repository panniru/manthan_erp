(function(angular, app) {
    "use strict";
    app.controller("RoleMenuMappingsController",["$scope", "$http", function($scope, $http) {
        $scope.isEdit = false;
        $scope.getRoles = function(){
            $http.get("/role_menu_mappings/roles.json")
                .then(function(responce){
                    $scope.roles = responce.data;
                });
        }

        $scope.list_mapping = function(){
            $http.get("/role_menu_mappings/list_mapping.json", {params: {role_id: $scope.role.id}})
                .then(function(responce){
                    $scope.menus = responce.data;
                    $scope.priority_count = [];
                    for(var i =1 ; i <= $scope.menus.length; i++){
                        $scope.priority_count.push(i);
                    }
                });
        }
        
        $scope.saveMapping = function(){
            $http.post("/role_menu_mappings/save_mapping.json", {mapping: $scope.menus, role_id: $scope.role.id}).
                success(function(data, status, headers, config) {
                    $scope.isEdit = false;
                }).
                error(function(data, status, headers, config) {
                    alert("error occured..!!")
                });
        }
        $scope.checkSubMenu = function(menu){
            angular.forEach(menu.sub_menus, function(subMenu){
                subMenu.is_assigned = menu.is_assigned
            });
        }
        
        
    }]);
})(angular, myApp);



