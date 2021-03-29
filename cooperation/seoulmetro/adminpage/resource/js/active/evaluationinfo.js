$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">평가정보</p>';
	CommonFunction.HBottomChange();

	$('#ei_year').empty();
	$('#ei_month').empty();
	
	let year = (CommonFunction.GetParameterByName('y') == '') ? CommonFunction.GetNowYear() : CommonFunction.GetParameterByName('y');
	let month = (CommonFunction.GetParameterByName('m') == '') ? CommonFunction.SetPad(CommonFunction.GetNowMonth(), 2) : CommonFunction.GetParameterByName('m');
	//년도 셋팅
	$('#ei_year').append('<option selected="selected" value="'+year+'">' + year + '</option>');
	
	//월 셋팅
	let monthHtml = '';
	for(var i = 1; i <= 12; i++){
		i = CommonFunction.SetPad(i, 2);
		if(month == i){
			monthHtml = '<option selected="selected" value="'+i+'">' + i + '</option>';
		} else {
			monthHtml = '<option value="'+i+'">' + i + '</option>';
		}
		
		$('#ei_month').append(monthHtml); 
	}
	let currentPage = (CommonFunction.GetParameterByName('currentpage') == '') ? '1' : CommonFunction.GetParameterByName('currentpage');
	let search = CommonFunction.GetParameterByName('search');
	let start = (parseInt(currentPage) - 1) * 8;
	let date = year + month;
	$('#h_search_text').val(search);
	MetroArtistFunction.GetEvalutionResultsList(search, start, date);
	PagingFunction.Paging(totaldata, 8, 10, currentPage);
});


$(document).on('change', '#ei_year', function(){
	let y = $(this).val();
	let m = $('#ei_month').val();
	//let currentpage = $('.page_on').attr('id');
	
	let url = window.location.pathname + '?y=' + y + '&m=' + m;

	CommonFunction.LoginChk(url);
}); 

$(document).on('change', '#ei_month', function(){
	let y = $('#ei_year').val();
	let m = $(this).val();
	//let currentpage = $('.page_on').attr('id');
	
	let url = window.location.pathname + '?y=' + y + '&m=' + m;

	CommonFunction.LoginChk(url);
});