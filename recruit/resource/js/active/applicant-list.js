$(document).ready(function(){
	let currentPage = (getParam('currentpage') == '') ? '1' : getParam('currentpage');
	
	let start = (parseInt(currentPage) - 1) * 10;
	
	const sort = sessionStorage.getItem('al-sort');
	
	$('#filter').val(sort);
	
	let id = getParam('id');
	getApplicantList(id, start, sort);
	
	const datacnt = sessionStorage.getItem('al-data-cnt');
	PagingFunction.Paging(datacnt, 10, 3, currentPage); 
});

$(document).on('click', '.al-number, .al-genre, .al-tname', function(){
	const id = $(this).parents('tr').attr('id');
	
	goApplicantDetail(id);
});

$(document).on('change', '#filter', function(){
	const sort = $(this).val();
	let wl = window.location.href;
	let url = wl.split('&currentpage=')[0];
	
	sessionStorage.setItem('al-sort', sort);
	
	location.href = url;
});

$(document).on('click', '.al-youtube', function(){
	const url = $(this).attr('id');
	window.open(url, '_blank');
});