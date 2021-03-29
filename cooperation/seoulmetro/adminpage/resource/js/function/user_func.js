UserFunction = {
	Login: function(id, pw){
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/user/login.jsp',
			data: {
				id: id,
				pw: pw
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var UID = $(this).find('UID').text();
					var CNT = $(this).find('CNT').text();
					
					if(CNT == '0'){
						alert('아이디 또는 비밀번호를 확인해주세요');
						$('#pw').focus();
						return;
					} else {
						sessionStorage.setItem('uid', UID);
						alert('로그인되었습니다.');
						location.href="/cooperation/seoulmetro/adminpage/";
					}
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	},
	SendPush: function(date, obj, limit, title, content){
		let conf = confirm('작성하신 내용으로 푸시를 보내시겠습니까?');
		if(!conf) return;
		
		$.ajax({
			type: "GET",
			cache: false,
			async: false,
			url: '/cooperation/seoulmetro/adminpage/resource/service/push/push_service.jsp',
			data: {
				date: date,
				obj: obj,
				limit: limit,
				title: title,
				content: content
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			},
			complete: function(){
				alert('푸시가 발송되었습니다.');
				history.go(0);
			}
		});
	}	
};