$(document).ready(function(){
	let currentPage = (getParam('currentpage') == '') ? '1' : getParam('currentpage');
	
	let start = (parseInt(currentPage) - 1) * 10;
	
	const sort = sessionStorage.getItem('sl-sort');
	
	$('#filter').val(sort);
	
	const id = getParam('id');
	getApplicantScoreList(id);
	sendTeamChk();
	
	const datacnt = sessionStorage.getItem('sl-data-cnt');
	PagingFunction.Paging(datacnt, 10, 3, currentPage); 
});

$(document).on('change', '.sl-checkbox', function(){
	const id = $(this).parents('tr').attr('id');
	let chkStr = sessionStorage.getItem('team-score');
	let arr = new Array();
	let chk = $(this).is(':checked');
	
	if(chk){
		//선택한 경우
		if(chkStr === null || chkStr === 'null' || chkStr === ''){
			arr.push(id);
		} else {
			arr = chkStr.split(',');
			arr.push(id);
		}
	} else {
		//선택 해제한 경우
		arr = chkStr.split(',');
		const idx = arr.indexOf(id);
		if(idx > -1) arr.splice(idx,1);
	}
	const cnt = arr.length;
	$('.sl-select-count').html(cnt);
	
	sessionStorage.setItem('team-score', arr);
});

$(document).on('click', '.sl-tname', function(){
	const id = $(this).parents('tr').attr('id');
	
	goScoreDetail(id);
});

$(document).on('click', '.sl-youtube', function(){
	const url = $(this).attr('id');
	window.open(url, '_blank');
});

$(document).on('change', '#filter', function(){
	const sort = $(this).val();
	let wl = window.location.href;
	let url = wl.split('&currentpage=')[0];
	
	sessionStorage.setItem('sl-sort', sort);
	
	location.href = url;
});