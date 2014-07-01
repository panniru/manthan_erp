$(function() {
    $(".change ").on("click", function(event) {	
        
	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("label-danger").addClass("label-success");  
	this_klass.text('Form Closed');
	$.ajax({
        
	    url: "/admissions/"+id+"/update_admission.json",
	    type: 'PUT',
	    data: "status=success",
	    success: function(data) {
		this_klass.removeClass("label-danger").addClass("label-success");        	
		if (status == "Form Closed")
		{this_klass.text('Form Closed');}
	    }
            
	});
        
    });
  
})
