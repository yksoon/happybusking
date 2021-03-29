$(document).ready(function(){
	CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu under_line delcontent">메트로아티스트</p>'+
								'<img class="delcontent" src="/img/homepage/common/sub_next.png">'+
								'<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">소속 아티스트 정보</p>';
	CommonFunction.HBottomChange();
	
	tno = CommonFunction.GetParameterByName('tno');
	
	MetroArtistFunction.GetMetroArtistDetail(tno);
});

$(document).on('click', '#md_video', function(){
	let url = $(this).text();
	
	if(url != ''){
		window.open(url, '_blank');
	}
});