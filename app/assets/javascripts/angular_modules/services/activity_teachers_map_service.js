(function(angular, app) {
    "use strict";
    app.service("activityTeachersMapService",["$http", function($http) {
        
        var checkActivityTeachersMapping = function(myActivity){          
            var url = "/activity_teachers_mappings/check_activity_teachers_mapping.json"             
            return $http.get(url,{params:{myActivity: myActivity}});  
        }; 
        
        var saveMappings = function(mappings){
            var url = "/activity_teachers_mappings/savemappings.json"
            return $http.post(url, {mappings: mappings});            
        };
        
        var getMappings = function(myActivity){
            var url = "/activity_teachers_mappings/getmappings.json"
            return $http.get(url, {params:{my_Activity: myActivity}}); 
        }; 
        
        var deleteMapping = function(delete_mapping_id){
            var url = "/activity_teachers_mappings/deletemapping.json"
            return $http.post(url, {delete_mapping_id: delete_mapping_id}); 
        };
        
        return {
            checkActivityTeachersMapping : checkActivityTeachersMapping,
            saveMappings : saveMappings,
            getMappings : getMappings,
            deleteMapping : deleteMapping
        };        
    }]);   
    
})(angular, myApp);
