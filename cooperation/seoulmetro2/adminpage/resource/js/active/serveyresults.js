$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">설문결과</p>';
	CommonFunction.HBottomChange();
	
	let currentPage = (CommonFunction.GetParameterByName('currentpage') == '') ? '1' : CommonFunction.GetParameterByName('currentpage');
	let search = CommonFunction.GetParameterByName('search');
	let start = (parseInt(currentPage) - 1) * 8;
	$('#h_search_text').val(search);
	MetroArtistFunction.GetServeyResultsList(search, start);
	PagingFunction.Paging(totaldata, 8, 10, currentPage);
});