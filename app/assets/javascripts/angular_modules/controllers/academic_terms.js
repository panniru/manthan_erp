(function(angular, app) {
    "use strict";
    app.controller('AcademicTermsController', ["$scope", "academicTermsService", function($scope, academicTermsService) {        
        academicTermsService.getAcademicTermsService()
            .then(function(result) {                     
                $scope.academic_terms = result.data;                
            });

        $scope.showAcademicTerms = function(){
            $('#myAcademicTermsModal').modal('hide');           
            academicTermsService.getAcademicTermsService()
                .then(function(result) {                     
                    $scope.academic_terms = result.data;                   
                });
        };

        $scope.editAcademicTerms = function(mapping){ 
            $('#myAcademicTermsModal').modal('show');         
            $scope.save_academic_terms = []; 

            $scope.save_academic_terms.push({
                id: mapping.id,
                term_name: mapping.term_name,
                from_date: mapping.from_date,
                to_date: mapping.to_date,
            });            
        };

        $scope.saveAcademicTerms = function(){
            academicTermsService.saveAcademicTermsService($scope.save_academic_terms)
                .then(function(result) {
                });
            
            $scope.showAcademicTerms();
        };

        $scope.deleteAcademicTerms = function(mapping){           
            $scope.delete_academic_term_id = mapping.id;
            
            academicTermsService.deleteAcademicService($scope.delete_academic_term_id)
                .then(function(result) {
                    
                });             
            
            $scope.showAcademicTerms();
        };        

    }]);    
})(angular, myApp);
