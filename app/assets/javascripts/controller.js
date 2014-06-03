angular.module('studentApp.controllers', []).
    controller('studentsController', function($scope, ergastAPIservice) {
        $scope.nameFilter = null;
        $scope.studentsList = [];

        ergastAPIservice.getStudents().success(function (response) {
            //Dig into the responde to get the relevant data
            $scope.studentsList = response.MRData.StudentsTable.StudentsLists[0].StudentStandings;
        });
    });
