(function(angular, app) {
    "use strict";
    app.controller("gradeLabMappingController", ["$scope" , "gradeLabMappingService", "gradesSubjectsMapService" , function($scope , gradeLabMappingService , gradesSubjectsMapService){
        var initiateForm = function(){
            $scope.myShowFormValue = "true";
            $scope.myFormValue = "false";
        };
        initiateForm();

        gradeLabMappingService.getLabNames()
	    .then(function(response){
		$scope.lab_subjects = response.data
                gradesSubjectsMapService.getGradesSubjectsServiceView()
                    .then(function(result) {
                        $scope.show_grades=result.data; 
                        gradeLabMappingService.getSubjectsGradesServiceView()
                            .then(function(result) {
                                $scope.show_subjects=result.data;
                                alert(JSON.stringify($scope.show_subjects))                
                            }); 
                    });
            });

        $scope.defaultGradesSubjectsAll= function(){            
            $scope.grades_subjects_all = []; 
            
            for(var i = 0; i < $scope.show_grades.length; i++)
            {
                $scope.grades_subjects_all.push({
                    grade_master_id: $scope.show_grades[i]['grade_master_id'],
                    grade_name: $scope.show_grades[i]['grade_name'],
                    lab_subjects: [],
                });
                
                for(var j = 0; j < $scope.lab_subjects.length; j++)
                {
                    $scope.grades_subjects_all[i].lab_subjects.push({
                        id: "",
                        subject_master_id: $scope.lab_subjects[j]['subject_master_id'] ,
                        subject_name: $scope.lab_subjects[j]['subject_name'] ,                        
                        checked_value:"",                            
                    });                    
                }
            }   
        };



        $scope.defaultGradesSubjects = function(){     
            $scope.grades_subjects = [];
            alert("show_grades"+$scope.show_grades)
            for(var i = 0; i < $scope.show_grades.length; i++)
            {
                $scope.grades_subjects.push({
                    grade_master_id: $scope.show_grades[i]['grade_master_id'],
                    subject_masters: [],
                    
                });
            }           
        };

        $scope.createSubjectsMappings = function() { 
            alert("create subject mapping")
            $scope.defaultGradesSubjects();
            alert(JSON.stringify($scope.grades_subjects))            
            for ( var i = 0; i < $scope.show_grades.length; i++ ){         
                for ( var j = 0; j < $scope.show_subjects.length; j++ ) {                   
                    if  ($scope.show_grades[i]['grade_master_id'] == $scope.show_subjects[j]['grade_master_id'] )
                    {                             
                        $scope.grades_subjects[i]['subject_masters'].push({  
                        
                            id : $scope.show_subjects[j]['id'],
                            subject_master_id : $scope.show_subjects[j]['subject_master_id'],                           
                        });                                         
                    }
                }                
            }            
        };   


        $scope.editSubjectsMappings = function() {   
        
            $scope.defaultGradesSubjectsAll();
            
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
        
            for ( var i = 0; i < $scope.show_grades.length; i++ ){         
                for ( var j = 0; j < $scope.show_subjects.length; j++ ) {                   
                    // alert($scope.show_subjects.length) 
                    
                    if  ($scope.show_grades[i]['grade_master_id'] == $scope.show_subjects[j]['grade_master_id'] )
                    {
                        for ( var k = 0; k < $scope.grades_subjects_all[i]['lab_subjects'].length; k++ ) {
                            
                            if  ($scope.grades_subjects_all[i]['lab_subjects'][k]['subject_master_id'] == $scope.show_subjects[j]['subject_master_id'] )
                            {
                                $scope.grades_subjects_all[i]['lab_subjects'][k]['id'] = $scope.show_subjects[j]['id']; 
                                $scope.grades_subjects_all[i]['lab_subjects'][k]['checked_value'] = true;                              
                            }    
                            
                        }
                        
                    }
                }
            }            
            $scope.createSubjectsMappings();
         
        };

        $scope.saveSubjectsMappings = function() {
            // alert(JSON.stringify($scope.grades_subjects))
            alert('')
            $scope.save_grades_subjects = [];
            console.log("testing......")
            for(var i = 0; i < $scope.grades_subjects.length; i++){
                console.log("outer loop" + i);
                for(var j = 0; j < $scope.grades_subjects[i]['subject_masters'].length; j++){
                    console.log("inner loop" + j);
                    $scope.save_grades_subjects.push({
                        grade_master_id: $scope.grades_subjects[i]['grade_master_id'],                        
                        id:  $scope.grades_subjects[i]['subject_masters'][j]['id'], 
                        subject_master_id: $scope.grades_subjects[i]['subject_masters'][j]['subject_master_id'], 
                    });                      
                }               
            }
            alert($scope.save_grades_subjects.length)
            console.log($scope.save_grades_subjects)
            gradeLabMappingService.saveSubjectsMappings($scope.save_grades_subjects)
                .then(function(result) {

               
                }); 
            
            $scope.showSubjectsMappings();
        };
        $scope.showSubjectsMappings = function(){            
            $scope.myFormValue = "false";
            $scope.myShowFormValue = "true";
         
            gradeLabMappingService.getSubjectsGradesServiceView()
                .then(function(result) { 
                    $scope.show_subjects=result.data; 
                }); 
        };
        $scope.addLabSubjects = function(value,grade_master_id,subject){  
             
            for(var i = 0; i < $scope.show_grades.length; i++)
                
            {                
                if ($scope.show_grades[i]['grade_master_id'] == grade_master_id)
                {                    
                    if (!value)
                    {                        
                        for(var j = $scope.grades_subjects[i]['subject_masters'].length - 1; j >= 0; j--) {
                            if($scope.grades_subjects[i]['subject_masters'][j]['subject_master_id'] === subject['subject_master_id']) {
                                $scope.grades_subjects[i]['subject_masters'].splice(j, 1);
                            }
                        }
                    } 
                    else
                    {                         
                        $scope.grades_subjects[i]['subject_masters'].push({
                            id: subject['id'],
                            subject_master_id: subject['subject_master_id']
                        });                       
                    }
                }
            }            
        };

        $scope.addAllSubjects = function(value,grade_master_id,subjects,grade){
          alert(' ') 
            $scope.grade = grade; 

            for(var i = 0; i < $scope.show_grades.length; i++)
            {        
                 alert(JSON.stringify($scope.show_grades))       
                if ($scope.show_grades[i]['grade_master_id'] == grade_master_id)
                {                    
                    if (!value)
                    {          
                        $scope.grades_subjects[i]['subject_masters'] = [];
                        for(var k = 0; k <lab_subjects.length; k++){
                            $scope.grade['lab_subjects'][k]['checked_value'] = false;
                        };                       
                    } 
                    else
                    {      
                        for(var k = 0; k <lab_subjects.length; k++){
                            $scope.grades_subjects[i]['subject_masters'].push({
                                id: lab_subjects[k]['id'],
                                subject_master_id: lab_subjects[k]['subject_master_id']                                 
                            });
                            $scope.grade['lab_subjects'][k]['checked_value'] = "true";                             
                        }                                             
                    }
                }
            }            
        };
    }]);
})(angular, myApp);

