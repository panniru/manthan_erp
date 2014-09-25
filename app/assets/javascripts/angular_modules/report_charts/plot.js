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
		timeformat: "%d/%m/%Y ",
		show: true,
		position: "bottom",
		//color:  "#CC6699",
		//tickColor:  "#CC6699",
		labelWidth: 10,
		labelHeight: 10,
		axisLabel: 'Date', 
		axisLabelUseCanvas: true,
		axisLabelFontSizePixels: 12,
		axisLabelFontFamily: 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
		axisLabelPadding: 5
            },
            yaxis: {
		show: true,
		axisLabel: 'Wastage (Kgs)',
		axisLabelUseCanvas: true,
		axisLabelFontSizePixels: 12,
		axisLabelFontFamily: 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
		axisLabelPadding: 5
	    }
	}
    
       
   
	var plotChart = function(target,data){
	    var data1 = [[
                [1301634000000, 315.71], //Apr 1, 2011
                [1302238800000, 209.21], //Apr 8, 2011
                [1302843600000, 420.36], //Apr 15
                [1303448400000, 189.86], //4/22
                [1304053200000, 314.93], //4/29
                [1304658000000, 279.71], //5/6
                [1305262800000, 313.34], //5/13
                [1305867600000, 114.67], //5/20
                [1306472400000, 315.58]  //5/27
           ]]; 
	    //)alert(data)
	    // var data1 = [ [
	    // 	[new Date("2007/05/19"), 19],
	    // 	[new Date("2006/05/13"), 4],
	    // 	[new Date("2006/03/19"), 9],
	    // 	[new Date("2005/05/07"), 1],
	    // 	[new Date("2005/03/20"), 3],
	    // 	[new Date("2004/10/16"), 15],
	    // 	[new Date("2004/03/21"), 2],
	    // 	[new Date("2003/10/18"), 19],
	    // 	[new Date("2003/03/16"), 2],
	    // 	[new Date("2002/03/17"), 5],
	    // 	[new Date("2001/09/22"), 2],
	    // 	[new Date("2001/03/18"), 1],
	    // ] ]
	    // function convertToDate(data) {
	    // 	var newDate = new Date(data.current_date);
	    // 	return data;
	    // }
            $.plot($("#"+target), data1 , options);
	};
        
        return {
            plotChart : plotChart
        };
        
    }]);
})(angular, myApp);
