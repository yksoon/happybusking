//문의하기 페이지 가기
function go_app_contact(){
	loadPage('app_info/app_contact.jsp');
}

$(document).on('pageinit', '#app_contact', function(){
	var viewChk = sessionStorage.getItem('appContactChk');
	
	if(viewChk == null || viewChk == '1'){
		$('#goQnA').click();
	} else if(viewChk == '2'){
		$('#goPersonalContact').click();
	}
});

$(document).on('click', '#goQnA', function(){
	sessionStorage.setItem('appContactChk', '1');
	
	$('#prq_search_header').empty();
	var header = '<div class="ui-block-a" id="goQnA">'+
					'<div class="haeder_menu_div_on">'+
						'<span>자주 묻는 질문</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b" id="goPersonalContact">'+
					'<div class="haeder_menu_div_base">'+
						'<span>1:1 문의</span>'+
					'</div>'+
				'</div>';
	$('#prq_search_header').html(header);
	
	$('#app_cc_question_container').show();
	$('#app_cc_personal_container').hide();
});

//1:1문의 클릭시
$(document).on('click', '#goPersonalContact', function(){
	sessionStorage.setItem('appContactChk', '2');
	
	$('#prq_search_header').empty();
	var header = '<div class="ui-block-a" id="goQnA">'+
					'<div class="haeder_menu_div_base">'+
						'<span>자주 묻는 질문</span>'+
					'</div>'+
				'</div>'+
				'<div class="ui-block-b" id="goPersonalContact">'+
					'<div class="haeder_menu_div_on">'+
						'<span>1:1 문의</span>'+
					'</div>'+
				'</div>';
	$('#prq_search_header').html(header);
	
	$('#app_cc_question_container').hide();
	$('#app_cc_personal_container').show();
	if(userLogin_chk() == false){
		$('#url_nonmember_btn').show();
		var nmID = sessionStorage.getItem('nonmemberID');
		var nmPW = sessionStorage.getItem('nonmemberPW');
		getNonmemberRequestList(nmID, nmPW);
	} else {
		$('#url_nonmember_btn').hide();
		getUserRequestList();
	}
});

//문의 목록 페이지 비회원 문의 확인 버튼 클릭시
$(document).on('click', '#url_nonmember_btn', function(){
	$('#app_cc_question_container').hide();
	$('#app_cc_personal_container').show();
	
	while(true){
		var nonmemberIDTmp = sessionStorage.getItem('nonmemberID');
		
		if(nonmemberIDTmp == null){
			var nonmemberID = prompt('문의 아이디', '비회원 문의시 작성해주신 아이디를 입력해주세요.');
		} else {
			var nonmemberID = prompt('문의 아이디', nonmemberIDTmp);
		}
		if(nonmemberID != null){
			nonmemberID = nonmemberID.replace(/ /gi, '');
		}
		
		if(nonmemberID == null){
			return;
		} else if(nonmemberID == '' || nonmemberID == '비회원문의시작성해주신아이디를입력해주세요.'){
			alert('문의 아이디를 입력해주세요.');
		} else {
			sessionStorage.setItem('nonmemberID', nonmemberID);
			break;
		}
	}
	
	while(true){
		var nonmemberPW = prompt('문의 비밀번호', '비회원 문의시 작성해주신 비밀번호를 입력해주세요.');
		
		if(nonmemberPW != null){
			nonmemberPW = nonmemberPW.replace(/ /gi, '');
		}
		
		if(nonmemberPW == null){
			return;
		} else if(nonmemberPW == '' || nonmemberPW == '비회원문의시작성해주신비밀번호를입력해주세요.'){
			alert('문의 비밀번호를 입력해주세요.');
		} else {
			sessionStorage.setItem('nonmemberPW', nonmemberPW);
			break;
		}
	}
	
	var nmID = sessionStorage.getItem('nonmemberID');
	var nmPW = sessionStorage.getItem('nonmemberPW');
	
	if(nmID != null && nmPW != null){
		getNonmemberRequestList(nmID, nmPW);
	}
});

//문의 상세 페이지 생성시
$(document).on('pageinit', '#user_request_detail', function(){
	var uq_no = sessionStorage.getItem('uq_no');
	getUserAnswerDetail(uq_no);
	getUserRequestDetail(uq_no);
});

//문의 상세 페이지 확인버튼 클릭시
$(document).on('click', '#urd_ok_btn', function(){
	history.go(-1);
});

//문의 상세 페이지 삭제버튼 클릭시
$(document).on('click', '#urd_del_btn', function(){
	var conf = confirm('문의하신 내용을 삭제하시겠습니까?');
	if(!conf){
		return;
	}
	
	var uq_no = sessionStorage.getItem('uq_no');
	var nmID = sessionStorage.getItem('nonmemberID');
	var nmPW = sessionStorage.getItem('nonmemberPW');
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/user_request_del.jsp',
		data : {
			uq_no: uq_no
		},
		async : false,
		dataType: "xml",
		beforeSend: function(){
			$.mobile.loading( 'show', { text: '삭제중입니다.', textVisible: true, theme: 'b', html: "" });
		},
		complete: function(){
			$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
			alert('삭제되었습니다.');
			history.go(-1);
		}
	});
});