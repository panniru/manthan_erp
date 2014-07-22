(function(angular, app) {
    "use strict";
    app.controller("HRMTeachingPlansController",["$scope", "teachingPlanService", function($scope, teachingPlanService) {
        $scope.teaching_plans = []
        $scope.getPlans = function(student_id, date){
            $scope.studentId = student_id
            teachingPlanService.student_teaching_plans(student_id, date).then(function(response) {
                $scope.teaching_plans = response.data
                $scope.month_dates = $.map(response.data, function(value, key){
                    return key
                });
                $scope.subjects_data = $scope.teaching_plans[$scope.month_dates[0]]
            });
        }
        
        $scope.reflectContent = function(date_obj){
            $scope.getPlans($scope.studentId, $.datepicker.formatDate('yy-mm-dd', date_obj));
        }
        
    }]);
    
})(angular, myApp);
