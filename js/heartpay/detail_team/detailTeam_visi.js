//$(document).ready(function(){
//	$("#visi_reple").hide();
//	$("input[name=amount]").change(function(){
//		var amount = $(this).val();
//		if(amount == "except"){
//			$("#visi_reple").show();
//		}else{
//			$("#visi_reple").hide();
//		}
//	});
//});
$(document).ready(function(){
	$("#visi_reple").hide();
	$("#reple").click(function(){
		$("#visi_reple").show();
	});
});