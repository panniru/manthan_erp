(function(angular, app) {
    "use strict";
    app.directive('gradeOptionsManager', function(){
        var link =  function(scope,element,attrs){
            
            $(element).on('change', function(event){
                var index = parseInt(attrs.index, 10) ;
                if(attrs.gradeType === "from"){
                    if(scope.isValidFromOption(index)){
                        scope.gradeChangeActionFrom(index)
                        scope.$apply();
                        $(element).popover('destroy');
                    }else{
                        errorPopOver(element, "Invalid")
                    }
                }else{
                    if(scope.isValidToOption(index)){
                        scope.gradeChangeActionTo(index)
                        scope.$apply();
                        $(element).popover('destroy');
                    }else{
                        errorPopOver(element, "Invalid")
                    }
                }
                
                //console.log(JSON.stringify(scope.grades))
            });
        };

        var errorPopOver = function(element, data){
            $(element).popover({
                html: true,
                content: data, 
                placement: "left"
            })
        }
        
        return{
            link: link
        };
    });
})(angular, myApp);
