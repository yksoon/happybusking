$(document).ready(function(){
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">로그인</p>';
	CommonFunction.HBottomChange();
});

$(document).on('click', '#login_btn', function(){
	let id = $('#id').val();
	let pw = $('#pw').val();
	
	if(CommonFunction.SpaceChk(id) == ''){
		alert('아이디를 입력해주세요.');
		$('#id').val('');
		$('#id').focus();
		return;
	} else if(CommonFunction.SpaceChk(pw) == ''){
		alert('비밀번호를 입력해주세요.');
		$('#pw').val('');
		$('#pw').focus();
		return;
	}
	
	UserFunction.Login(id, pw);
});

$(document).on('keyup', '#id', function(e){
	if(e.keyCode == 13) $('#login_btn').click();
});

$(document).on('keyup', '#pw', function(e){
	if(e.keyCode == 13) $('#login_btn').click();
});