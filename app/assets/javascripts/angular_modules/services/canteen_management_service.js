(function(angular, app) {
    "use strict";    
    app.service("canteenManagementService",["$http",function($http) {

        var getMealtypeIdService = function(){
            var url = "/mealnames/getmealtypeidservice.json"
            return $http.get(url);
        };
       // var Mealname = $resource('/mealnames/:id.json', {id: '@id'}, //
    //                             {
      //                               "bulk": { url: "/mealnames/create_bulk", method:'POST'},
        //                             "update": { method: "PUT"}
          //                       }
            //                    );
        

	return {
            getMealtypeIdService: getMealtypeIdService
          //  Mealname:  Mealname
        };
        
    }]); 
})(angular, myApp);
