function goKakaoLoginPage(){
	loadPage('login/kakaologin.jsp');
}
//*********************************************************************************************************************************************************************************


/*var chk_kakao = 0;
$(document).on('click', '#kakao-login-btn', function() {
	var user_id;
	var nickname;
	var birth;
	var gender;
	var token;
	var login_chk = 'K';
	
	location.href="https://kauth.kakao.com/oauth/authorize?client_id=8d6d16a08ab217ad4a93d1ec6abed21c&redirect_uri=http://116.126.142.192:8093/jsp/login/kakaologin.jsp&response_type=code"

	$.mobile.changePage("/jsp/login/kakaotest.jsp", {transition : "none"});
	$(document).on('pageshow', '#kakaotest', function(){
		$('#kaLogin').attr('src', 'https://kauth.kakao.com/oauth/authorize?client_id=8d6d16a08ab217ad4a93d1ec6abed21c&redirect_uri=http://116.126.142.192:8093/jsp/login/kakaologin.jsp&response_type=code');
		var screen = $.mobile.getScreenHeight();
		var header = $(".ui-header").hasClass("ui-header-fixed") ? $(".ui-header").outerHeight() - 1 : $(".ui-header").outerHeight(); 
		var footer = $(".ui-footer").hasClass("ui-footer-fixed") ? $(".ui-footer").outerHeight() - 1 : $(".ui-footer").outerHeight(); 
		var contentCurrent = $(".ui-content").outerHeight() - $(".ui-content").height(); 
		var content = screen - (header + footer + contentCurrent);
		$("#kaLogin").height(content); 
	});
	if(chk_kakao == 0){
		Kakao.init('2cb109930bb35cdfeeeba018a6204388');		
		chk_kakao = 1;
	} 
	
	Kakao.Auth.cleanup();
	
	Kakao.Auth.login({
	    success: function(authObj) {
	      infoTxtBox(JSON.stringify(authObj));
	    },
	    fail: function(err) {
	      infoTxtBox(JSON.stringify(err));
	    }
	});

	
	KakaoTalk.login(
	    function (result) {
	    	infoTxtBox(result);
	    	infoTxtBox(result.id);
	    	infoTxtBox(result.nickname);
	    	infoTxtBox(result.account_email );
			user_id = result.email;
			alert(user_id);
			nickname = result.name;
			birth = result.birthday;
			gender = result.gender;
	    },
	    function (message) {
	      console.log('Error logging in');
	      console.log(message);
	    }
	);
	


});


$(document).on('click', '#later_Loginbtn', function(){
	$.mobile.changePage( "/" , {transition : "none"} );
});



$.ajax({
	type: "GET",//url: "JSON/test.json",
	url: '/service/login/login.jsp',
	data : {
		user_id : user_id
	},
	contentType: "application/xml; charset=utf-8",
	dataType: "xml",
	timeout: 30000,
	success: function (data) {
		var ROOT = $(data).find('ROOT');
		var DATA = $(ROOT).find('DATA');
		if(DATA.length == 0){
			$.ajax({
				type: "GET",//url: "JSON/test.json",
				cache: false,
				url: '/service/join/join.jsp',
				data:{
					user_id : user_id,
					nickname : nickname,
					birth : birth,
					gender : gender,
					token : token,
					login_chk : login_chk
				},
				contentType: "application/xml; charset=utf-8",
				dataType: "xml",
				timeout: 30000,
				success : function (data) {
					infoTxtBox('회원가입이 완료되었습니다');
					self.close();
				}
			});
		}
		
		$(DATA).each(function() {
			var LOGINCHK = $(this).find('LOGINCHK').text();
			if(LOGINCHK == '1'){
				infoTxtBox('로그인 되었습니다.');
				self.close();
			}
		});
	},
	error: function (xhr, message, errorThrown) {
		console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);	
		//hideLoading();
	} // end error 
});

$(document).on('click', '#kaLogin .btn_login submit btn_disabled', function(){
	infoTxtBox(카카오);	
});

function goKakaoLoginPage(){

}
*/


/*		$(document).ready(function(){
			Kakao.init("2cb109930bb35cdfeeeba018a6204388");
			function getKakaotalkUserProfile(){
				Kakao.API.request({
					url: '/v1/user/me',
					success: function(res) {
						$("#kakao-profile").append(res.properties.nickname);
						$("#kakao-profile").append($("<img/>",{"src":res.properties.profile_image,"alt":res.properties.nickname+"님의 프로필 사진"}));
					},
					fail: function(error) {
						console.log(error);
					}
				});
			}
			function createKakaotalkLogin(){
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var loginBtn = $("<a/>",{"class":"kakao-login-btn","text":"로그인"});
				loginBtn.click(function(){
					Kakao.Auth.login({
						persistAccessToken: true,
						persistRefreshToken: true,
						success: function(authObj) {
							getKakaotalkUserProfile();
							createKakaotalkLogout();
						},
						fail: function(err) {
							console.log(err);
						}
					});
				});
				$("#kakao-logged-group").prepend(loginBtn)
			}
			function createKakaotalkLogout(){
				$("#kakao-logged-group .kakao-logout-btn,#kakao-logged-group .kakao-login-btn").remove();
				var logoutBtn = $("<a/>",{"class":"kakao-logout-btn","text":"로그아웃"});
				logoutBtn.click(function(){
					Kakao.Auth.logout();
					createKakaotalkLogin();
					$("#kakao-profile").text("");
				});
				$("#kakao-logged-group").prepend(logoutBtn);
			}
			if(Kakao.Auth.getRefreshToken()!=undefined&&Kakao.Auth.getRefreshToken().replace(/ /gi,"")!=""){
				createKakaotalkLogout();
				getKakaotalkUserProfile();
			}else{
				createKakaotalkLogin();
			}
		});*/
