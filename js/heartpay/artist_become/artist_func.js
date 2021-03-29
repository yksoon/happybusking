//아티스트 되기 페이지 이동 함수
function go_artist_become() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		
		if(artist_chk()){
			infoTxtBox('이미 아티스트입니다.');
			return;
		}
		loadPage('artist_become/artist_become.jsp');
	}
	
}

function backArtistBecome(){
	var joinChk = sessionStorage.getItem('joinChk');
	if(joinChk == 'Y'){
		sessionStorage.removeItem('joinChk');
		toHome();
	} else {
		history.go(-1);
	}
}

function go_artist_update() {
	if(!artist_chk()){
		infoTxtBox('아티스트가 아닙니다.');
		return;
	}
	loadPage('artist_become/artist_update.jsp');
}
