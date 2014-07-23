(function(angular, app) {
    "use strict";
    app.controller('GradesSectionsMappingController',["$scope", "gradeService","gradesSectionsMapService","sectionService", function($scope, gradeService,gradesSectionsMapService,sectionService) {  
        $scope.myShowFormValue = "true";
        $scope.FormValue = "false";
       
        sectionService.getSectionServiceView()
            .then(function(result) {
                $scope.show_sections=result.data;                
            });      
       
        
        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data;               
            });

        $scope.defaultGradesSectionsAll= function(){            
                $scope.grades_sections_all = [];         
            
                for(var i = 0; i < $scope.grades.length; i++)
            {
                $scope.grades_sections_all.push({
                    grade_master_id: $scope.grades[i]['grade_master_id'],
                    grade_name: $scope.grades[i]['grade_name'],
                    sections: [{id: "",text:'A',checked_value:""},{id:"",text:'B',checked_value:""},{id:"",text:'C',checked_value:""},{id: "",text:'D',checked_value:""},{id:"",text:'E',checked_value:""},{id:"",text:'F',checked_value:""},{id: "",text:'G',checked_value:""},{id:"",text:'H',checked_value:""},{id:"",text:'I',checked_value:""},{id: "",text:'J',checked_value:""},{id:"",text:'K',checked_value:""},{id:"",text:'L',checked_value:""},{id: "",text:'M',checked_value:""},{id:"",text:'N',checked_value:""},{id:"",text:'O',checked_value:""},{id: "",text:'P',checked_value:""},{id:"",text:'Q',checked_value:""},{id:"",text:'R',checked_value:""},{id: "",text:'S',checked_value:""},{id:"",text:'T',checked_value:""},{id:"",text:'U',checked_value:""},{id: "",text:'V',checked_value:""},{id:"",text:'W',checked_value:""},{id:"",text:'X',checked_value:""},{id:"",text:'Y',checked_value:""},{id:"",text:'Z',checked_value:""}],
                    
                });
            } 
        };

        $scope.defaultGadesSections = function(){     
            $scope.grades_sections = [];

            for(var i = 0; i < $scope.grades.length; i++)
            {
                $scope.grades_sections.push({
                    grade_master_id: $scope.grades[i]['grade_master_id'],
                    section_masters: [],
                    
                });
            }
        };      
        
        $scope.addSections = function(value,grade_master_id,section){
            for(var i = 0; i < $scope.grades.length; i++)
            {                
                if ($scope.grades[i]['grade_master_id'] == grade_master_id)
                {                    
                    if (!value)
                    {                        
                        for(var j = $scope.grades_sections[i]['section_masters'].length - 1; j >= 0; j--) {
                            if($scope.grades_sections[i]['section_masters'][j]['section_name'] === section['text']) {
                                $scope.grades_sections[i]['section_masters'].splice(j, 1);
                            }
                        }
                    } 
                    else
                    {                         
                        $scope.grades_sections[i]['section_masters'].push({
                            id: section['id'],
                            section_name: section['text']
                        });                       
                    }
                }
            }
        };
        
        $scope.saveSectionsMappings = function() {
            $scope.save_grades_sections= [];
            for(var i = 0; i < $scope.grades_sections.length; i++)
            {               
                for(var j = 0; j < $scope.grades_sections[i]['section_masters'].length; j++)
                {
                    $scope.save_grades_sections.push({
                        grade_master_id: $scope.grades_sections[i]['grade_master_id'],
                        id:  $scope.grades_sections[i]['section_masters'][j]['id'],
                        section_name:  $scope.grades_sections[i]['section_masters'][j]['section_name']                                  
                    });                      
                }               
            }
 
            gradesSectionsMapService.saveSectionsMappings($scope.save_grades_sections)
                .then(function(result) {
                    
                }); 
            
            $scope.showSectionsMappings();
        };

        $scope.showSectionsMappings = function(){            
            $scope.myFormValue = "false";
            $scope.myShowFormValue = "true"; 
                       
            sectionService.getSectionServiceView()
                .then(function(result) {
                    $scope.show_sections = result.data;              
                });            
        };

        $scope. createSectionsMappings = function() {           
            $scope.defaultGadesSections();
            
            for ( var i = 0; i < $scope.grades.length; i++ ){         
                for ( var j = 0; j < $scope.show_sections.length; j++ ) {                   
                    if  ($scope.grades[i]['grade_master_id'] == $scope.show_sections[j]['grade_master_id'] )
                    {                 
                        
                        $scope.grades_sections[i]['section_masters'].push({  
                            
                            id : $scope.show_sections[j]['section_master_id'],
                            section_name : $scope.show_sections[j]['section_name'],
                        });                                         
                    }
                }                
            }              
        };        
        
        $scope. editSectionsMappings = function() {         
            $scope.defaultGradesSectionsAll();
            $scope.myShowFormValue = "false";
            $scope.myFormValue = "true";
            
            for ( var i = 0; i < $scope.grades.length; i++ ){         
                for ( var j = 0; j < $scope.show_sections.length; j++ ) {                   
                    if  ($scope.grades[i]['grade_master_id'] == $scope.show_sections[j]['grade_master_id'] )
                    {
                        for ( var k = 0; k < $scope.grades_sections_all[i]['sections'].length; k++ ) {
                            
                            if  ($scope.grades_sections_all[i]['sections'][k]['text'] == $scope.show_sections[j]['section_name'] )
                            {
                                $scope.grades_sections_all[i]['sections'][k]['id'] = $scope.show_sections[j]['section_master_id']; 
                                $scope.grades_sections_all[i]['sections'][k]['checked_value'] = true;                              
                            }    
                            
                        }
                        
                    }
                }
            }
            $scope.createSectionsMappings();
        };
        
        
        
    }]);
    
    
})(angular, myApp);

