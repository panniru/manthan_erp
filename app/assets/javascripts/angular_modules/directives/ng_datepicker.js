(function(angular, app) {
    "use strict";
    app.directive('ngDatepicker', function() {
        return {
            require: 'ngModel',
            link: function(scope, el, attr, ngModel) {
                alert(attr.id)
                $(el).datepicker({
                    onSelect: function(dateText) {
                        scope.$apply(function() {
                            ngModel.$setViewValue(dateText);
                        });
                    }
                });
            }
        };
    });
})(angular, myApp);
