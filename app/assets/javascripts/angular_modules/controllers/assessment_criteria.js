(function(angular, app) {
    "use strict";
    app.controller('AssessmentCriteriaController',["$scope", "assessmentCriteriaService", "subjectService", "gradeService", function($scope, assessmentCriteriaService, subjectService, gradeService) {
        $scope.myShowIndexValue= true;       

        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data
            });

        $scope.initialize = function(){
            //$scope.j = 0;            
            $scope.criterias = [];
        };
        
        $scope.addCriteria = function(){            
	    for(var i=0; i<1; i++){
                $scope.criterias.push({
                    myCriteria : "",
                });
            } 

            alert(JSON.stringify($scope.criterias));
            //$scope.j = j+1;
        };

        $scope.destroyCriteria = function($index){
            //alert($index);
            $scope.criterias.splice($index, 1);
            //alert(JSON.stringify($scope.criterias));	    
            //$scope.j = j+1;
        };
        
        $scope.getAssessmentsCriteriaMappings = function(myGrade)        
        {
            assessmentCriteriaService.getAssessmentCriteriaService(myGrade)
                .then(function(result) {
                    $scope.assessments = result.data; 
                    //alert(JSON.stringify($scope.assessments.length));

                    //alert(myGrade);
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

        $scope.showAssessmentsCriteriaMappings = function()
        {
            $scope.myShowFormValue = "true";
            $scope.myFormValue = "false";
        };

        $scope.editAssessmentCriteriaMappings = function()
        {
            $scope.mySubject = false;
            $scope.checked_value = false;
            $scope.grades_all = $scope.grades;
            $scope.assessment_grades=[];
            //alert();
            subjectService.getSubjectServiceView()
                .then(function(result) {
                    $scope.subjects=result.data
                    //alert(JSON.stringify($scope.subjects));
                }); 
           
           
            //alert(JSON.stringify($scope.assessment_grades));
            
            $scope.myShowIndexValue= false;
            $scope.initialize();
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
        };

        $scope.addAssessmentCriteriaMappings = function(grade_master_id,checked_value){
            //alert($scope.assessment_grades.length)
            //alert(checked_value); 
            //alert(grade_master_id); 
            alert(JSON.stringify($scope.criterias)); 
          
            if (!checked_value)
            {
                for(var i = 0; i < $scope.assessment_grades.length; i++)
                {                
                    if ($scope.assessment_grades[i]['grade_master_id'] == grade_master_id)
                    {        
                        alert("slice");        
                        $scope.assessment_grades.splice(i, 1);
                    }                   
                }
            } 
            else
            {
                $scope.assessment_grades.push({
                    grade_master_id: grade_master_id,
                });  
            }
            
            alert(JSON.stringify($scope.assessment_grades));
            
        };       
 
        $scope.saveAssessmentsCriteriaMappings = function()
        {            
            $scope.myShowIndexValue= true;
            $scope.myShowFormValue = false;
            $scope.myFormValue = "false";

            alert($scope.mySubject);
            alert(JSON.stringify($scope.assessment_grades));
            alert(JSON.stringify($scope.criterias)); 

            
        };
        


    }]);    
    
})(angular, myApp);
