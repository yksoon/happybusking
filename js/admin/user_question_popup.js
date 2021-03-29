$(function(){
	setTimeout(function(){
		var str = $('#uq_no').val();
		
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/admin/user_question_popup.jsp',
			data:{
				str: str
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var UQ_NO = $(this).find('UQ_NO').text();
					var UQ_TYPE = $(this).find('UQ_TYPE').text();
					var UQ_CONTENT = $(this).find('UQ_CONTENT').text();
					var UQ_REGIDATE = $(this).find('UQ_REGIDATE').text();
					var UQ_STATE = $(this).find('UQ_STATE').text();
					var UQ_TITLE = $(this).find('UQ_TITLE').text();
					var UQ_PARENT = $(this).find('UQ_PARENT').text();
					var NICKNAME = $(this).find('NICKNAME').text();
					var ANSWER = $(this).find('ANSWER').text();
					
					$('#uq_no').val(UQ_NO);
					$('#uq_type').val(UQ_TYPE);
					$('.uqpc_title').text(UQ_TITLE);
					$('.uqpc_content').text(UQ_CONTENT);
					$('#question_reply').val(ANSWER);
					
				});
			},
			error: function(xhr){
				console.log(xhr);
			}
		});
		
	}, 500);
});

$(document).on('click', '#uqpc_button', function(){
	var uq_no = $('#uq_no').val();
	var uq_type = changeQuotes($('#uq_type').val());
	var uq_title = changeQuotes($('.uqpc_title').text());
	var uq_content = changeQuotes($('#question_reply').val());
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/admin/user_question_update.jsp',
		data: {
			uq_title: uq_title,
			uq_type: uq_type,
			uq_no: uq_no,
			uq_content: uq_content 
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete : function(){
			self.close();
		}
	});
});