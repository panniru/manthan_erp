(function(angular, app) {
    "use strict";
    app.controller('SetupMasterController',["$scope","resourceService","setupmasterService", function($scope, resourceService, setupmasterService) {
        
      

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


        $scope.goToEdit = function(){
            $scope.myShowFormValue = false;
            $scope.myEditFormValue = true;
        }

        var timeString = "12:00:00";
        var H = +timeString.substr(0, 2);
        var h = (H % 24) || 24;
        var ampm = H < 12 ? "AM" : "PM";
        timeString = h + timeString.substr(2, 3) + ampm;
      
        var timeString1 = new Date().toTimeString();
        var H1 = +timeString1.substr(0, 2);
        var h1 = (H1 % 24) || 24;
        var ampm1 = H1 < 12 ? "AM" : "PM";
        timeString1 = h1 + timeString1.substr(2, 3) + ampm1;
        
        alert(timeString)
        alert(timeString1)
        
      

        $scope.getUpdate = function(designation){
            window.drawAttendance(designation)
            setupmasterService.getMonth(designation)
                .then(function(result) {
                    if (timeString < timeString1)
                    {
                        $scope.myShowFormValue = true;
                        $scope.myEditFormValue = false;
                        $scope.faculty_masters = result.data;
                    }
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
            alert(JSON.stringify(facultys))
            $scope.$apply();
            $scope.save_today_attendence = [];
            for(var i=0; i<facultys.length; i++){
                $scope.save_today_attendence.push({
                    forenoon: null,
                    attendance_date: null,
                    name: null,
                    designation: null,
                    faculty_master_id: null,
                });
            }
        }
        
        setupmasterService.getAttendanceServiceView()
            .then(function(result) {
                $scope.faculty_masters = result.data;
            });


        $scope.saveTodayAttendance = function(){
            for(var i=0; i < $scope.save_today_attendence.length; i++){
                $scope.save_today_attendence[i]['designation'] = $scope.faculty_masters[i]['designation'];
                $scope.save_today_attendence[i]['forenoon'] = $scope.faculty_masters[i]['forenoon'];
                $scope.save_today_attendence[i]['attendance_date'] = $scope.faculty_masters[i]['attendance_date']; 
                $scope.save_today_attendence[i]['name'] = $scope.faculty_masters[i]['name'];
                $scope.save_today_attendence[i]['faculty_master_id'] = $scope.faculty_masters[i]['faculty_master_id'];
            }
            alert(JSON.stringify($scope.save_today_attendence))
            setupmasterService.saveTodayAttendance($scope.save_today_attendence)
                .then(function(result) {
                    $scope.myShowFormValue = true;
                    $scope.myEditFormValue = false;
                });
        }; 
        
       

    }]);
})(angular, myApp);
