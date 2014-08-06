$(function() {
    $(".change ").on("click", function(event) {	
        if($.cookie('msg') != null && $.cookie('msg') != "")
        {
            $("div#mypopModal.modal, .modal-backdrop").hide();
        } 
        else
        {
            $('#mypopModal').modal('show');
            $.cookie('msg', 'str');
        }
	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("btn-danger").addClass("btn-success");   	this_klass.text('Form Closed');
        
	$.ajax({
            
	    url: "/admissions/"+id+"/update_admission.json",
	    type: 'PUT',
	    data: "status=success",
	    success:function(data) {
	      	alert("");
		if (status == "Form Closed")
		{
                    alert("");
                    this_klass.text('Form Closed');
                    
                }
	    }
            
	});
        
    });
    
})
   
$(function() {
    $(".change1 ").on("click", function(event) {	
        if($.cookie('msg') != null && $.cookie('msg') != "")
        {
            $("div#mypopModal.modal, .modal-backdrop").hide();
        } 
        else
        {
            $('#mypopModal').modal('show');
            $.cookie('msg', 'str');
        }
	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("btn-danger").addClass("btn-success");   	this_klass.text('Form Closed');
        
	$.ajax({
            
	    url: "/staff_admissions/"+id+"/update_admission.json",
	    type: 'PUT',
	    data: "status=success",
	    success:function(data) {
	      	alert("");
		if (status == "Form Closed")
		{
                    alert("");
                    this_klass.text('Form Closed');
                    
                }
	    }
            
	});
        
    });
    
})


$(function() {
    $(".change2 ").on("click", function(event) {	
        if($.cookie('msg') != null && $.cookie('msg') != "")
        {
            $("div#mypopModal.modal, .modal-backdrop").hide();
        } 
        else
        {
            $('#mypopModal').modal('show');
            $.cookie('msg', 'str');
        }
	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("btn-danger").addClass("btn-success");   	this_klass.text('Form Closed');
        
	$.ajax({
            
	    url: "/recruitments/"+id+"/update_admission.json",
	    type: 'PUT',
	    data: "status=success",
	    success:function(data) {
	      	alert("");
		if (status == "Form Closed")
		{
                    alert("");
                    this_klass.text('Form Closed');
                    
                }
	    }
            
	});
        
    });
    
})

