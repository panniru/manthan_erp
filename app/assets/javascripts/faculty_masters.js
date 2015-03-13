$(function() {
    "usestrict";
    $("a[rel='print-employee-report']").on("click", function(){
	$("form#employeeReportForm").attr('action', "get_reports.pdf")
	$("form#employeeReportForm").submit();
    })
    $("a[rel='print-annexure']").on("click", function(){
	$("form#annexureForm").attr('action', "/form24/annexure.pdf")
        $("form#annexureForm").attr('target', "_blank")
	$("form#annexureForm").submit();
    })
    $("a[rel='print-ctc-report']").on("click", function(){
	$("form#employeeCtcForm").attr('action', "get_ctc_reports.pdf")
	$("form#employeeCtcForm").submit();
    })
});
