(function(angular, app) {
    "use strict";
    app.controller("LabMasterController", ["$scope" , "labService" , '$window' , function($scope , labService , $window){
	$scope.myShowIndexValue= true;       
	
	labService.getGradeNames()
	    .then(function(response){
		$scope.all_grades = response.data
                alert(JSON.stringify($scope.all_grades))    
            
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

        $scope.editAssessmentTypeMappings = function(assessment_type){        
          
            $scope.edit_assessment_types = [];
        
            $scope.edit_assessment_types.push({
              
                id: assessment_type.id,
              
                assessment_type : assessment_type.assessment_type,
            });                       
        };

        labService.getAssessmentTypesService()
            .then(function(result) {                 
                $scope.assessment_types = result.data;  
               
                  
            });      

        $scope.showAssessmentTypeMappings = function(){
      
            labService.getAssessmentTypesService()
                .then(function(result) {                 
                    $scope.assessment_types = result.data;   
                                 
                });
        };
 
        $scope.saveAssessmentTypeMappings = function(assessment_type){           
            $scope.save_assessment_types = [];

            $scope.save_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,

            });

            labService.saveAssessmentTypeMappings($scope.save_assessment_types)
                .then(function(result) {  
                    $scope.showAssessmentTypeMappings();
                    
                });          
        };

	$scope.deleteAssessmentTypeMappings = function(assessment_type){           
            $scope.delete_mappping_id =assessment_type.id;
            
            labService.deleteAssessmentTypeMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                });  
            
            $scope.showAssessmentTypeMappings();       
            
        };

        // ASSESSMENT GRADE MAPPINGS
        labService.getAssessmentGradeMappingsService()
            .then(function(result) {                 
                $scope.assessment_grade_mappings = result.data;        
                alert(JSON.stringify($scope.assessment_grade_mappings))            
            });
       

        $scope.showAssessmentGradeMappings = function(){
            labService.getAssessmentGradeMappingsService()
                .then(function(result) {                 
                    $scope.assessment_grade_mappings = result.data;                      
                    alert(JSON.stringify($scope.assessment_grade_mappings))            
                       
                      
                });
        };

        $scope.editAssessmentGradeMappings = function(assessment_type){ 
            alert('testing')
            $scope.edit_assessment_types = [];
            alert(JSON.stringify($scope.edit_assessment_types))
          
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
               
            });           
            $scope.edit_assessment_grade_mappings = [];
            alert('testing2')
            alert(JSON.stringify($scope.edit_assessment_grade_mappings))
          

            for (var i = 0; i < $scope.all_grades.length; i++){
                 alert(JSON.stringify($scope.all_grades.length))         
                
                $scope.edit_assessment_grade_mappings.push({
                    
                    id: "",
                    lab_assessment_id: assessment_type.id,
                    grade_master_id: $scope.all_grades[i]['grade_master_id'],
                 
                    no_of_times:"", 
                   
                   
                });  
                // alert(JSON.stringify($scope.assessment_type.id))  
                // alert(JSON.stringify($scope.all_grades[i]['grade_master_id']))
                
                
            }
            
            for (var i = 0; i < $scope.assessment_grade_mappings.length; i++){
                alert(JSON.stringify($scope.assessment_grade_mappings))

                if($scope.assessment_grade_mappings[i]['lab_assessment_id'] == lab_assessment.id){
                
                    for (var j = 0; j < $scope.edit_assessment_grade_mappings.length; j++){
                        alert(JSON.stringify($scope.edit_assessment_grade_mappings.length))
                        if($scope.assessment_grade_mappings[i]['grade_master_id'] == $scope.edit_assessment_grade_mappings[j]['grade_master_id']){
                            alert('456 ')
                            $scope.edit_assessment_grade_mappings[j]['id'] = $scope.assessment_grade_mappings[i]['id'];
                            $scope.edit_assessment_grade_mappings[j]['no_of_times'] = $scope.assessment_grade_mappings[i]['no_of_times'];                                $scope.edit_assessment_grade_mappings[j]['grade_master_id'] = $scope.assessment_grade_mappings[i]['grade_master_id'];                   
                        }                 
                    }
                }
            }
        };

        $scope.saveAssessmentGradeMappings = function(){            
            $scope.save_assessment_grade_mappings = [];
            alert(JSON.stringify($scope.edit_assessment_grade_mappings))
            for (var i = 0; i < $scope.edit_assessment_grade_mappings.length; i++)
            {
                
                if($scope.edit_assessment_grade_mappings[i]['no_of_times'] != ""){
                    $scope.save_assessment_grade_mappings.push({
                        id: $scope.edit_assessment_grade_mappings[i]['id'],
                        lab_assessment_id: $scope.edit_assessment_grade_mappings[i]['lab_assessment_id'],
                        grade_master_id: $scope.edit_assessment_grade_mappings[i]['grade_master_id'],
                        no_of_times: $scope.edit_assessment_grade_mappings[i]['no_of_times'],
                    });
                }
            }
            
            labService.saveAssessmentGradeMappings($scope.save_assessment_grade_mappings)
                .then(function(result) {    
                     $scope.showAssessmentGradeMappings(); 
                });           
        };

        // show assessments
        // $scope.getSections = function (myGrade){
        //     labService.getSectionsForGradeService(myGrade)
        //         .then(function(result) {
        //             $scope.sections=result.data;
        //         });
        // };  



   }]);
    
})(angular, myApp);
