$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu under_line delcontent">메트로아티스트</p>'+
								'<img class="delcontent" src="/img/homepage/common/sub_next.png">'+
								'<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">신청 관리</p>';
	CommonFunction.HBottomChange();
	
	let currentPage = (CommonFunction.GetParameterByName('currentpage') == '') ? '1' : CommonFunction.GetParameterByName('currentpage');
	let search = CommonFunction.GetParameterByName('search');
	let start = (parseInt(currentPage) - 1) * 8;
	$('#h_search_text').val(search);
	MetroArtistFunction.GetApplyManageList(search, start);
	PagingFunction.Paging(totaldata, 8, 10, currentPage);
});

$(document).on('change', '#change_sub_menu', function(){
	let pageValue = $(this).val();
	let url;
	
	switch(pageValue){
		case '1': url = '/cooperation/seoulmetro/adminpage/view/metroartist/list.jsp'; break;
		case '2': url = '/cooperation/seoulmetro/adminpage/view/metroartist/applymanage.jsp'; break;
		default: url = '';
	}
	
	if(url == '') alert('다시 시도해주세요.');
	else location.href = url;
});

$(document).on('click', '.applymanage_item', function(){
	let id = $(this).attr('id');
	
	let url = '/cooperation/seoulmetro/adminpage/view/metroartist/applymanage_detail.jsp?n=' + id;
	CommonFunction.LoginChk(url);
});