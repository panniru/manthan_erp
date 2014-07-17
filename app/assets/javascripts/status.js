$(function() {
    $(".change ").on("click", function(event) {	
        toggleFields();
        
	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("btn-danger").addClass("btn-success");  
	this_klass.text('Form Closed');
        function toggleFields() {
            if ($(".change").text == 'Form Closed' )
                $("#test").hide();
            else
                $("#test").show();
        }

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
    $(".send ").on("click", function(event) {
        $.ajax({
            url: "/admissions.json",
            type: 'POST',
            data: "status=success",
            success: function(data) {
            	
            }
        });
    });
})


function toggleFields() {
    if ($(".change").text == 'Form Closed' )
        $("#test").hide();
    else
        $("#test").show();
}
