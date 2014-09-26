(function(angular, app) {
    "use strict";
    app.service("plot",["$http", function($http) {
        
        
	var options = {
           
	    legend: {
		show: true,
		margin: 10,
		backgroundOpacity: 0.5
            },
            series: {
		lines: { show: true },
		points: {
                    radius: 3,
                    show: true,
                    fill: true
		},
            },
	    grid: {
                hoverable: true,
                borderWidth: 4,
                borderColor: "#CC6699"

            },
	   
	    xaxis: {
		mode: "time",
		timeformat: "%d/%m ",
		show: true,
		position: "bottom",
		//color:  "#CC6699",
		//tickColor:  "#CC6699",
		labelWidth: 10,
		labelHeight: 10,
		axisLabel: "Date", 
		axisLabelUseCanvas: true,
		axisLabelFontSizePixels: 12,
		axisLabelFontFamily: 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
		axisLabelPadding: 5
            },
            yaxis: {
		show: true,
		xaxisLabel: "Wastage (Kgs)",
		axisLabelUseCanvas: true,
		axisLabelFontSizePixels: 12,
		axisLabelFontFamily: 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
		axisLabelPadding: 5
	    }
	    
	}
    
	var xaxisLabel = $(".axisLabel.xaxisLabel").text("My X Label").appendTo($('#placeholder'));
   
	var plotChart = function(target,data){
	    $.plot($("#"+target), data , options);
	};
        
        return {
            plotChart : plotChart
        };
        
    }]);
})(angular, myApp);
