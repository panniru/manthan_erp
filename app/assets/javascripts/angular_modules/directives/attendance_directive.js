(function(angular, app) { 
    app.directive('blur', function () {
        return function (scope, element, attrs) {
            scope.$watch(attrs.blur, function () {
                element[0].blur();
            });
        };
    });
})(angular, myApp);
