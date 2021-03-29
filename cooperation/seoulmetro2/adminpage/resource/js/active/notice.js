$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">공지사항</p>';
	CommonFunction.HBottomChange();
	let currentPage = (CommonFunction.GetParameterByName('currentpage') == '') ? '1' : CommonFunction.GetParameterByName('currentpage');
	
	let search = CommonFunction.GetParameterByName('search');
	let start = (parseInt(currentPage) - 1) * 8;
	$('#h_search_text').val(search);
	NoticeFunction.GetNoticeList(search, start, '');
	PagingFunction.Paging(totaldata, 8, 10, currentPage);
});

//공지사항 목록 클릭시
$(document).on('click', '.notice_item', function(){
	let id = $(this).attr('id');
	
	//상세페이지로 이동하는 로직 추가해야됨
	let url = '/cooperation/seoulmetro/adminpage/view/notice/noticedetail.jsp?dno=' + id;
	CommonFunction.LoginChk(url);
});

