$(function() {
    $(".approve ").on("click", function(event) {	
	id = $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("label-danger").addClass("label-success");
	this_klass.text('Approved');
	$.ajax({
	    url: "/inventories/"+id+".json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		this_klass.removeClass("label-danger").addClass("label-success");
		if ("status==Approved")
		{this_klass.text('Approved');}
	    }
	});
    });

    $(".order ").on("click", function(event) {
	id = $(this).data("id");
	this_klass = $(this)
	this_klass.text('Order Placed');
	$.ajax({
	    url: "/inventories/"+id+"/order_placed.json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		
		//if ("status==Approved")
		//{this_klass.text('Approved');}
	    }
	});
    });

    $(".reject ").on("click", function(event) {	
	id = $(this).data("id");
	this_klass = $(this)
	this_klass.text('Rejected');
	$.ajax({
	    url: "/inventories/"+id+"/rejected.json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		this_klass.removeClass("label-danger").addClass("label-success");
	    }
	});
    });
    

    $(".delivered ").on("click", function(event) {	
	id = $(this).data("id");
	this_klass = $(this)
	this_klass.text('Delivered');
	$.ajax({
	    url: "/inventories/"+id+"/delivered.json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		this_klass.removeClass("label-danger").addClass("label-success");
	    }
	});
    });
    
    $(".undo ").on("click", function(event) {	
	id = $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("label-warning").addClass("label-success");
	this_klass.text('Undo');
	$.ajax({
	    url: "/inventories/"+id+"/refresh.json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		window.location.reload();
				     
		this_klass.removeClass("label-warning").addClass("label-success");
	    }
	});
    });
    



    $(".send ").on("click", function(event) {
	$.ajax({
	    url: "/inventories.json",
	    type: 'POST',
	    data: "status=success",
	    success: function(data) {
	    }
	});
    });
})
