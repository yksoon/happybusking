function getUQList(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/user_question.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			$(DATA).each(function(i) {
				var UQ_NO = $(this).find('UQ_NO').text();
				var UQ_TYPE = $(this).find('UQ_TYPE').text();
				var UQ_CONTENT = $(this).find('UQ_CONTENT').text();
				var UQ_REGIDATE = $(this).find('UQ_REGIDATE').text();
				var UQ_STATE = $(this).find('UQ_STATE').text();
				var UQ_TITLE = $(this).find('UQ_TITLE').text();
				var UQ_PARENT = $(this).find('UQ_PARENT').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var UQ_USER_NO = $(this).find('UQ_USER_NO').text();
				var UQ_NONMEMBERID = $(this).find('UQ_NONMEMBERID').text();
				
				//console.log(UQ_USER_NO);
				
				if(UQ_STATE === 'Y') UQ_STATE = '처리완료';
				else UQ_STATE = '대기';
				
				if(UQ_USER_NO == null || UQ_USER_NO == '' ||UQ_USER_NO == '0'){
					var uq_trtd = '<tr id="'+UQ_NO+'"><td class="uqct_name">(비회원)'
					+ UQ_NONMEMBERID +'</td><td>'
					+ UQ_TYPE+'</td><td class="uqct_title">'
					+UQ_TITLE+'</td><td>'
					+UQ_REGIDATE+'</td><td>'
					+UQ_STATE+'</td></tr>' ;
				} else {
					var uq_trtd = '<tr id="'+UQ_NO+'"><td class="uqct_name">'
					+ NICKNAME +'</td><td>'
					+ UQ_TYPE+'</td><td class="uqct_title">'
					+UQ_TITLE+'</td><td>'
					+UQ_REGIDATE+'</td><td>'
					+UQ_STATE+'</td></tr>' ;
				}
				
				
				
				
				var uqpc_content = '<div class="uqpc_content">'+UQ_CONTENT+'</div>'
				var uqpc_comment = '<textarea rows="" cols="" class="uqpc_comment" placeholder="insert here"></textarea>'
				$('.uq_popup_comment').append(uqpc_content);
				$('.uq_popup_comment').append(uqpc_comment);
				$('.uqc_table').append(uq_trtd);
				
			});
		},
		error: function(xhr){
			//console.log(xhr);
		}
	});
	$('#admin_page_container').load('/app_admin/user_question.jsp #user_question_container');
};


$(document).on('click', '.uqct_title', function(){
	var str = $(this).parents('tr').attr('id');
	var url = 'user_question_popup.jsp';
	
	var windowObj = window.open(url, 'user_question_popup', 'width=500, height=500');
	
	setTimeout(function(){
		windowObj.document.getElementById('uq_no').value = str;
	}, 200);
});