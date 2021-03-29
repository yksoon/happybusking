$(document).ready(function(){
	//CommonFunction.LoginChkForPage();
	CommonFunction.headerHtml = '<p class="ft_l_gray ft_14 cursorpointer chnagemenu under_line delcontent">메트로아티스트</p>'+
								'<img class="delcontent" src="/img/homepage/common/sub_next.png">'+
								'<p class="ft_l_gray ft_14 cursorpointer chnagemenu delcontent">신청 관리</p>';
	CommonFunction.HBottomChange();
	
	let n = CommonFunction.GetParameterByName('n');
	MetroArtistFunction.GetApplyManageDetail(n);
});

$(document).on('click', '#ad_video', function(){
	let url = $(this).text();
	
	if(url != ''){
		window.open(url, '_blank');
	}
});

$(document).on('click', '#y_btn', function(){
	let tno = $('#ad_teamno').val();
	let belong = $('#ad_belong').val();
	let kid = CommonFunction.GetParameterByName('n');
	
	if(belong == '') belong = '메트로 아티스트';
	else belong += ',메트로 아티스트';
	
	MetroArtistFunction.SetApplyManageYes(kid, tno, belong);
});

$(document).on('click', '#n_btn', function(){
	let kid = CommonFunction.GetParameterByName('n');
	
	MetroArtistFunction.SetApplyManageNo(kid);
});