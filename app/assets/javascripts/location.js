
$(document).ready(function(){
    initialize();
    var placeSearch, autocomplete;
    var component_form = {
	'txtPickupUnitNumber': 'subpremise',
	'txtPickupStreetNumber': 'street_number',
	'txtPickupStreetName': 'route',
	'txtPickupSuburb': 'locality',
	'txtPickupPC': 'postal_code',
	'txtPickupState': 'administrative_area_level_1',
	'txtPickupCountry': 'country'
    };
    
    function initialize() {
	autocomplete = new google.maps.places.Autocomplete(document.getElementById('autocomplete'), {
	    types: ['geocode']
	});
	google.maps.event.addListener(autocomplete, 'place_changed', function () {
	    fillInAddress();
	});
	
	$('table td input').attr('disabled', true);
	
    }
    
    function fillInAddress() {
	var place = autocomplete.getPlace();
	
	for (var component in component_form) {
	    document.getElementById(component).value = "";
	    document.getElementById(component).disabled = false;
	}
	
	for (var j = 0; j < place.address_components.length; j++) {
	    var att = place.address_components[j].types[0];
	    fillFormInput(att, place.address_components[j].long_name);
	}
    }
    
    function fillFormInput(att, val) {
	for (var c in component_form) {
	    if (component_form[c] === att) {
		$('#'+c).val(val);
	    }
	}
    }
    
})
 
