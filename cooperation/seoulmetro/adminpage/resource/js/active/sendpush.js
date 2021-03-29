$(document).ready(function(){
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">푸시전송</p>';
	CommonFunction.HBottomChange();
});

$(document).on('click', '#send_push_btn', function(){
	let date = String(CommonFunction.GetNowYear()) + CommonFunction.SetPad(String(CommonFunction.GetNowMonth()), 2);
	let obj = $('#push_obj').val();
	let limit = $('#push_limit').val();
	let title = $('#push_title').val();
	let content = $('#push_content').val();
	
	if(limit == null || limit == ''){
		alert('월 공연 횟수를 선택해주세요');
		return;
	} else if(CommonFunction.SpaceChk(title) == ''){
		alert('푸시 제목을 입력해주세요.');
		$('#push_title').val('');
		$('#push_title').focus();
		return;
	} else if(CommonFunction.SpaceChk(content) == ''){
		alert('푸시 내용을 입력해주세요.');
		$('#push_content').val('');
		$('#push_content').focus();
		return;
	}
	
	UserFunction.SendPush(date, obj, limit, title, content);
});