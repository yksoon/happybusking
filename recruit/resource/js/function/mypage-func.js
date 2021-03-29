$(document).ready(function(){
	const uno = getCookie('user_no');
	
	if(uno === ''){
		alert('로그인 해주세요.');
		history.go(-1);
		return;
	}
	
	getMyInfo();
});

const getMyInfo = () => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/user/get_myinfo_list.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var USER_ID = $(this).find('USER_ID').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				
				$('#id').val(USER_ID);
				$('#nickname').val(NICKNAME);
			});
		},
		error: function(x, h, r){
			alert('잠시후 다시 시도해주세요.');
			return;
		}
	});
}


const handlerMyPageUpdate = () => {
	const nickname = $('#nickname').val();
	
	if(spaceChk(nickname) === ''){
		alert('닉네임을 입력해주세요.');
		$('#nickname').val('');
		$('#nickname').focus();
		return;
	}
	
	
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/service/user/myinfo_update.jsp',
		data:{
			nickname: nickname
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			alert('수정되었습니다.');
			history.go(-1);
			return;
		},
		error: function(x, h, r){
			alert('잠시후 다시 시도해주세요.');
			return;
		}
	});
}

const handlerLogout = () => {
	let conf = confirm('정말 로그아웃 하시겠습니까?');
	if(!conf) return;
	
	$.ajax({
        type: "GET",
        cache: false,
        url: "/app_root/jsp/logout/logout.jsp",
        data: {
        	type : 'o'
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function(data) {
            var ROOT = $(data).find("ROOT");
            var DATA = $(ROOT).find('DATA');
            $(DATA).each(function(i) {
            	goMyPbi();
            });
        },
        error: function(xhr, message, errorThrown) {
        	console.log(xhr);
        	alert('잠시후 다시 시도해주세요.');
        }
    });
}