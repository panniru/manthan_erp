//import    "http://maps.google.com/maps/api/js?sensor=true"
var directionsDisplay = new google.maps.DirectionsRenderer();
var directionsService = new google.maps.DirectionsService();
function calcRoute() {
    var origin = new google.maps.LatLng(gon.start_point_latitude , gon.start_point_longitude);
    var destination = new google.maps.LatLng(gon.end_point_latitude , gon.end_point_longitude);
    //alert(gon.waypts)
    var waypts = JSON.parse(gon.waypts);
    var request = {
	origin: origin,
	destination: destination,
	waypoints: waypts,
	optimizeWaypoints: true,
	travelMode: google.maps.TravelMode.DRIVING
    };
    directionsService.route(request, function(response, status) {
	if (status == google.maps.DirectionsStatus.OK) {
	    directionsDisplay.setDirections(response);
	}
    });
}
$(document).ready(function(){
  $("#map").height(gon.height)
    $("#map").width(gon.width)
    $("#map-container").width(gon.width)
    calcRoute();
    var handler = Gmaps.build('Google');
    handler.buildMap({ internal: {id: 'map'}}, function(){
	directionsDisplay.setMap(handler.getMap());
    });
});
