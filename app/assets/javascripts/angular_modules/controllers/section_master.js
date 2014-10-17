(function(angular, app) {
    "use strict";
    app.controller("SectionMasterController",["$scope","resourceService", "sectionMasterService", function($scope, resourceService, subjectMasterService) {      
        $scope.sections = resourceService.SectionMaster.query();  
        $scope.section_masters = [];

        $scope.showSections = function(){
            $scope.sections = resourceService.SectionMaster.query();  
            $scope.section_masters = [];            
        };

        $scope.addSection = function(){
            $scope.section_masters.push({
                section_name: ""
            });
        };

        $scope.addMoreSections = function(){
            for(var i=0; i<3; i++){
                $scope.addSection(); 
            } 
        };

        $scope.submitSections = function(){          
            resourceService.SectionMaster.bulk({bulk_section: $scope.section_masters})
                .$promise.then(function(response){
                    if(response[0] == "success"){
                        alert("Bulk Sections Added Successfully");
                        $scope.showSections();
                        $('#myModal').modal('hide');
                        $scope.showErrorMessage = false;
                    }
                    else
                    {
                        $scope.showErrorMessage = true;
                    }                   
                });
        };
      
        $scope.deleteSection = function(section){   
            if(confirm("Are you sure want to delete")){
                section.$delete()
                    .then(function(responce){
                        $scope.showSections();                   
                    })
            }else{
                $('#myModal').modal('hide');
            }          
        };
    }]);
})(angular, myApp)
