'use strict';
(function(angular, app) {
app.controller('FormCtrl',['$scope', function ($scope) {
    $scope.selectedStatus = [];
    $scope.statusList = [{
        id: 1,
        status: 'Apple'
    }, {
        id: 2,
        status: 'Facebook'
    }, {
        id: 3,
        status: 'Google'
    }];

   
    $scope.setSelectedForm = function () {
        var id = this.status.id;
        if (_.contains($scope.selectedStatus, id)) {
            $scope.selectedStatus = _.without($scope.selectedStatus, id);
        } else {
            $scope.selectedStatus.push(id);
        }
        return false;
    };

    $scope.isChecked = function (id) {
        if (_.contains($scope.selectedStatus, id)) {
            return 'icon-ok pull-right';
        }
        return false;
    };

    $scope.checkAll = function () {
        $scope.selectedStatus = _.pluck($scope.statusList, 'id');
    };
}]);

angular.module('app.filters', []).filter('statusFilter', [function () {
    return function (forms, selectedStatus) {
        if (!angular.isUndefined(forms) && !angular.isUndefined(selectedStatus) && selectedStatus.length > 0) {
            var tempForms = [];
            angular.forEach(selectedStatus, function (id) {
                angular.forEach(forms, function (form) {
                    if (angular.equals(form.status.id, id)) {
                        tempForms.push(form);
                    }
                });
            });
            return tempForms;
        } else {
            return forms;
        }
    };
}]);
}(angular, myApp));
