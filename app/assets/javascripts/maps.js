$(document ).ready(function() {
    handler = Gmaps.build('Google');
    handler.buildMap({
	provider: {
	    disableDefaultUI: true
	    // pass in other Google Maps API options here
	},
	internal: {
	    id: 'map'
	}
    },
		     function(){
			 markers = handler.addMarkers([
			     {
				 "lat":  17.385044 ,
				 "lng":  78.486671,
				 "picture": {
				     "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
				     "width":  36,
				     "height": 36
				 },
				 "infowindow": "hyderabad"
			     }
			 ]);
			 handler.bounds.extendWith(markers);
			 handler.fitMapToBounds();
		     }
		    );
});    
