function goJoinComplete(joinNickname) {
	sessionStorage.setItem('joinNickname', joinNickname);
	loadPage('join/join_complete.jsp');
}

$(document).on('pageinit', '#join_complete', function () {
	var joinNickname = sessionStorage.getItem('joinNickname');

	$('#join_nickname').html(joinNickname);
});

$(document).on('click', '#jcc_artist_btn', function () {
	sessionStorage.setItem('joinChk', 'Y');
	go_artist_become();
});

$(document).on('click', '#jcc_owner_btn', function () {
	go_reg_store();
});

$(document).on('click', '#jcc_after_btn', function () {
	toHome();
});