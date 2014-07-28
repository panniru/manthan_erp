(function(angular, app) {
    "use strict";
    app.controller('AssessmentCriteriaController',["$scope", "assessmentCriteriaService", "subjectService", "gradeService", function($scope, assessmentCriteriaService, subjectService, gradeService) {
        $scope.myShowIndexValue= true;       

        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data
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
        
        $scope.getAssessmentsCriteriaMappings = function(myGrade)        
        {
            assessmentCriteriaService.getAssessmentCriteriaService(myGrade)
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

        $scope.showAssessmentsCriteriaMappings = function()
        {
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "false";
            myShowIndexValue= true;
        };

        $scope.editAssessmentCriteriaMappings = function()
        {
            $scope.mySubject = false;
            $scope.checked_value = false;
            $scope.grades_all = $scope.grades;
            $scope.assessment_grades=[];

            subjectService.getSubjectServiceView()
                .then(function(result) {
                    $scope.subjects=result.data; 
                    alert(JSON.stringify($scope.subjects));
                }); 
            
            $scope.myShowIndexValue= false;
            $scope.initialize();
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
        };

        $scope.addAssessmentCriteriaMappings = function(grade_master_id,checked_value){          
            if (!checked_value)
            {
                for(var i = 0; i < $scope.assessment_grades.length; i++)
                {                
                    if ($scope.assessment_grades[i]['grade_master_id'] == grade_master_id)
                    {                                     
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
        };       
 
        $scope.saveAssessmentCriteriaMappings = function()
        {            
            $scope.myShowIndexValue = true;
            $scope.myShowFormValue = false;
            $scope.myFormValue = "false";
            $scope.save_assessment_criterias = [];

            for (var i = 0; i < $scope.assessment_grades.length; i++){
                for (var j = 0; j < $scope.criterias.length; j++){
                    $scope.save_assessment_criterias.push({
                        subject_master_id : $scope.mySubject,
                        grade_master_id : $scope.assessment_grades[i]['grade_master_id'],
                        subject_criteria : $scope.criterias[j]['myCriteria'],                        
                    });                        
                }       
            }

            //alert(JSON.stringify($scope.save_assessment_criterias));
            //alert($scope.mySubject+"=="+JSON.stringify($scope.assessment_grades)+"=="+JSON.stringify($scope.criterias)); 

            assessmentCriteriaService.saveAssessmentCriteriaMappings($scope.save_assessment_criterias)
                .then(function(result) {
                                       
                });

            $scope.grades_all = []; 
            $scope.showAssessmentsCriteriaMappings();
        };

        $scope.deleteAssessmentCriteriaMappings = function (assessment_id){
            $scope.delete_mappping_id = assessment_id
            assessmentCriteriaService.deleteAssessmentCriteriaMappings($scope.delete_mappping_id)
                .then(function(result) {
                    
                }); 
            $scope.getAssessmentsCriteriaMappings($scope.myGrade);            
        }; 


    }]);    
    
})(angular, myApp);
