(function(angular, app) {
    "use strict";
    app.controller("LabMasterController", ["$scope" , "labService" , '$window' , function($scope , labService , $window){
	$scope.myShowIndexValue= true;       
	
	labService.getGradeNames()
	    .then(function(response){
		$scope.all_grades = response.data
	    });
	
	$scope.initialize = function(){                       
            $scope.criterias = [];
            $scope.criterias.push({
                myCriteria : "",
            });
        };
        
	$scope.addCriteria = function(){	   
            $scope.criterias.push({
                myCriteria : "",
            });           
        };
	$scope.destroyCriteria = function($index){            
            $scope.criterias.splice($index, 1);            
        };
	$scope.showAssessmentsCriteriaMappings = function()
        { 
            $scope.myShowIndexValue= true;
            $scope.myShowFormValue = true;
            $scope.myFormValue = "false";           
            $scope.getAssessmentsCriteriaMappings($scope.labName);
        };
	$scope.getAssessmentsCriteriaMappings = function(labName)        
        {
	    labService.getAssessmentCriteria(labName)
		.then(function(result) {
		    $scope.assessments = result.data;                   
		    if (result.data.length != 0)
                    {
                        $scope.myShowFormValue = "true";
                        $scope.myFormValue = "false";
                    }
                    else
                    { 
                        $scope.myShowFormValue = "false";
                        $scope.myFormValue = "false"; 
                        alert("There is No Assessments For This Grade ");                                     
                    }
		});
	};
	


	$scope.allGrades = function(){
	    $scope.mySubject = false;
            $scope.checked_value = false;
	    $scope.lab_grades=[];
	    labService.getLabNames()
		.then(function(response){
		    $scope.lab_masters = response.data
		});
	    $scope.myShowIndexValue= false;
            $scope.initialize();
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
	}
	
	$scope.addGradeArray = function(grade_master_id , checked_value){
	    if (!checked_value)
	    {
		for(var i = 0; i < $scope.lab_grades.length; i++)
		{
		    if ($scope.lab_grades[i]['grade_master_id'] == grade_master_id)
                    {                                     
                        $scope.lab_grades.splice(i, 1);
                    }                   
                }
	    } 
	    
            else
            {
		
                $scope.lab_grades.push({
                    grade_master_id: grade_master_id,
                });  
		
            }            
        };    
	
	$scope.saveAssessmentCriteria = function(){
	    $scope.myShowIndexValue = true;
            $scope.myShowFormValue = false;
            $scope.myFormValue = "false";
	    $scope.save_assessment_criterias = [];
	    for (var i = 0; i < $scope.lab_grades.length; i++){
                for (var j = 0; j < $scope.criterias.length; j++){
                    $scope.save_assessment_criterias.push({
                        subject_master_id : $scope.labName,
                        grade_master_id : $scope.lab_grades[i]['grade_master_id'],
                        lab_criteria : $scope.criterias[j]['myCriteria'],                        
                    });                        
                }       
            }
	    
            labService.saveCriteria($scope.save_assessment_criterias)
                .then(function(result) {
                    $window.location.href = '/lab_criterias';
                });
	    
            $scope.all_grades = []; 
            $scope.showAssessmentsCriteriaMappings();                                                
        };
	$scope.deleteAssessmentCriteriaMappings = function (assessment_id){
            $scope.delete_mappping_id = assessment_id
            labService.deleteAssessmentCriteriaMappings($scope.delete_mappping_id)
                .then(function(result) {
		    $scope.showAssessmentsCriteriaMappings();                                                
                }); 
        }; 
	
	
   }]);
    
})(angular, myApp);
