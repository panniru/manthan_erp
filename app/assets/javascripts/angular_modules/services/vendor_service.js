(function(angular, app) {
    "use strict";
    app.service("vendorService",["$http", function($http) {
        var getVendorServiceView = function(){
            var url = "/vendor_managements/get_vendor_view.json"
            return $http.get(url);
        };
        return {
            getVendorServiceView : getVendorServiceView,
            
        };
    }]);
})(angular, myApp);
