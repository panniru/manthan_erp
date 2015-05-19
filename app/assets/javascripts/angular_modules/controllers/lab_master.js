(function(angular, app) {
    "use strict";
    app.controller("LabMasterController", ["$scope" ,"$location","labService" , "labMappingService","gradingService",'$window' , function($scope ,$location, labService , labMappingService , $window){
	$scope.myShowIndexValue= true;       
	
	labService.getGradeNames()
	    .then(function(response){
		$scope.all_grades = response.data
            });
	// gradingService.getGradingServiceView()
	//     .then(function(response){
	// 	$scope.show_gradings = response.data
        //     });
	
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
                    
            });
       

        $scope.showAssessmentGradeMappings = function(){
            labService.getAssessmentGradeMappingsService()
                .then(function(result) {                 
                    $scope.assessment_grade_mappings = result.data;                      
                   
                 
                      
                });
        };

        $scope.editAssessmentGradeMappings = function(assessment_type){ 
    
            $scope.edit_assessment_types = [];
            $scope.edit_assessment_types.push({
                id: assessment_type.id,
                assessment_type : assessment_type.assessment_type,
               
            });           
            $scope.edit_assessment_grade_mappings = [];
            for (var i = 0; i < $scope.all_grades.length; i++){
                $scope.edit_assessment_grade_mappings.push({
                    id: "",
                    lab_assessment_id: assessment_type.id,
                    grade_master_id: $scope.all_grades[i]['grade_master_id'],
                    no_of_times:"", 
                });  
            }
            
            for (var i = 0; i < $scope.assessment_grade_mappings.length; i++){
                if($scope.assessment_grade_mappings[i]['lab_assessment_id'] == lab_assessment.id){
                
                    for (var j = 0; j < $scope.edit_assessment_grade_mappings.length; j++){
                        
                        if($scope.assessment_grade_mappings[i]['grade_master_id'] == $scope.edit_assessment_grade_mappings[j]['grade_master_id']){
                         
                            $scope.edit_assessment_grade_mappings[j]['id'] = $scope.assessment_grade_mappings[i]['id'];
                            $scope.edit_assessment_grade_mappings[j]['no_of_times'] = $scope.assessment_grade_mappings[i]['no_of_times'];                                $scope.edit_assessment_grade_mappings[j]['grade_master_id'] = $scope.assessment_grade_mappings[i]['grade_master_id'];                   
                        }                 
                    }
                }
            }
        };

        $scope.saveAssessmentGradeMappings = function(){            
            $scope.save_assessment_grade_mappings = [];
        
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
        // labService.getAssessmentSubjectsService()
        //     .then(function(result) {                 
        //         $scope.lab_subject_assessments = result.data;  
        
        //     }); 
        

        $scope.showAssessmentSubjectsMappings = function(){
            labService.getAssessmentSubjectsService()
                .then(function(result) {                 
                    $scope.add_assessments = result.data;   
                });
        };

        // labService.getAssessmentSubjectsService()
        //     .then(function(result) {                 
        //         $scope.assess = result.data;   
        //         alert(JSON.stringify($scope.add_assessments))                            });
        
        $scope.addAssessments = function(){
           
            $scope.add_assessments = [];
         
            labMappingService.getAllSubjects()
                .then(function(result){
                    $scope.subject_names = result.data
                });
           
           
            $scope.add_assessments.push({
                assessment_name : "",
                lab_assessment_id : "",
                subject_master_id : "",
            }); 
            
        };
        
       

        $scope.saveAssessments = function(){
       
            $scope.save_assessments = [];
        
            $scope.save_assessments.push({
                id : " ",
                assessment_name : " ",
                lab_assessment_id : " ",
        
                 subject_master_id : " ",

            });
      
            labService.saveAssessments($scope.add_assessments)
                .then(function(result) {
                    $scope.add_assessments();
                 
            e        // $scope.showAssessmentSubjectsMappings();
                    // alert(JSON.stringify($scope.showAssessmentSubjectsMappings))
             
                            
                });
        };



       
        // labService.get_student_names()
        //     .then(function(result){
        //         $scope.results = result.data
        //     });
	      
        // $scope.getTeacherMappings = function(){ 
        //     alert(' ')
        //     var path = "/";
        //     path = "/teacher_assessment";
        //     $location.path(path);            
        //     $scope.myGrade = $scope.selectedUser['grade_master_id'];
          
        //     $scope.mySubject = $scope.selectedUser['subject_master_id']; 
        //     labService.getTeacherService($scope.myGrade, $scope.mySubject)
        //         .then(function(result) {                 
        //             $scope.teacher_assessment = result.data;
        //         });  
        // };    


        $scope.getTeacherMappings = function(selected_user) {
          
            labService.getBothValue(selected_user)
            .then(function(result) {
                // alert(JSON.stringify(selected_user))
                $scope.both_values = result.data;
            });
        }

        // $scope.getMappings = function(date) {
        //     alert()
        //     labService.getValue(date)
        //         .then(function(result) {
        //             // alert(JSON.stringify(selected_user))
        //             $scope.lab_values = result.data;
        //             alert(JSON.stringify($scope.lab_values))
                    
        //         });
        // }

        

        // $scope.showAssessments = function(myGrade,mySection){          
        //     assessmentsService.getAssessments()
        //         .then(function(result) {  
        //             $scope.assessments = result.data;
        //         }); 
        // };
        labService.getTeacherSubjectMapping()
            .then(function(result) {
                $scope.unAssignedUsers = result.data;
               
                $scope.selectedUser =  $scope.unAssignedUsers[0];
                
                $scope.combined = function(user){
                    if(user.grade_name == undefined || user.grade_name == ''){
                        return user.subject_name;
                    }
                    else {
                        return user.grade_name + "-" + user.subject_name;
                    }
                }
            });

        $('#lab_assessments_calendar').fullCalendar({  
            
            selectable: true,
            select: function(date) {
                $scope.dateFormat = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();        
                $('#myModal').modal('show');                
            }            
        });      
        
        $scope.cancelMyModal = function(){            
            $('#myModal').modal('hide');        
        };
        
     
        $scope.saveTeacherMappings = function(){            
            $scope.save_teacher_assessments  = [];

            $scope.save_teacher_assessments.push({ 
                id: "",
                faculty_master_id: "",
                grade_master_id: $scope.myGrade,
            
                subject_master_id: $scope.mySubject,
                assessment_id: $scope.myAssessment,
                assessment_desc: $scope.myAssessmentDescription,
                assessment_date: $scope.dateFormat,
            });

            labService.saveTeacherMappings($scope.save_teacher_assessments)
                .then(function(result) {   
               
                    $scope.cancelMyModal();                   
                });      
        };
        
       
	$scope.saveAll = function(listing_id,grading ,student_id ){
            $scope.save_all  = [];
            $scope.save_all.push({ 
                id: "",
                listing_id: listing_id.listing_id,
                grading_master_id: $scope.grading,
                student_master_id: student_id,
	    });
	    
	    labService.save_all(listing_id,grading,student_id)
		.then(function(result) {
                    $('#createModal').modal('hide');
                    window.location.href="/lab_results/lab" 
                });
	};
        $scope.mapGrade = function(grade_master_id,listing_id){
        
            $scope.grade_master_id = grade_master_id
            $scope.listing_id = listing_id
            $('#createModal').modal('show');
      
            labService.getStudent(grade_master_id,listing_id)
                .then(function(result){
                    $('#createModal').modal('show');
                    $scope.all_students = result.data;
                    
                });
        };
    }]);
})(angular, myApp);



