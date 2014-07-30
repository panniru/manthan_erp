(function(angular, app) {
    "use strict";
    app.service("gradingService",["$http", function($http) {
        var getGradingServiceView = function(){
            var url = "/gradings/get_grading_service_view.json"
            return $http.get(url);
        };         
       
        var saveGradingMappings = function(save_gradings){            
            var url = "/gradings/save_gradings_mappings.json"
            return $http.post(url, {mappings: save_gradings});    
        }; 

        var deleteGradingMappings = function(delete_mapping_id){
            var url = "/gradings/delete_grading_mappings.json"
            return $http.post(url, {_delete_mapping_id: delete_mapping_id}); 
        };

        return {
            getGradingServiceView : getGradingServiceView,
            saveGradingMappings :  saveGradingMappings,
            deleteGradingMappings : deleteGradingMappings
        } 
 
    }]);    
})(angular, myApp);

        
