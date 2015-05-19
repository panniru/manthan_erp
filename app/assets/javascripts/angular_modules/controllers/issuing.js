(function(angular, app) {
    "use strict";
    app.controller("IssuingsController",["$scope", "issuingService", function($scope,  issuingService) {
      
        $scope.map_grades = []
        issuingService.getGradeServiceView()
            .then(function(result) {                
                $scope.grades = result.data;                
            });        
        $scope.map_sections = [];
        
        $scope.getGradeSections = function(){      
            issuingService.getGradeSectionServiceView($scope.myGrade)
                .then(function(result) {                
                    $scope.sections = result.data;
                   
                });
        };

        $scope.getValues = function(selected_user) {
            alert(selected_user)
            issuingService.getValue(selected_user)
                .then(function(result) {
                    
                    $scope.values = result.data;
                    alert(JSON.stringify($scope.values))
                    $scope.keys = Object.keys($scope.values[0])
                });
        };


        issuingService.getMappings()
            .then(function(result) {
                $scope.unAssignedUsers = result.data;
                
                $scope.selectedUser =  $scope.unAssignedUsers[0];
                
                $scope.combined = function(user){
                    if(user.grade_name == undefined || user.grade_name == ''){
                        return user.section_name;
                    }
                    else {
                        return user.grade_name + "-" + user.section_name;
                    }
                }
            });


	$scope.saveValues = function(student_id,id,grade_master_id,section_master_id,date){
            $scope.save_all  = [];
            $scope.save_all.push({ 
                id: "",
                
                student_id: student_id,
                book_id: $("#id").val(),
                grade_master_id: grade_master_id,
                section_master_id: section_master_id,
                book_retun_date: date
	    });
	    
	    issuingService.save_values(student_id,$("#id").val(),grade_master_id,section_master_id,date)
		.then(function(result) {
                    window.location.reload();
                  
                  
                    
                });
	};

	// $scope.updateValues = function(student_master_id,id,book_issue){
        //     alert(' ')
        //     $scope.save_all  = [];
        //     $scope.save_all.push({ 
                // id: "",
                // student_master_id: student_master_id,
                // book_id: $("#id").val(),
   	  //   });
        //     issuingService.updateValues()
	// 	.then(function(result) {
        //             alert('testing')
        //         });
	// };                   

	$scope.updateValues = function(issuing_id) {
            alert(issuing_id)
            issuingService.update_values(issuing_id)
                .then(function(result) {
                    $scope.update_values = result.data;
                    window.location.reload();
                    
                });
        };

      
        
       
	    
        issuingService.get_issuings()
            .then(function(result) {                
                $scope.issuings = result.data;
            });


        $scope.returnMappings = function() {
            alert('return')
            $scope.myEditFormValue = "false";
            $scope.myShowFormValue = "true";
        };

    }]);    
})(angular, myApp);        

