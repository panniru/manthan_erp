(function(angular, app) {
    "use strict";
    app.controller('HomeController',["$scope","$http", "$rootScope", function($scope, $http, $rootScope) {
        $scope.userUnReadMails = function(){
            $http.get("/communication_mails/unread.json")
                .then(function(response){
                    $scope.unreadMails = response.data.unread_mail_count
                })
        };
        
        $rootScope.$on('fireUserUnreadMails', function(event, data){
            $scope.userUnReadMails();
        });
    }]);
})(angular, myApp);
