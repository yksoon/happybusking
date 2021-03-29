//앱 정보 페이지 들어가기
function go_happybusking_info() {
	loadPage('app_info/app_info.jsp');
}


//소개 
function go_app_introduce() {
	loadPage('app_info/app_intro.jsp');
}

//이용약관 페이지 가기
function go_app_useTerms() {
	loadPage('app_info/app_useterms.jsp');
}

//개인정보취급방침 페이지 가기
function go_app_useInfoTerms() {
	loadPage('app_info/app_useinfoterms.jsp');
}


//문의하기 페이지에서 목록 클릭시
$(document).on('click', '.appContactGrid', function () {
	var index = $('.appContactGrid').index(this);

	if ($('.appContactAns').eq(index).css('display') == 'none') {
		$('.appContactAns').hide();
		$('.appContactAns').eq(index).show();
	}
	else {
		$('.appContactAns').eq(index).hide();
	}
});

//회원 탈퇴 클릭시
$(document).on('click', '#delUser', function () {
	var user_no = $('#user_no').val();
	confirmBox4('계정을 삭제하실 경우 해피버스킹 앱에서 사용했던 회원님의 등록된 모든 사용내역의 복구가 불가합니다.<br>그래도 삭제하시겠습니까?', goDelete, noDelete);
	function goDelete() {
		user_logout('d');
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/user/user_delete.jsp',
			data: {
				user_no: user_no
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
			},
			error: function (xhr, message, errorThrown) {
			}
		});
	}
	function noDelete() {
		return;
	}
});