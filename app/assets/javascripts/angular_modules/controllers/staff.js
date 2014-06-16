(function(angular, app) {
    "use strict";
    app.controller('StaffCtrl', ['$scope','getStaff','$http',function($scope,getStaff) {
        getStaff.getStaffView()
        .then(function(response) { 
            $scope.staffs = response.data
            });
    }]);
})(angular, myApp);
 
