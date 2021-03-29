$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent goNotice">공지사항</p>';
	CommonFunction.HBottomChange();
	
	let dno = CommonFunction.GetParameterByName('dno');
	NoticeFunction.GetNoticeDetail(dno);
});

$(document).on('click', '.dt_item', function(){
	let id = $(this).attr('id');
	
	if(id == ''){
		return;
	} else {
		url = window.location.pathname + '?dno=' + id;
		location.href=url;
	}
});