$(function() {
    $(".change ").on("click", function(event) {	
	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("label-danger").addClass("label-success");  
	this_klass.text('Approved');
	$.ajax({
	    url: "/fee_structure_approvals/"+id+".json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		this_klass.removeClass("label-danger").addClass("label-success");        	
		if ("status==Approved")
		{this_klass.text('Approved');}
	    }
	    
	});
    
    });
    $(".send ").on("click", function(event) {
	$.ajax({
	    url: "/fee_structure_approvals.json",
	    type: 'POST',
	    data: "status=success",
	    success: function(data) {
		
	    }
	});
    });
 })
