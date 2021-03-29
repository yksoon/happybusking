//버스커 선서 페이지로 이동
function goBuskingOath(){
	loadPage('busking_oath/busking_oath.jsp');
}

//버스커 선서 뒤로가기
function goBuskingOathBack(){
	sessionStorage.setItem('bocChk', 'Y');
	history.go(-1);
}

$(document).on('pageinit', '#buskingOath', function(){
	var bocChk = getCookie('busker_oath');
	if(bocChk == 'Y'){
		$('.bocBtnOK').show();
		$('.bocBtnNotOK').hide();
	} else {
		$('.bocBtnOK').hide();
		$('.bocBtnNotOK').show();
	}
});

//동의 버튼 클릭시
$(document).on('click', '.bocBtnNotOK', function(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		return;
	}
	
	setCookie('busker_oath', 'Y');
	 $.ajax({
	        type: "GET",
	        cache: false,
	        url: '/service/user/set_busker_oath.jsp',
	        contentType: "application/xml; charset=utf-8",
	        dataType: "xml",
	        timeout: 30000,
	        complete: function(){
	        	history.go(-1);
	        }
	 });
	$('.bocBtnOK').show();
	$('.bocBtnNotOK').hide();
});

//나중에 다시보기 버튼 클릭시
$(document).on('click', '.bocAfterViewBtn', function(){
	sessionStorage.setItem('bocChk', 'Y');
	history.go(-1);
});