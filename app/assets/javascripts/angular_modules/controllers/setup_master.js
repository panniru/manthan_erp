(function(angular, app) {
    "use strict";
    app.controller('SetupMasterController',["$scope","resourceService","setupmasterService", function($scope, resourceService, setupmasterService) {
        
        $scope.myShowFormValue = true;
        $scope.myEditFormValue = false;


        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        }

        //-----------------------------Setup Master

        $scope.masters = resourceService.SetupMaster.query();

        $scope.edit = function(master){
            $scope.master = master
            $('#edit').modal('show');
        }

        $scope.setupupdate = function(){
            $scope.master.$update()
            .then(function(response){
            })
            $('#edit').modal('hide');
            $scope.masters = resourceService.SetupMaster.query();
            window.location.reload();
        };
        //-----------------------------------------


        setupmasterService.getDesignation()
            .then(function(result) {
                $scope.designations = result.data;
            });
        
        setupmasterService.getFaculty()
            .then(function(result) {
                $scope.faculties = result.data;
             
            });
    
        $scope.getUpdate = function(designation){
            window.drawAttendance(designation)
            setupmasterService.getMonth(designation)
                .then(function(result) {
                    $scope.faculty_masters = result.data;
                });
        }
        
        $scope.todayAttendence = function(date){
            var date = new Date();
            $scope.date = (date.getFullYear() + "-" + (date.getMonth()+1) +"-"+date.getDate()); 
            $scope.faculty_masters = $scope.faculty_masters;
            $scope.$apply();
        }
        
        $scope.reflectStaffs = function(facultys){
            $scope.faculty_masters = facultys;
            $scope.$apply();
        }
        
        setupmasterService.getAttendanceServiceView()
            .then(function(result) {
                $scope.faculty_masters = result.data;
                $scope.save_today_attendence = [];
                for(var i=0; i<result.data.length; i++){
                    $scope.save_today_attendence.push({
                        forenoon: null,
                        attendance_date: null,
                        name: null,
                        designation: null,
                        id: null,
                        
                    });
                }
                
            });
        $scope.saveTodayAttendance = function(){
  

            for(var i=0; i < $scope.save_today_attendence.length; i++){
                $scope.save_today_attendence[i]['designation'] = $scope.faculty_masters[i]['designation'];
                $scope.save_today_attendence[i]['forenoon'] = $scope.faculty_masters[i]['forenoon'];
                $scope.save_today_attendence[i]['attendance_date'] = $scope.faculty_masters[i]['attendance_date']; 
                $scope.save_today_attendence[i]['name'] = $scope.faculty_masters[i]['name'];
                $scope.save_today_attendence[i]['id'] = $scope.faculty_masters[i]['id'];
            }
            
            setupmasterService.saveTodayAttendance($scope.save_today_attendence)
                .then(function(result) {
                    $scope.myShowFormValue = true;
                    $scope.myEditFormValue = false;
                    
                });
        }; 
        
       

    }]);
})(angular, myApp);
