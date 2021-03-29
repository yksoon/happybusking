function go_account_change() {
	loadPage('thanks_people/account_change.jsp');
}

$(document).on('pageinit', '#account_change', function() {
	$('#account_chage_team_name').empty();
	$('#account_chage_team_name').html(tp_team_name);
});

$(document).on('click', '#account_change_btn', function() {
	var team_name = $('#account_chage_team_name').text();
	var team_acc_holder = $('#account_name').val();
	var team_bank = $('#account_bank').val();
	var team_account = $('#account_acc').val();
	
	if(team_acc_holder == ''){
		infoTxtBox('예금주를 입력해주세요.');
		$('#account_name').focus();
		return;
	}
	else if(team_account == ''){
		infoTxtBox('계좌번호를 입력해주세요.');
		$('#account_acc').focus();
		return;
	}
	
	$.ajax({
		type: "POST",
		url: '/service/thanks_people/account_change.jsp',
		data:{
			team_name: team_name,
			team_acc_holder: team_acc_holder,
			team_bank: team_bank,
			team_account: team_account
		},
		success: function (data) {
		}
	});
	
	infoTxtBox('지급 전용계좌 변경이 완료되었습니다.');
	go_thanks_people();
});