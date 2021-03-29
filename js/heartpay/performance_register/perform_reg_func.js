function go_perform_reg() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('performance_register/perform_reg.jsp');
		}
	}
}

function go_perform_reg_back(){
	var pfrChk = sessionStorage.getItem('pfrChk');
	if(pfrChk == null || pfrChk == ''){
		history.go(-1);
	} else {
		history.go(-3);
		sessionStorage.removeItem('pfrChk');
	}
}

function perform_reg_push_send(tno, perform_sDate) {
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/pushService/performRegPush.jsp',
		data: {
			team_no : tno,
			date : perform_sDate
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
		}
	});
}