(function(angular, app) {
    "use strict";
    app.directive("myPagination", function() {
	return {
	    restrict: 'E',
	    scope: {
		from: '=',
		to: '=',
		total: '=',
                currentPage: '=',
		action: '&'
	    },
	    controller: ["$scope", function($scope){
		$scope.currentPage = 1;
		$scope.previousPage = function(){
		    $scope.currentPage -= 1
		    $scope.action({page: $scope.currentPage})
		}
		$scope.nextPage = function(){
		    $scope.currentPage += 1
		    $scope.action({page: $scope.currentPage})
		}
	    }],
	    templateUrl: "paginationElements.html"
	}
    });
})(angular, myApp);

   
