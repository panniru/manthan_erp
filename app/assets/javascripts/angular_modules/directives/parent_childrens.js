(function(angular, app) {
    "use strict";
    app.directive('parentChildrens', function(){
        return{
            restrict: 'E',
            templateUrl: 'parent_childrens.html'
        };
    });
})(angular, myApp);
