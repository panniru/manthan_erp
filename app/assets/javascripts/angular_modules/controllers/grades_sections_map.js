(function(angular, app) {
    "use strict";
    app.controller('GradesSectionsMappingController',["$scope", "gradeService","gradesSectionsMapService", function($scope, gradeService,gradesSectionsMapService) {
        $scope.grades_sections = [];
       
        gradeService.getGradeServiceView()
            .then(function(result) {
                $scope.grades=result.data
                for(var i = 0; i < $scope.grades.length; i++)
                {
                    $scope.grades_sections.push({
                        grade_master_id: $scope.grades[i]['grade_master_id'],
                        section_masters: [],
                        
                    });
                }
            });
        
        

        $scope.sections = [{id: "",text:'A'},{id:"",text:'B'},{id: "",text:'C'},{id:"",text:'D'}         
           
        ]; 

        $scope.addSections = function(value,grade_master_id,section){
            //alert(JSON.stringify($scope.grades_sections[0]['section_masters']));
            //alert(JSON.stringify($scope.grades_sections));
            //alert(value);
            //alert(grade_master_id);
            //alert(JSON.stringify(section));
            //alert($scope.grades[3]['grade_master_id']);
            //alert(grade_master_id);
            for(var i = 0; i < $scope.grades.length; i++)
            {
                //alert($scope.grades[i]['grade_master_id']);
                if ($scope.grades[i]['grade_master_id'] == grade_master_id)
                {
                    //alert(value);
                    if (!value)
                    {
                        //alert("in false");
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
                        // $scope.grade_sections[i]['b']= 2 
                        
                    }
                }
            }
            //alert(JSON.stringify($scope.grades_sections));

        };

        
        $scope.saveSectionsMappings = function() {
            $scope.save_grades_sections= [];
            //var k=0;
            for(var i = 0; i < $scope.grades_sections.length; i++)
            {
                //alert($scope.grades_sections[i]['section_masters'].length);
                for(var j = 0; j < $scope.grades_sections[i]['section_masters'].length; j++)
                {
                    $scope.save_grades_sections.push({
                        grade_master_id: $scope.grades_sections[i]['grade_master_id'],
                        id:  $scope.grades_sections[i]['section_masters'][j]['id'],
                        section_name:  $scope.grades_sections[i]['section_masters'][j]['section_name']                                  
                    });                    
                    //k++  
                }               
            }
            //alert(k);
            //alert(JSON.stringify($scope.save_grades_sections));
            
            
            gradesSectionsMapService.saveSectionsMappings($scope.save_grades_sections)
                .then(function(result) {
                    
                });  

            showSectionsMappings();
            
        };     




        }]);

    
})(angular, myApp);
 
