(function(angular, app) {
    "use strict";
    app.controller('GradesSectionsMappingController',["$scope", "timeTableService","gradesSectionsMapService", function($scope, timeTableService, gradesSectionsMapService) {  
        var initiateForm = function(){
            $scope.myShowFormValue = "true";
            $scope.FormValue = "false";
        };
        initiateForm();
       
        timeTableService.getSectionServiceView()
            .then(function(result) {
                $scope.sections=result.data; 
                          
            });      
       
        
        timeTableService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data;             
         
            });

        gradesSectionsMapService.getGradesSectionsServiceView()
            .then(function(result) {
                alert(' ')
                $scope.show_grades=result.data;
                alert(JSON.stringify($scope.show_grades))                
            }); 

        $scope.defaultSectionsGradesAll= function(){            
            $scope.sections_grades_all = []; 
            
            for(var i = 0; i < $scope.sections.length; i++)
            {
                $scope.sections_grades_all.push({
                    section_master_id: $scope.sections[i]['section_master_id'],
                    section_name: $scope.sections[i]['section_name'],
                    grades: [],
                });
                
                for(var j = 0; j < $scope.grades.length; j++)
                {
                    $scope.sections_grades_all[i].grades.push({
                        id: "",
                        grade_master_id: $scope.grades[j]['grade_master_id'] ,
                        text: $scope.grades[j]['grade_name'] ,                        
                        checked_value:"",                            
                    });                    
                }
            }   
        };

        $scope.defaultSectionsGrades = function(){     
            $scope.sections_grades = [];
            alert(' ')
            
            
            for(var i = 0; i < $scope.sections.length; i++)
            {
                $scope.sections_grades.push({
                    section_master_id: $scope.sections[i]['section_master_id'],
                    grade_masters: [],
                    
                });
            }           
        };

        $scope. createGradesMappings = function() {           
            $scope.defaultSectionsGrades();
            
            for ( var i = 0; i < $scope.sections.length; i++ ){         
                for ( var j = 0; j < $scope.show_grades.length; j++ ) {                   
                    if  ($scope.sections[i]['section_master_id'] == $scope.show_grades[j]['section_master_id'] )
                    {                             
                        $scope.sections_grades[i]['grade_masters'].push({  
                            
                            id : $scope.show_grades[j]['id'],
                            grade_master_id : $scope.show_grades[j]['grade_master_id'],                           
                        });                                         
                    }
                }                
            }            
        };   

        $scope.editGradesMappings = function() {   
           
            $scope.defaultSectionsGradesAll();
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
            
            for ( var i = 0; i < $scope.sections.length; i++ ){         
                for ( var j = 0; j < $scope.show_grades.length; j++ ) {                   
                    alert($scope.show_grades.length)  
                    if  ($scope.sections[i]['section_master_id'] == $scope.show_grades[j]['section_master_id'] )
                    {
                        for ( var k = 0; k < $scope.sections_grades_all[i]['grades'].length; k++ ) {
                            
                            if  ($scope.sections_grades_all[i]['grades'][k]['grade_master_id'] == $scope.show_grades[j]['grade_master_id'] )
                            {
                                $scope.sections_grades_all[i]['grades'][k]['id'] = $scope.show_grades[j]['id']; 
                                $scope.sections_grades_all[i]['grades'][k]['checked_value'] = true;                              
                            }    
                            
                        }
                        
                    }
                }
            }            
            $scope.createGradesMappings();
        };

        $scope.saveGradesMappings = function() {
            $scope.save_sections_grades = [];
            for(var i = 0; i < $scope.sections_grades.length; i++)
            {               
                for(var j = 0; j < $scope.sections_grades[i]['grade_masters'].length; j++)
                {
                    $scope.save_sections_grades.push({
                        section_master_id: $scope.sections_grades[i]['section_master_id'],                        
                        id:  $scope.sections_grades[i]['grade_masters'][j]['id'], 
                        grade_master_id: $scope.sections_grades[i]['grade_masters'][j]['grade_master_id'], 
                    });                      
                }               
            }
           
            gradesSectionsMapService.saveGradesMappings($scope.save_sections_grades)
                .then(function(result) {
                    
                }); 
            
            $scope.showGradesMappings();
        };

        $scope.showGradesMappings = function(){            
            $scope.myFormValue = "false";
            $scope.myShowFormValue = "true";
            
            gradesSectionsMapService.getGradesSectionsServiceView()
                .then(function(result) { 
                    $scope.show_grades=result.data; 
                }); 
        };
        
        $scope.addGrades = function(value,section_master_id,grade){          
            for(var i = 0; i < $scope.sections.length; i++)
            {                
                if ($scope.sections[i]['section_master_id'] == section_master_id)
                {                    
                    if (!value)
                    {                        
                        for(var j = $scope.sections_grades[i]['grade_masters'].length - 1; j >= 0; j--) {
                            if($scope.sections_grades[i]['grade_masters'][j]['grade_master_id'] === grade['grade_master_id']) {
                                $scope.sections_grades[i]['grade_masters'].splice(j, 1);
                            }
                        }
                    } 
                    else
                    {                         
                        $scope.sections_grades[i]['grade_masters'].push({
                            id: grade['id'],
                            grade_master_id: grade['grade_master_id']
                        });                       
                    }
                }
            }            
        };

         $scope.addAllGrades = function(value,section_master_id,grades,section){ 
             $scope.section = section; 
            for(var i = 0; i < $scope.sections.length; i++)
            {                
                if ($scope.sections[i]['section_master_id'] == section_master_id)
                {                    
                    if (!value)
                    {          
                        $scope.sections_grades[i]['grade_masters'] = [];
                        for(var k = 0; k <grades.length; k++){
                            $scope.section['grades'][k]['checked_value'] = false;
                        };                       
                    } 
                    else
                    {      
                        for(var k = 0; k <grades.length; k++){
                            $scope.sections_grades[i]['grade_masters'].push({
                                id: grades[k]['id'],
                                grade_master_id: grades[k]['grade_master_id']                                 
                            });
                            $scope.section['grades'][k]['checked_value'] = "true";                             
                        }                                             
                    }
                }
            }            
        };

        
    }]);    
})(angular, myApp);

