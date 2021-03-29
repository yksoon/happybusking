//QR코드 스캔 이미지 클릭시
function timeCompare(sdate, edate){
	var now = new Date();	//현재시간
	
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	if(String(month).length < 2) month = '0' + month;
	var date = now.getDate();
	if(String(date).length < 2) date = '0' + date;
	var hour = now.getHours();
	if(String(hour).length < 2) hour = '0' + hour;
	var min = now.getMinutes();
	if(String(min).length < 2) min = '0' + min;
	
	var today = year + '' + month + '' + date + '' + hour + '' + min;
	//var today = hour + '' + min;
	
	//console.log('sdate : ' + sdate);
	//console.log('edate : ' + edate);
	//console.log('today : ' + today);
	
	if((eval(today) >= eval(sdate)) && ((eval(today) <= eval(edate)))){
		return true;
	} else {
		return false;
	}
}

function qr_scan() {
	cordova.plugins.barcodeScanner.scan(
	function(result) {
		if (result.cancelled) {
			return;
		} else {
			// 쿼리스트링값 가져오는 함수 사용
			var test = getUrlParams(result.text);

			var url = "/service/qr_scan.jsp";
			// var data = "team_no=" + test.team_no +"&pf_no="+test.pf_no;
			var data = "team_no=" + test.team_no;
			
			setCookie('cooperationOK', 'N');
			
			
			if(test.cooperation == 'koica'){
				//KOICA 협업 QR 스캔시 
				//timeCompare('201909181530', '201909181630')
				if(timeCompare('201911161330', '201911161400')){
					data = "team_no=1911131844174408";
				} else if(timeCompare('201911161401', '201911161500')){
					data = "team_no=900011";
				} else if(timeCompare('201911161501', '201911161600')){
					data = "team_no=1911130455199120";
				} else {
					alert('지금은 공연 시간이 아닙니다.');
					return;
				}
				//setCookie('cooperationOK', 'Y');
				data = "team_no=900006";
			} else if(test.cooperation == 'iseoulu'){
				//아이서울유 협업 QR 스캔시
				if(timeCompare('201911201200', '201911201400')){
					data = 'team_no=1909072402523943';
				} else if(timeCompare('201911231200', '201911231400')){
					data = 'team_no=900020';
				} else if(timeCompare('201911231401', '201911231600')){
					data = 'team_no=900006';
				} else if(timeCompare('201911231601', '201911231700')){
					data = 'team_no=1911122150444439';
				} else if(timeCompare('201911241200', '201911241400')){
					data = 'team_no=1911201132201342';
				} else if(timeCompare('201911301200', '201911301400')){
					data = 'team_no=900990';
				} else if(timeCompare('201911301401', '201911301600')){
					data = 'team_no=1911122150444439';
				} else if(timeCompare('201912011401', '201912011600')){
					data = 'team_no=1911290903414782';
				} else {
					setCookie('cooperationOK', 'N');
					alert('지금은 공연 시간이 아닙니다.');
					return;
				}
				
				setCookie('cooperationOK', 'Y');
			} else if(test.cooperation == 'metro'){
				if(!attendanceChk()){
					//출석 안된 경우
					data = getScheduleTeam(test.pno);
					if(data == ''){
						alert('지금은 공연 시간이 아닙니다.');
						return;
					} else {
						data = 'team_no=' + data;
					}
				} else{
					//출석 된 경우
					alert('출석 되었습니다!');
					return;
				}
			}
			//협업사 공연 일정 구분해야하는 경우 이쪽에 else if로 추가.
			//DB schedule application 테이블 참고.
			////////////////////////////////////////////////////
			
			
			$.ajax({
				type : "GET",// url: "JSON/test.json",
				cache : false,
				url : url,
				data : data,
				contentType : "application/xml; charset=utf-8",
				dataType : "xml",
				timeout : 30000,
				async: false,
				success : function(data) {
					var ROOT = $(data).find("ROOT");
					var DATA = $(ROOT).find('DATA');
					if (DATA.length == 0) {
						// infoTxtBox("오류입니다.");
						return;
					}
					$(DATA).each(
							function(i) {

								var TNO = $(this).find("TNO").text();
								var RESULT = $(this).find("RESULT").text();
								var MESSAGE = $(this).find("MESSAGE").text();

								if (RESULT == "true") {

									// infoTxtBox(RESULT);

									// $('#artistNo').val(TNO);
									$.mobile.loading('hide', {
										text : 'foo',
										textVisible : false,
										theme : 'z',
										html : ""
									});
									
									var currentPage_url = window.location.href;	//현재 페이지
									sessionStorage.setItem('TNO', TNO);
									
									if(currentPage_url == 'https://www.happybusking.com/app_root/jsp/team/team_info.jsp'){
										var tBackCount = sessionStorage.getItem('tBackCount');
										if(tBackCount == null){
											sessionStorage.setItem('tBackCount', '2');
										} else {
											tBackCount = (tBackCount * 1) + 1;
											sessionStorage.setItem('tBackCount', tBackCount);
										}
										$.mobile.changePage(
											currentPage_url, {
												allowSamePageTransition : true,
											    transition              : 'none',
											    showLoadMsg             : false,
											    reloadPage              : true
											}
										);
									} else {
										go_team_infoPage(TNO);
									}
									
									$(document).on("pagecreate", "#team_info",
										function() {
											$('#artistNo').val(TNO);
										})

								} else if (RESULT == "false") {

									$.mobile.loading('hide', {
										text : 'foo',
										textVisible : false,
										theme : 'z',
										html : ""
									});
									
									alert('해피버스킹 Members QR-CODE가 아닙니다.');
									
									$.mobile.toast({
										message : MESSAGE,
										duration : 1500,
										position : 65,
									});
								}
							}).promise().done(function() {
						$.mobile.loading('hide', {
							text : 'foo',
							textVisible : false,
							theme : 'z',
							html : ""
						});
					});

				}, // end success
				error : function(xhr, message, errorThrown) {
				} // end error
			});
		}
	},

	function(error) {
		infoTxtBox(error);

		// infoTxtBox("제대로 인식하지 못햇습니다!!!. 다시 읽혀 주세요.");
		// $.mobile.changePage('/jsp/user/store/store_info.jsp', {transition :
		// 'none'});
	}, {
		preferFrontCamera : false, // iOS and Android
		showFlipCameraButton : false, // iOS and Android
		showTorchButton : false, // iOS and Android
		disableAnimations : true, // iOS
		disableSuccessBeep : false
	// iOS and Android

	}

	);
}


//팁박스 QR스캔
function qr_scan_tipbox(){
	cordova.plugins.barcodeScanner.scan(
			function(result) {
				if (result.cancelled) {
					return;
				} else {
					// 쿼리스트링값 가져오는 함수 사용
					var test = getUrlParams(result.text);

					var url = "/service/qr_scan_tipbox.jsp";
					// var data = "team_no=" + test.team_no +"&pf_no="+test.pf_no;
					var data = "team_no=" + test.team_no;
					
					$.ajax({
						type : "GET",// url: "JSON/test.json",
						cache : false,
						url : url,
						data : data,
						contentType : "application/xml; charset=utf-8",
						dataType : "xml",
						timeout : 30000,
						success : function(data) {
							var ROOT = $(data).find("ROOT");
							var DATA = $(ROOT).find('DATA');
							if (DATA.length == 0) {
								alert('해피버스킹 Members QR-CODE가 아닙니다.');
								return;
							}
							$(DATA).each(function(){
								var TEAM_NO = $(this).find('TEAM_NO').text();
								var TEAM_NAME = $(this).find('TEAM_NAME').text();
								
								go_support_fromtipbox(TEAM_NO, TEAM_NAME);
							});
						}
					});
				}
			},

			function(error) {
				infoTxtBox(error);

				// infoTxtBox("제대로 인식하지 못햇습니다!!!. 다시 읽혀 주세요.");
				// $.mobile.changePage('/jsp/user/store/store_info.jsp', {transition :
				// 'none'});
			}, {
				preferFrontCamera : false, // iOS and Android
				showFlipCameraButton : false, // iOS and Android
				showTorchButton : false, // iOS and Android
				disableAnimations : true, // iOS
				disableSuccessBeep : false
			// iOS and Android

			}

			);
}

//출석체크하는 부분
function attendanceChk(){
	var bol = true;
	$.ajax({
		type : "GET",// url: "JSON/test.json",
		cache : false,
		async: false,
		url : '/service/seoul_metro/set_attendance_chk.jsp',
		contentType : "application/xml; charset=utf-8",
		dataType : "xml",
		timeout : 30000,
		success : function(data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			$(DATA).each(function(){
				var RES = $(this).find('RES').text();
				
				if(RES == '0'){
					bol = false;
				}
			});
		}
	});
	return bol;
}

//지금 공연중인 팀 가져오는 부분
function getScheduleTeam(pno){
	var team_no = '';
	$.ajax({
		type : "GET",// url: "JSON/test.json",
		cache : false,
		async: false,
		url : '/service/seoul_metro/get_schedule_team.jsp',
		data: {
			pno: pno
		},
		contentType : "application/xml; charset=utf-8",
		dataType : "xml",
		timeout : 30000,
		success : function(data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			$(DATA).each(function(){
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var SNO = $(this).find('SNO').text();
				var RES = $(this).find('RES').text();
				
				team_no = TEAM_NO;
				
				if(RES == '1') sessionStorage.setItem('surveychk', SNO);
			});
		}
	});
	return team_no;
}