const goMyRecruit = () => {
	if(!teamChk()) return;
	else {
		loadPage('user/my_recruit.jsp');
	}
} 

const getMyRecruit = () => {
	$('#mr-list').empty();
	const filter = sessionStorage.getItem('mri-filter');
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/user/get_my_recruit_list.jsp',
		data: {
			filter : filter
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			let ROOT = $(data).find('ROOT');
			let DATA = $(ROOT).find('DATA');
			
			if(DATA.length === 0){
				$('#mr-list').append('<p id="main_cont" class="noViewBtn">공모 신청 내역이 없습니다.</p>');
				return;
			}

			$(DATA).each(function(i) {
				let TEAM_NO = $(this).find("TEAM_NO").text();
				let KID = $(this).find("KID").text();
				let KGUBUN = $(this).find("KGUBUN").text();
				let KTEAM = $(this).find("KTEAM").text();
				let REGDATE = $(this).find("REGDATE").text().split(' ')[0];
				let CANCEL = $(this).find("CANCEL").text();
				let PASS = $(this).find("PASS").text();
				let PBI_RECEIPT_EDATE = $(this).find("PBI_RECEIPT_EDATE").text();
				let PBI_TITLE = $(this).find("PBI_TITLE").text();
				
				REGDATE = dateFormatChange2(REGDATE.replace(/-/gi, ''));
				
				const dday = ddayExon(PBI_RECEIPT_EDATE.replace(/-/gi, ''));
				
				
				let leftBtn = '';
				let rightBtn = '';
				
				if(PASS === 'Y'){
					//합격
					leftBtn = '<div class="mri-btn mri-pass">합격</div>';
					rightBtn = '<div class="mri-btn mri-notcancel">취소불가</div>';
				} else {
					//불합격
					if(dday < 0){
						//접수일 지난 경우
						leftBtn = '<div class="mri-btn mri-fail">불합격</div>';
						rightBtn = '<div class="mri-btn mri-notcancel">취소불가</div>';
					} else {
						//접수일 안지난 경우
						leftBtn = '<div class="mri-btn mri-unp">결과 미발표</div>';
						rightBtn = '<div class="mri-btn mri-cancel" onclick="handlerMyRecruitDel(\''+KID+'\');">신청취소</div>';
					}
				}
				
				const html = '<div class="mr-item">'+
								'<p class="mri-title">'+PBI_TITLE+'</p>'+
								'<p class="mri-tname">'+KTEAM+'</p>'+
								'<p class="mri-date">'+REGDATE+' 신청완료</p>'+
								'<div class="mri-btn-container">'+
									leftBtn+
									rightBtn+
								'</div>'+
							'</div>'; 
				
				$('#mr-list').append(html);
			});
		},//end success
		error: function (xhr, message, errorThrown) {
			console.log(xhr);
		} // end error
	});
}


const handlerMyRecruitDel = (kid) => {
	let conf = confirm('정말 취소하시겠습니까 ?');
	if(!conf) return;
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/user/del_my_recruit.jsp',
		data: {
			kid : kid
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete : function(){
			
			alert('삭제되었습니다');
			getMyRecruit();
		},
		error: function(xhr){
			alert('잠시후 다시 시도해주세요');
			return;
		}
	});
}