$(document).ready(function(){
	const np = getParam('np');
	
	if(np === 'ad'){
		$('#ad').show();
	} else if(np === 'sd'){
		$('#sd').show();
	}
	
	const id = getParam('id');
	getApplicantDetail(id);
});


$(document).on('click', '#send', function(){
	showLoading('통보중입니다.');
	
	const id = getParam('id');
	const mlTitle = sessionStorage.getItem('ml-title');
	const body = '신청하신 [' + mlTitle + ']에 선발되셨습니다.';
	
	oneSend(id, body);
	
	hideLoading();
	alert('선발 결과를 통보했습니다.');
});

$(document).on('click', '#url', function(){
	const url = $(this).text();
	window.open(url, '_blank');
});