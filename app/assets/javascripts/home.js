
$(document ).ready(function() {
  $("#map").height(gon.height)
  $("#map").width(gon.width)
  $("#map-container").width(gon.width)
  handler = Gmaps.build('Google')
  handler.buildMap({ provider: {}, internal: {id: 'map'} }, function(){
      alert(gon.gmap_data)
  markers = handler.addMarkers(jQuery.parseJSON(gon.gmap_data))
  handler.bounds.extendWith(markers)
  handler.fitMapToBounds()
  addHoverHandlers(markers)
  })
  



    $('body').on('focus',".datepicker", function(){
        $(this).datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            dateFormat: 'dd/mm/yy'
        });
    });
});
