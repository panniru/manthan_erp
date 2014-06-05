(function(angular, app) {
    "use strict";
    app.controller("StudentSearchController", ["$scope", function($scope) {
        $scope.grade = ""
        $scope.grades = [
            {grade: "PP1", id: 1},
            {grade: "PP2", id: 2},
            {grade: "Grade-3", id: 3},
            {grade: "Grade-4", id: 4},
            {grade: "Grade-5", id: 5},
            {grade: "Grade-6", id: 6},
            {grade: "Grade-7", id: 7},
            {grade: "Grade-8", id: 8},
            {grade: "Grade-9", id: 9},
            {grade: "Grade-10", id: 10}
        ];
        $scope.section = ""
        $scope.sections = [
            {section: "A", id: 1},
            {section: "B", id: 2},
            {section: "C", id: 3},
            {section: "D", id: 4},
            {section: "E", id: 5}
        ];
    }]);
})(angular, myApp);


