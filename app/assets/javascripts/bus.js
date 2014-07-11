$(function() {
    $(".form ").on("click", function(event) {	
	id =  $(this).data("id");
	this_klass = $(this)
	$.ajax({
	    url: "/new_vehicles/"+id+"/.json",
	    type: 'DELETE',
	    data: "status=success",
	    success: function(data) {
	
	
	    }
	    
	});
    
    });
})
