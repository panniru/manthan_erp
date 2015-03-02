(function(angular, app) {
    "use strict";
    app.controller('GradeActivitiesMappingController',["$scope", "gradeActivitiesMapService", "nonAcademicsService", "academicsService", function($scope, gradeActivitiesMapService, nonAcademicsService, academicsService) { 
        var initiateForm = function(){
            $scope.showFormValue = true;
            $scope.editFormValue = false;
        };
        initiateForm();

        academicsService.getGrades()
            .then(function(result) {
                $scope.grades = result.data;
            });
        
        nonAcademicsService.getNonAcademicsSubjects()
            .then(function(result) {
                $scope.activities=result.data;
            });        
        
        gradeActivitiesMapService.getGradeActivities()
            .then(function(result) {
                $scope.show_grades=result.data;
              
            });        

        $scope.defaultActivitiesGradesAll= function(){            
            $scope.activities_grades_all = [];         
            
            for(var i = 0; i < $scope.activities.length; i++)
            {
                $scope.activities_grades_all.push({
                    activity_master_id: $scope.activities[i]['id'],
                    activity_name: $scope.activities[i]['activity_name'],
                    grades: [],
                });
                
                for(var j = 0; j < $scope.grades.length; j++)
                {
                    $scope.activities_grades_all[i].grades.push({
                        id: "",
                        grade_master_id: $scope.grades[j]['grade_master_id'] ,
                        text: $scope.grades[j]['grade_name'] ,                        
                        checked_value:"",                            
                    });                    
                }
            }   
        };

        $scope.defaultActivitiesGrades = function(){     
            $scope.activities_grades = [];
            
            for(var i = 0; i < $scope.activities.length; i++)
            {
                $scope.activities_grades.push({
                    activity_master_id: $scope.activities[i]['id'],
                    grade_masters: [],
                    
                });
            }           
        };

        $scope. createGradesMappings = function() {           
            $scope.defaultActivitiesGrades();
            
            for ( var i = 0; i < $scope.activities.length; i++ ){         
                for ( var j = 0; j < $scope.show_grades.length; j++ ) {                   
                    if  ($scope.activities[i]['id'] == $scope.show_grades[j]['activity_master_id'] )
                    {                             
                        $scope.activities_grades[i]['grade_masters'].push({  
                            
                            id : $scope.show_grades[j]['activity_master_id'],
                            grade_master_id : $scope.show_grades[j]['grade_master_id'],                           
                        });                                         
                    }
                }                
            }            
        };   

        $scope.editGradesMappings = function() {            
            $scope.defaultActivitiesGradesAll();
            $scope.showFormValue = false;
            $scope.editFormValue = true;
            
            for ( var i = 0; i < $scope.activities.length; i++ ){         
                for ( var j = 0; j < $scope.show_grades.length; j++ ) {                   
                    if  ($scope.activities[i]['id'] == $scope.show_grades[j]['activity_master_id'] )
                    {
                        for ( var k = 0; k < $scope.activities_grades_all[i]['grades'].length; k++ ) {
                            
                            if  ($scope.activities_grades_all[i]['grades'][k]['grade_master_id'] == $scope.show_grades[j]['grade_master_id'] )
                            {
                                $scope.activities_grades_all[i]['grades'][k]['id'] = $scope.show_grades[j]['id']; 
                                $scope.activities_grades_all[i]['grades'][k]['checked_value'] = true;                              
                            }    
                            
                        }
                        
                    }
                }
            }            
            $scope.createGradesMappings();
        };

        $scope.saveGradeActivitiesMappings = function() {
            $scope.save_activities_grades = [];
            for(var i = 0; i < $scope.activities_grades.length; i++)
            {               
                for(var j = 0; j < $scope.activities_grades[i]['grade_masters'].length; j++)
                {
                    $scope.save_activities_grades.push({
                        subject_master_id: $scope.activities_grades[i]['activity_master_id'],                        
                        id:  $scope.activities_grades[i]['grade_masters'][j]['activity_master_id'], 
                        grade_master_id: $scope.activities_grades[i]['grade_masters'][j]['grade_master_id'], 
                    });                      
                }               
            }

            gradeActivitiesMapService.saveGradeActivitiesMappings($scope.save_activities_grades)
                .then(function(result) {
                    $scope.showGradesMappings();                    
                });            
        };

        $scope.showGradesMappings = function(){        
            gradeActivitiesMapService.getGradeActivities()
                .then(function(result) {
                    $scope.show_grades=result.data; 
                });    
            $scope.editFormValue = false;
            $scope.showFormValue = true;     
        };
        
        $scope.addGrades = function(value,activity_master_id,grade){
            for(var i = 0; i < $scope.activities.length; i++)
            {                
                if ($scope.activities[i]['id'] == activity_master_id)
                {                    
                    if (!value)
                    {                        
                        for(var j = $scope.activities_grades[i]['grade_masters'].length - 1; j >= 0; j--) {
                            if($scope.activities_grades[i]['grade_masters'][j]['grade_master_id'] === grade['grade_master_id']) {
                                $scope.activities_grades[i]['grade_masters'].splice(j, 1);
                            }
                        }
                    } 
                    else
                    {                
                        $scope.activities_grades[i]['grade_masters'].push({
                            id: grade['id'],
                            grade_master_id: grade['grade_master_id']
                        });                       
                    }
                }
            }            
        };

        $scope.addAllGrades = function(value,activity_master_id,grades,activity){
            $scope.activity= activity;    
            for(var i = 0; i < $scope.activities.length; i++){                
                if ($scope.activities[i]['id'] == activity_master_id)
                {                    
                    if (!value)
                    {       
                        $scope.activities_grades[i]['grade_masters'] = [];
                        for(var k = 0; k <grades.length; k++){
                            $scope.activity['grades'][k]['checked_value'] = false;
                        };
                        
                    } 
                    else
                    {    
                        for(var k = 0; k <grades.length; k++){
                            $scope.activities_grades[i]['grade_masters'].push({
                                  id: grades[k]['id'],
                                  grade_master_id: grades[k]['grade_master_id']                                 
                              });
                            $scope.activity['grades'][k]['checked_value'] = true;                             
                        }                          
                    }                     
                }
            }   
        };         
        
        
    }]);       
})(angular, myApp);
