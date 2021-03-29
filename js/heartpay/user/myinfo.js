//내 정보 페이지 이동
function go_user_update(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('user/myinfo.jsp');
	}
}


$(document).on("pageinit", "#myinfo", function() {	
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/user/get_myinfo_list.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				return;
			}

			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var USER_NO = $(this).find("USER_NO").text();
				var USER_ID = $(this).find("USER_ID").text();
				var NICKNAME = $(this).find("NICKNAME").text();
				
				$('#myinfo_Email').val(USER_ID);
				$('#myinfo_Nicname').val(NICKNAME);
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });					
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});	
	
});



//수정완료 버튼 클릭 시
$(document).on('click', '#myinfoUpdateBtn', function(){
	var nickname = $('#myinfo_Nicname').val();
	
	if(nickname == ""){
		infoTxtBox("닉네임을 입력해주세요");
		$('#myinfo_Nicname').focus();
		return;
	}

	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/user/myinfo_update.jsp";
	var data = "nickname=" + nickname;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data : data,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				return;
			}
			
			$(DATA).each(function(i) {
				/* XML 컬럼들 */
				var RESULT = $(this).find("RESULT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				
				if(RESULT == "true"){	
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					infoTxtBox(MESSAGE);
					toHome();
				}else if(RESULT == "false"){
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
					infoTxtBox(MESSAGE);
					go_user_update();
					
				}
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});			

});

//내 정보 페이지 로그아웃 버튼 클릭시
$(document).on('click', '#myinfoLogoutBtn', function(){
	var logout_con = confirm("로그아웃 하시겠습니까?");
    if (logout_con == false) {
        return false;
    }
    user_logout('o');
});