$(document).on('click', '#test_Loginbtn', function(){
	$.mobile.changePage( "/jsp/login/test_login.jsp" , {allowSamePageTransition: true, transition : "none", reloadPage: true } );
});


$(document).on('click', '#testLoginGoBtn', function(){
	
	var email = $('#test_loginId').val();
	var chk = $('#test_loginChk').val();
	
	var login_chk = chk;

	
	user_id = email;
	nickname = "테스트";
	birth = "";
	gender = "";
	
	//naverLogin.reprompt();
	var chk_status = "L";
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/login/login.jsp',
		data : {
			user_id : user_id,
			nickname : nickname,
			birth : birth,
			gender : gender,
			login_chk : login_chk
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				
				/*$.ajax({
					type: "GET",//url: "JSON/test.json",
					cache: false,
					url: '/service/join/join.jsp',
					data:{
						user_id : user_id,
						nickname : nickname,
						birth : birth,
						gender : gender,
						//token : token,
						login_chk : login_chk
					},
					contentType: "application/xml; charset=utf-8",
					dataType: "xml",
					timeout: 30000,
					success : function (data) {
						chk_status = "J";
						$.mobile.changePage("/", {transition : "none"});
					}
				});*/
				var url = '/index.jsp?nlc=F';
				$.mobile.changePage(url, {transition : "none"});
				
			}
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			$(DATA).each(function() {
				var LOGINCHK = $(this).find('LOGINCHK').text();
				var STATUS = $(this).find('STATUS').text();
				var CNT = $(this).find('CNT').text();
				if(LOGINCHK == '1'){
					if(STATUS == 'L'){
						var url = '/index.jsp?nlc=L&cnt='+CNT;
						$.mobile.changePage(url, {transition : "none"});
					}else if(STATUS == 'J'){
						var url = '/index.jsp?nlc=J&='+CNT;
						$.mobile.changePage(url, {transition : "none"});								
					}

				}
			});
		},
		error: function (xhr, message, errorThrown) {
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			console.log("code:"+xhr+"\n"+"message:"+message+"\n"+"error:"+errorThrown);	
			//hideLoading();
		} // end error 
	});		
});


