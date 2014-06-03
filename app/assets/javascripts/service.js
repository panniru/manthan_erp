angular.module('studentApp.services', []).
    factory('ergastAPIservice', function($http) {

        var ergastAPI = {};

        ergastAPI.getStudents = function() {
            return $http({
                method: 'JSONP', 
                url: 'http://ergast.com/api/f1/2013/driverStandings.json?callback=JSON_CALLBACK'
            });
        }

        return ergastAPI;
    });
