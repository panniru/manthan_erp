(function(angular, app) {
    "use strict";
    app.controller('ResultsController',["$scope", "resultsService",function($scope,resultsService) {

        $scope.goToEdit = function(){
            //$scope.attendances = attendances
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        }

        $scope.getTeacherMappings = function(selected_user) {
            
            resultsService.getBothValue(selected_user)
                .then(function(result) {
                    $scope.final_values = result.data;
                    $scope.save_result_details = [];
                    for(var i=0; i<result.data.length; i++){
                        $scope.save_result_details.push({
                            student_master_id: null,
                            grade_master_id: null,
                            assessment_type_id: null,
                            no_of_times: null,
                            scored_marks: null,
                            assessment_grade_mapping_id: null,
                            id: null,
                        });
                    }
                });
        }


        // resultsService.getResultsServiceView()
        //     .then(function(result) {
        //         $scope.finals = result.data;
                
        //     });


        $scope.saveTodayResult = function(){
      
            for(var i=0; i<$scope.save_result_details.length; i++){
                $scope.save_result_details[i]['id'] = $scope.finals[i]['id'];
                $scope.save_result_details[i]['grade_master_id'] = $scope.finals[i]['grade_master_id'];
                $scope.save_result_details[i]['student_master_id'] = $scope.finals[i]['student_master_id'];
                $scope.save_result_details[i]['assessment_type_id'] = $scope.finals[i]['assessment_type_id'];
                $scope.save_result_details[i]['no_of_times'] = $scope.finals[i]['no_of_times']; 
                $scope.save_result_details[i]['scored_marks'] = $scope.finals[i]['scored_marks'];
                $scope.save_result_details[i]['assessment_grade_mapping_id'] = $scope.finals[i]['assessment_grade_mapping_id'];
            }
      
            resultsService.saveTodayResult($scope.save_result_details)
                .then(function(result) {
                    for(var i=0; i<$scope.save_result_details.length; i++){
                        $scope.myShowFormValue = true;
                        $scope.myEditFormValue = false;
                    }
                });
        };
        














        $scope.employee_amount = function(f){
            resultsService.getGradingDefaults(f)
                .then(function(result) {
                    $scope.grading_defaults= result.data;
                    
                });
        }

        // $scope.employee_amount = function(object){
        //     alert(JSON.stringify(object.marks_scored));
        // };
      
     
        resultsService.getGrades()
            .then(function(result) {
                $scope.klasses = result.data
            });


        $scope.getDetails = function(klass){
            resultsService.getAllResults(klass)
                .then(function(result) {
                    $scope.group_students = result.data;
                });
        }


        resultsService.getGradeAssessmentMapping()
            .then(function(result) {
                $scope.unAssignedUsers = result.data;
                $scope.selectedUser =  $scope.unAssignedUsers[0];
                
                $scope.combined = function(user){
                    if(user.grade_name == undefined || user.grade_name == ''){
                        return user.assessment_type;
                    }
                    else {
                        return user.grade_name + "-" + user.assessment_type;
                    }
                }
            });

       

    }]);
})(angular, myApp);
