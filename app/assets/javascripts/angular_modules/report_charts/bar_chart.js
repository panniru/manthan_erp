
(function(angular, app) {
    "use strict";
    app.service("barChart",["$http", function($http) {
        
        var options = {
            series: {
		bars: {
		    show: true
		}
	    },
	    bars: {
		
		shadowSize: 1,
		align: "center",
		barWidth: 0.25,
		border: "#9F8AD5",
		fillColor: "#9F8AD5"
	    },
	    grid:{
                backgroundColor: { colors: ["#C2C2D6", "#F3F3F7"] }
            },
	   
	    xaxis: {
		
		axisLabel: "Bus No",
		axisLabelUseCanvas: false,
		axisLabelFontSizePixels: 15,
		axisLabelFontFamily: 'Verdana, Arial',
		axisLabelPadding: 3 
		
	    },
	    
	    yaxis: {
		axisLabel: "Capacity",
		axisLabelUseCanvas: true,
		axisLabelFontSizePixels: 15,
		axisLabelFontFamily: 'Verdana, Arial',
		axisLabelPadding: 3
	    }
        }
	var xaxisLabel = $(".axisLabel.xaxisLabel").text("My X Label").appendTo($('#placeholder'));
   
	var barChart = function(target, data){
            $.plot($("#"+target), data, options);  
        };
        
   	return {
	    barChart : barChart
	};
	
    }]);
})(angular, myApp);
