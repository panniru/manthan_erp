(function(angular, app) {
    "use strict";
    app.controller('CommunicationMailsController',["$scope","resourceService", "$rootScope", function($scope, resourceService, $rootScope) {
        $scope.FILTERS = [
            {name: 'Inbox', code: 'inbox'},
            {name: 'Sent', code: 'sent'}
        ]
        $scope.filter_by = $scope.FILTERS[0]

        $scope.newMail = function(){
            $scope.cummunicationMail = resourceService.CommunicationMail.newMail();
        }

         $scope.reflectRoleChange = function(){
             $scope.canShowGradeSection = false;
            angular.forEach($scope.cummunicationMail.roles, function(data){
                if((data.code === 'Parent' || data.code === 'Teacher') && data.selected){
                    $scope.canShowGradeSection = true;
                    return true;
                }
            })
        }

        $scope.$on('gradeMaster', function(event, data) {  $scope.cummunicationMail.grade_master_id = data;});
        $scope.$on('sectionMaster', function(event, data) { $scope.cummunicationMail.section_master_id = data;s});

        $scope.sendMail = function(){
            $scope.cummunicationMail.to = $("#to_user").val()
            console.log($scope.cummunicationMail)
            resourceService.CommunicationMail.sendMail({communication_mail_form_object: $scope.cummunicationMail});
        }

        $scope.fetchMails = function(page){
            resourceService.CommunicationMail.query({filter_by: $scope.filter_by.code, page:page}, function(data){
                $scope.mails = data.mail_details;
                $scope.total_entries = data.total_entries;
                $scope.current_page = parseInt(data.current_page)
                $scope.to_index = data.to_index 
                $scope.from_index = data.from_index
            }) 
        }

        $scope.showMail = function(mail){
            resourceService.CommunicationMail.mailDetail({id: mail.id}, function(response){
                $scope.markAsRead(mail)
                $scope.mail_details = response.message_details
                $scope.replyMail = {from: $scope.mail_details[$scope.mail_details.length-1].to, to: $scope.mail_details[$scope.mail_details.length-1].from, content: null, parent_mail_id: $scope.mail_details[$scope.mail_details.length-1].id}
                $("#showMail").modal({backdrop: 'static'})
            });
        }

        $scope.reply = function(){
            resourceService.CommunicationMail.reply({id: $scope.replyMail.parent_mail_id, reply_mail: $scope.replyMail}, function(data){
                $("#showMail").modal('hide')
            })
        }

        $scope.markAsRead = function(mail){
            $rootScope.$broadcast('fireUserUnreadMails', "getUnread")
            if(!mail.red){
                resourceService.CommunicationMail.markAsRead({id: mail.id}, function(data){
                    mail.red = true
                    
                })
            }
        }

        
    }]);
})(angular, myApp);
