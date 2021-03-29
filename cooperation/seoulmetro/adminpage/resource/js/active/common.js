let totaldata = '0';	//리스트 호출시 전체 데이터 갯수

$(document).ready(function(){
	let uid = sessionStorage.getItem('uid');
	$loginchk = $('.loginchk');
	$hLoginChk = $('.hLoginChk');
	if(uid == null || uid == ''){
		//로그인 안된 경우
	} else {
		//로그인 된경우
		$loginchk.html('로그아웃');
		$loginchk.removeClass('goLogin');
		$hLoginChk.removeClass('goLogin');
		$loginchk.addClass('goLogout')
		$hLoginChk.addClass('goLogout');
	}
});

$(document).on('click', '.goLogout', function(){
	let conf = confirm('정말 로그아웃 하시겠습니까?');
	if(!conf) return;
	
	sessionStorage.removeItem('uid');
	alert('로그아웃 되었습니다.');
	location.href="/cooperation/seoulmetro/adminpage/";
});

//홈으로 이동
$(document).on('click', '.goHome', function(){
	location.href="/cooperation/seoulmetro/adminpage/";
});

//로그인 페이지로 이동
$(document).on('click', '.goLogin', function(){
	location.href='/cooperation/seoulmetro/adminpage/view/user/login.jsp';
});

//공지사항 페이지로 이동
$(document).on('click', '.goNotice', function(){
	CommonFunction.LoginChk('/cooperation/seoulmetro/adminpage/view/notice/noticelist.jsp');
});

//메트로 아티스트 (소속 아티스트 정보) 페이지로 이동
$(document).on('click', '.goMetroArtist', function(){
	CommonFunction.LoginChk('/cooperation/seoulmetro/adminpage/view/metroartist/list.jsp');
});

//일정관리 페이지로 이동
$(document).on('click', '.goScheduleManage', function(){
	CommonFunction.LoginChk('/cooperation/seoulmetro/adminpage/view/metroartist/schedulemanage.jsp');
});

//평가정보 페이지로 이동
$(document).on('click', '.goEvaluationInfo', function(){
	CommonFunction.LoginChk('/cooperation/seoulmetro/adminpage/view/metroartist/evaluationinfo.jsp');
});

//설문결과 페이지로 이동
$(document).on('click', '.goServeyResults', function(){
	CommonFunction.LoginChk('/cooperation/seoulmetro/adminpage/view/metroartist/serveyresults.jsp');
});

//푸시전송 페이지로 이동
$(document).on('click', '.goSendPush', function(){
	CommonFunction.LoginChk('/cooperation/seoulmetro/adminpage/view/user/sendpush.jsp');
});

//검색어 입력하고 검색버튼 클릭시
$(document).on('click', '#h_search_btn', function(){
	let search = $('#h_search_text').val();
	
	if(CommonFunction.SpaceChk(search) == ''){
		alert('검색어를 입력해주세요.');
		$('#h_search_text').val('');
		$('#h_search_text').focus();
		return;
	}

	let thisUrl = window.location.pathname.split('/');
	thisUrl = thisUrl[thisUrl.length - 1].split('.')[0];
	
	let url = window.location.pathname + '?search=' + search;
	
	if(thisUrl == 'evaluationinfo'){
		let year = $('#ei_year').val();
		let month = $('#ei_month').val();
		url += '&y=' + year + '&m=' + month;
	}
	
	location.href = url;
});

//검색어 focus 후 엔터 입력시
$(document).on('keyup', '#h_search_text', function(e){
	if(e.keyCode == 13) $('#h_search_btn').click();
});

//리스트 초기화 버튼 클릭시
$(document).on('click', '#h_clear_btn', function(){
	let url = window.location.pathname;
	location.href = url;
});

//뒤로가기 공통 
$(document).on('click', '.go_back_btn', function(){
	history.go(-1);
});