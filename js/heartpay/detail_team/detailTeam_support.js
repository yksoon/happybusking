$(document).ready(function(){
	$("#except_area").hide();
	$("input[name=amount]").change(function(){
		var amount = $(this).val();
		if(amount == "except"){
			$("#except_area").show();
		}else{
			$("#except_area").hide();
		}
	});
});