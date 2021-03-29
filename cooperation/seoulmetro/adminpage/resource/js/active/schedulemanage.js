$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">일정관리</p>';
	CommonFunction.HBottomChange();
	
	let currentPage = (CommonFunction.GetParameterByName('currentpage') == '') ? '1' : CommonFunction.GetParameterByName('currentpage');
	let search = CommonFunction.GetParameterByName('search');
	let start = (parseInt(currentPage) - 1) * 8;
	$('#h_search_text').val(search);
	MetroArtistFunction.GetScheduleManageList(search, start);
	PagingFunction.Paging(totaldata, 8, 10, currentPage);
});

$(document).on('change', '.si_cencel_change', function(){
	let id = $(this).parents('.schedulemanage_item').attr('id');
	let value = $(this).val();
	
	MetroArtistFunction.SetScheduleApply(id, value);
});