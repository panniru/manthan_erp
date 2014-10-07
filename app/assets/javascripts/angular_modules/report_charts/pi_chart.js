// var dataSet = [
//     {label: "Asia", data: 4119630000, color: "#005CDE" },
//     { label: "Latin America", data: 590950000, color: "#00A36A" },
//     { label: "Africa", data: 1012960000, color: "#7D0096" },
//     { label: "Oceania", data: 35100000, color: "#992B00" },
//     { label: "Europe", data: 727080000, color: "#DE000F" },
//     { label: "North America", data: 344120000, color: "#ED7B00" }   
// ];



(function(angular, app) {
    "use strict";
    app.service("piChart",["$http", function($http) {
        
        var drawChart = function(target, data){
            $.plot($("#"+target), data, options());  
        };
        

        
        var options = function(){
            var chart_options = {
                    series: {
                        pie: {
                            show: true,               
                            label: {
                                show:true,
                                radius: 0.8,
                                formatter: function (label, series) {               
                                    return '<div style="border:1px solid grey;font-size:8pt;text-align:center;padding:5px;color:white;">' +
                                        label + ' : ' +
                                        Math.round(series.percent) +
                                        '%</div>';
                                },
                                background: {
                                    opacity: 0.8,
                                    color: '#000'
                                }
                            }
                        }
                    },
                grid: {
                    hoverable: true,
                    clickable: true
                }
            };
            return chart_options;
        };
        
        return {
            drawChart : drawChart
        };
        
    }]);
})(angular, myApp);
