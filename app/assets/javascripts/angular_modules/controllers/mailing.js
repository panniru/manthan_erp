(function(angular, app) {
    "use strict";
    app.controller("MailingController",["$scope", "mailService", function($scope, mailService) {
        $scope.isMailActionFired = false
        
        $scope.feeStructureMail = function(){
            $scope.isMailActionFired = true
            mailService.feeStructureMail()
            .then(function(responce){
                var alert_msg = '<div class="alert alert-success alert-dismissable">'+
                    '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
                    responce.data+'</div>'
                $("#appAlert").html(alert_msg)
            });
            
        };

        $scope.termResultsMail = function(myMailSubject,myMailMessage){           
            $scope.isMailActionFired = true
            mailService.termResultsMail(myMailSubject,myMailMessage)
            .then(function(responce){
                var alert_msg = '<div class="alert alert-success alert-dismissable">'+
                    '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
                    responce.data+'</div>'
                $("#appAlert").html(alert_msg)
            });  
            $('#mailSubjectModal').modal('hide'); 
        };

         $scope.requestBooksMail = function(myMailSubject,myMailMessage,myRequestBooks){           
            $scope.isMailActionFired = true            
            mailService.requestBooksMail(myMailSubject,myMailMessage,myRequestBooks)
            .then(function(responce){
                var alert_msg = '<div class="alert alert-success alert-dismissable">'+
                    '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
                    responce.data+'</div>'
                $("#appAlert").html(alert_msg)
            });  
            $('#mailSubjectModal').modal('hide'); 
            alert("Mail Sent To Books Vendor Successful");
        };
        
    }]);
    
})(angular, myApp);


