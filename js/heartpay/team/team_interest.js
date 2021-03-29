//팀정보 페이지에서의 좋아요 버튼 클릭시
$(document).on('click', '#team_interest_icon', function() {
	var user_no = $('#user_no').val();
	
	if(user_no == null || user_no == 'null'){
		alert('로그인 하시고 해당 서비스를 이용해주세요.');
		loadPage('login/login.jsp');
		return;
	}
	
	$.ajax({
		type: "GET",
		url: "/service/team/team_interest.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			team_no: tno,
			user_no: user_no
		},
		dataType: "xml",
		success: function (result) {
			$('#team_interest_icon').attr('src', '/img/v2/ar_like__.svg');
			$('#team_interest_icon').attr('id', 'team_interesting_icon');
			$('#Go_AiBtn').click();

			$("#interest_alarm_popup").show();
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
});

$(document).on('click', '#team_interesting_icon', function() {
	var user_no = $('#user_no').val();
	
	if(user_no == null || user_no == 'null'){
		alert('로그인 하시고 해당 서비스를 이용해주세요.');
		loadPage('login/login.jsp');
		return;
	}
	
	$.ajax({
		type: "GET",
		url: "/service/team/team_interest_not.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			team_no: tno,
			user_no: user_no
		},
		dataType: "xml",
		success: function (result) {
			$('#team_interesting_icon').attr('src', '/img/v2/ar_nolike__.svg');
			$('#team_interesting_icon').attr('id', 'team_interest_icon');
			$('#Go_AiBtn').click();
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
});

//공연 정보 페이지에서의 좋아요버튼 클릭시
$(document).on('click', '#df_team_interest_icon', function() {
	var user_no = $('#user_no').val();
	
	if(user_no == null || user_no == 'null'){
		alert('로그인 하시고 해당 서비스를 이용해주세요.');
		loadPage('login/login.jsp');
		return;
	}
	
	$.ajax({
		type: "GET",
		url: "/service/team/team_interest.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			team_no: tno,
			user_no: user_no
		},
		dataType: "xml",
		success: function (result) {
			$('#df_team_interest_icon').attr('src', '/img/v2/ar_like__.svg');
			$('#df_team_interest_icon').attr('id', 'df_team_interesting_icon');
			$('#Go_PerInfoBtn').click();

			$("#interest_alarm_popup" ).show();
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
});

$(document).on('click', '#df_team_interesting_icon', function() {
	var user_no = $('#user_no').val();
	
	if(user_no == null || user_no == 'null'){
		alert('로그인 하시고 해당 서비스를 이용해주세요.');
		loadPage('login/login.jsp');
		return;
	}
	
	$.ajax({
		type: "GET",
		url: "/service/team/team_interest_not.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			team_no: tno,
			user_no: user_no
		},
		dataType: "xml",
		success: function (result) {
			$('#df_team_interesting_icon').attr('src', '/img/v2/ar_nolike__.svg');
			$('#df_team_interesting_icon').attr('id', 'df_team_interest_icon');
			$('#Go_PerInfoBtn').click();
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
});

$(document).on('click', '#int_alarm_noBtn', function() {
	$("#interest_alarm_popup").hide();
});