(function(angular, app) {
    "use strict";
    app.controller('GradesSubjectsMappingController',["$scope", "timeTableService", "gradesSubjectsMapService", function($scope, timeTableService, gradesSubjectsMapService) {  
        $scope.myShowFormValue = "true";
        $scope.FormValue = "false";

        timeTableService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data;                 
            });
        
        timeTableService.getSubjectServiceView()
            .then(function(result) {
                $scope.subjects=result.data;                
            });        
        
        gradesSubjectsMapService.getGradesSubjectsServiceView()
            .then(function(result) {
                $scope.show_grades=result.data;               
            });        

        $scope.defaultSubjectsGradesAll= function(){            
            $scope.subjects_grades_all = [];         
            
            for(var i = 0; i < $scope.subjects.length; i++)
            {
                $scope.subjects_grades_all.push({
                    subject_master_id: $scope.subjects[i]['subject_master_id'],
                    subject_name: $scope.subjects[i]['subject_name'],
                    grades: [],
                });
                
                for(var j = 0; j < $scope.grades.length; j++)
                {
                    $scope.subjects_grades_all[i].grades.push({
                        id: "",
                        grade_master_id: $scope.grades[j]['grade_master_id'] ,
                        text: $scope.grades[j]['grade_name'] ,                        
                        checked_value:"",                            
                    });                    
                }
            }   
        };

        $scope.defaultSubjectsGrades = function(){     
            $scope.subjects_grades = [];
            
            for(var i = 0; i < $scope.subjects.length; i++)
            {
                $scope.subjects_grades.push({
                    subject_master_id: $scope.subjects[i]['subject_master_id'],
                    grade_masters: [],
                    
                });
            }           
        };

        $scope. createGradesMappings = function() {           
            $scope.defaultSubjectsGrades();
            
            for ( var i = 0; i < $scope.subjects.length; i++ ){         
                for ( var j = 0; j < $scope.show_grades.length; j++ ) {                   
                    if  ($scope.subjects[i]['subject_master_id'] == $scope.show_grades[j]['subject_master_id'] )
                    {                             
                        $scope.subjects_grades[i]['grade_masters'].push({  
                            
                            id : $scope.show_grades[j]['id'],
                            grade_master_id : $scope.show_grades[j]['grade_master_id'],                           
                        });                                         
                    }
                }                
            }            
        };   

        $scope.editGradesMappings = function() {            
            $scope.defaultSubjectsGradesAll();
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
            
            for ( var i = 0; i < $scope.subjects.length; i++ ){         
                for ( var j = 0; j < $scope.show_grades.length; j++ ) {                   
                    if  ($scope.subjects[i]['subject_master_id'] == $scope.show_grades[j]['subject_master_id'] )
                    {
                        for ( var k = 0; k < $scope.subjects_grades_all[i]['grades'].length; k++ ) {
                            
                            if  ($scope.subjects_grades_all[i]['grades'][k]['grade_master_id'] == $scope.show_grades[j]['grade_master_id'] )
                            {
                                $scope.subjects_grades_all[i]['grades'][k]['id'] = $scope.show_grades[j]['id']; 
                                $scope.subjects_grades_all[i]['grades'][k]['checked_value'] = true;                              
                            }    
                            
                        }
                        
                    }
                }
            }            
            $scope.createGradesMappings();
        };

        $scope.saveGradesMappings = function() {
            $scope.save_subjects_grades = [];
            for(var i = 0; i < $scope.subjects_grades.length; i++)
            {               
                for(var j = 0; j < $scope.subjects_grades[i]['grade_masters'].length; j++)
                {
                    $scope.save_subjects_grades.push({
                        subject_master_id: $scope.subjects_grades[i]['subject_master_id'],                        
                        id:  $scope.subjects_grades[i]['grade_masters'][j]['id'], 
                        grade_master_id: $scope.subjects_grades[i]['grade_masters'][j]['grade_master_id'], 
                    });                      
                }               
            }
           
            gradesSubjectsMapService.saveGradesMappings($scope.save_subjects_grades)
                .then(function(result) {
                    
                }); 
            
            $scope.showGradesMappings();
        };

        $scope.showGradesMappings = function(){            
            $scope.myFormValue = "false";
            $scope.myShowFormValue = "true";
            
            gradesSubjectsMapService.getGradesSubjectsServiceView()
                .then(function(result) { 
                    $scope.show_grades=result.data; 
                }); 
        };
        
        $scope.addGrades = function(value,subject_master_id,grade){          
            for(var i = 0; i < $scope.subjects.length; i++)
            {                
                if ($scope.subjects[i]['subject_master_id'] == subject_master_id)
                {                    
                    if (!value)
                    {                        
                        for(var j = $scope.subjects_grades[i]['grade_masters'].length - 1; j >= 0; j--) {
                            if($scope.subjects_grades[i]['grade_masters'][j]['grade_master_id'] === grade['grade_master_id']) {
                                $scope.subjects_grades[i]['grade_masters'].splice(j, 1);
                            }
                        }
                    } 
                    else
                    {                         
                        $scope.subjects_grades[i]['grade_masters'].push({
                            id: grade['id'],
                            grade_master_id: grade['grade_master_id']
                        });                       
                    }
                }
            }            
        };


    }]);       
})(angular, myApp);
