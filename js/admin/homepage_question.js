//여기에는 updateHQRequestState 함수 불러오는 기능 구현
$(document).on('change', '.hq_state', function(){
	var hq_no = $(this).parents('tr').attr('id');
	var hq_state = $(this).val();
	
	updateHQRequestState(hq_no, hq_state);
});


///////////////////////////////////////////////

function getHQList(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/homepage_question.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			$(DATA).each(function(i) {
				var HQ_NO = $(this).find('HQ_NO').text();
				var HQ_STATE = $(this).find('HQ_STATE').text();
				var HQ_TITLE = $(this).find('HQ_TITLE').text();
				var HQ_CONTENT = $(this).find('HQ_CONTENT').text();
				var HQ_REQUEST = $(this).find('HQ_REQUEST').text();
				var HQ_REGIDATE = $(this).find('HQ_REGIDATE').text();
				var HQ_REQUESTDATE = $(this).find('HQ_REQUESTDATE').text();
				
				
				
				if(HQ_STATE == 'N'){
					var HQ_SELECT = '<select class="hq_state"><option class="hq_option" value="N" selected onclick="function1">대기</option><option class="hq_option y" value="Y" onclick="function2">처리완료</option></select>' ;	
				}else if(HQ_STATE == 'Y'){
					var HQ_SELECT = '<select class="hq_state"><option class="hq_option" value="N" onclick="function1">대기</option><option class="hq_option y" value="Y" selected onclick="function2">처리완료</option></select>' ;
				}
				
				var h = '';
				
				if(i === 0 || i % 2 === 0){
					h = '<tr class="bg_whiteblue" id="'+HQ_NO+'"><td>';
				} else {
					h = '<tr id="'+HQ_NO+'"><td>';
				}
				
				var hq_trtd = h
					+HQ_TITLE+'</td><td class="hqct_title" style="padding: 10px 5px;">'
					+HQ_CONTENT+'</td><td>'
					+HQ_REQUEST+'</td><td style="width: 105px;">'
					+HQ_REGIDATE+'</td><td style="width: 95px;">'
					+HQ_SELECT +'</td></tr>';
				
				$('.hqc_table').append(hq_trtd)	
				
			});
		},
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/homepage_question.jsp #homepage_question_container');
};



//select box change 된 경우 해당 DB에 업데이트 해주는 기능 함수로 구현
function updateHQRequestState(hq_no, hq_state){
	//여기다 업데이트 기능 구현
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/hq_update.jsp',
		data:{
			hq_state: hq_state,
			hq_no: hq_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			getNewWrite();
		}
	});
	//console.log(hq_no + ',' + hq_state);
	
	////////////////////////////////////////////////////////
};


