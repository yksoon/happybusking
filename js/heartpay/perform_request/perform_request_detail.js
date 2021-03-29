//공연의뢰번호
var prqDetailTeamNo;
var performRequestGrpNo;
var prqDetailUserChk;

//공연의뢰 상세 페이지 이동
function perform_request_detailList(teamNo, pf_reqeust_no, userChk){
	prqDetailTeamNo = teamNo;
	performRequestGrpNo = pf_reqeust_no;
	//관람자쪽에 상세보기 들어간건지 아티스트쪽에서 상세보기 들어간건지 구분
	prqDetailUserChk = userChk;
	loadPage('perform_request/perform_request_detail.jsp');
}

//거절시 공연의뢰 상세 페이지 이동(뒤로가기 문제 : (ex: 거절완료 시 다시 거절 사유 입력하는 폼으로 이동하지 않기 위한)로 인한 구현)
function perform_request_detailList2(teamNo, pf_reqeust_no, userChk){
	prqDetailTeamNo = teamNo;
	performRequestGrpNo = pf_reqeust_no;
	//관람자쪽에 상세보기 들어간건지 아티스트쪽에서 상세보기 들어간건지 구분
	prqDetailUserChk = userChk;
	window.history.go(-1);
}



//공연의뢰 상세
$(document).on('pageinit', '#perform_request_detail', function(){
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/perform_request/perform_request_detail.jsp";
	var data = "team_no=" + prqDetailTeamNo +"&pf_request_no=" + performRequestGrpNo;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data : data,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				return;
			}
			
			$('#prqDetailPart').empty();
			
			var doc = 
				'<div class="prq_detail_teamname" >' +
					'<span id="prq_detail_teamName"></span> 공연 의뢰' +
				'</div>' +			
				'<div class="ui-grid-a prqDetailListContentCss">' +
					'<div class="ui-block-a">' +
						'<p>의뢰자명</p>' +
					'</div>' +
					'<div class="ui-block-b">' +
						'<p id="prq_detail_requestUser"></p>' +
					'</div>' +		
					'<div class="ui-block-a">' +
						'<p>의뢰팀</p>' +
					'</div>' +
					'<div class="ui-block-b">' +
						'<p id="prq_detail_requestTeam"></p>' +
					'</div>' +	
					'<div class="ui-block-a">' +
						'<p>공연 요청 날짜</p>' +
					'</div>' +
					'<div class="ui-block-b" id="prq_detail_requestDate">' +
					'</div>' +
					'<div class="ui-block-a">' +
						'<p>공연 요청 장소</p>' +
					'</div>' +
					'<div class="ui-block-b">' +
						'<p id="prq_detail_requestPlace"></p>' +
					'</div>' +	
					'<div class="ui-block-a">' +
						'<p>응답 날짜</p>' +
					'</div>' +
					'<div class="ui-block-b" id="prq_detail_requestTime">' +
					'</div>' +	
					'<div class="prqDetailLine"></div>'+
					'<div class="ui-block-a" id="prq_detail_msg_title">' +
						'<p>공연요청메시지</p>' +
					'</div>' +
					'<div class="ui-block-b" id="prq_detail_message">' +
					'</div>' +	
					'<div class="prqDetailLine" id="prq_detail_msg_line"></div>'+
					'<div class="ui-block-a">' +
						'<p class="prqDetailPriceCss">최종 의뢰 금액</p>' +
					'</div>' +
					'<div class="ui-block-b">' +
						'<p class="prqDetailPriceCss"><span class="prqDetailPrice"></span>원</p>' +
					'</div>' +					
				'</div>' +
				'<p class="prqDetailAddrTitle">공연 장비 지원 여부</p>' +
				'<div class="prqDetailAddrContent">' +
					'<div class="prqDetailEQSup" id="detail_eq_sup">' +
					'</div>' +
				'</div>' +
				'<p class="prqDetailAddrTitle">상세주소</p>' +
				'<div class="prqDetailAddrContent">' +
					'<div id="map">' +
					'</div>' +		
					'<p class="prqDetailPlace"></p>' +
					'<p id="prqDetailAddr"></p>' +
				'</div>';
			
			$('#prqDetailPart').append(doc);
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var PF_REQUEST_NO = $(this).find("PF_REQUEST_NO").text();
				var PF_REQUEST_GRP_NO = $(this).find("PF_REQUEST_GRP_NO").text();
				var USER_NAME = $(this).find("USER_NAME").text();
				var PF_REQUEST_SDATE = $(this).find("PF_REQUEST_SDATE").text();
				var PF_REQUEST_STIME = $(this).find("PF_REQUEST_STIME").text();
				var PF_REQUEST_EDATE = $(this).find("PF_REQUEST_EDATE").text();
				var PF_REQUEST_ETIME = $(this).find("PF_REQUEST_ETIME").text();
				var PF_REQUEST_ADDR = $(this).find("PF_REQUEST_ADDR").text();
				var PF_REQUEST_DETAIL_ADDR = $(this).find("PF_REQUEST_DETAIL_ADDR").text();
				var PF_REQUEST_RE_DATE = $(this).find("PF_REQUEST_RE_DATE").text();
				var PF_REQUEST_RE_TIME = $(this).find("PF_REQUEST_RE_TIME").text();
				var PF_REQUEST_MSG = $(this).find('PF_REQUEST_MSG').text();
				PF_REQUEST_MSG = changeLineBreak(PF_REQUEST_MSG);
				var PF_REQUEST_STATE = $(this).find("PF_REQUEST_STATE").text();
				var PF_REQUEST_CANCEL_MSG = $(this).find("PF_REQUEST_CANCEL_MSG").text();
				var PF_REQUEST_PRICE = $(this).find("PF_REQUEST_PRICE").text();
				var PF_REQUEST_EQ_SUP = changeLineBreak($(this).find("PF_REQUEST_EQ_SUP").text());
				var PF_REQUEST_LATLNG = $(this).find("PF_REQUEST_LATLNG").text();
				
				TEAM_NAME = "'" + TEAM_NAME + "'";
				
				var week = getDayOfTheWeek(PF_REQUEST_SDATE);
				
				var date = PF_REQUEST_SDATE + "(" + week  + ")" + " " + PF_REQUEST_STIME + "~" + PF_REQUEST_ETIME
				
				var redate = PF_REQUEST_RE_DATE + " " + PF_REQUEST_RE_TIME;
				
				var x = PF_REQUEST_LATLNG.split(',')[1];
				var y = PF_REQUEST_LATLNG.split(',')[0];
				
				PF_REQUEST_PRICE = addComma(PF_REQUEST_PRICE);

				if(PF_REQUEST_MSG == ''){
					$('#prq_detail_msg_title').hide();
					$('#prq_detail_message').hide();
					$('#prq_detail_msg_line').hide();
				} else {
					$('#prq_detail_message').html(PF_REQUEST_MSG);
				}
				
				if(prqDetailUserChk == 'U'){
					if(PF_REQUEST_STATE == "N"){
						$('#prqDetailPart').empty();
						PF_REQUEST_CANCEL_MSG = changeLineBreak(PF_REQUEST_CANCLE_MSG);
						
						var html = '<p class="prq_detailCancelMsg">' + PF_REQUEST_CANCEL_MSG + '</p>';
					
						$('#prqDetailPart').html(html);
						
						
					}else{
							$('#prq_detail_teamName').html(TEAM_NAME);
							$('#prq_detail_requestUser').html(USER_NAME);
							$('#prq_detail_requestTeam').html(TEAM_NAME);
							$('#prq_detail_requestDate').append('<p>' + date + '</p>');
							$('#prq_detail_requestPlace').html(PF_REQUEST_DETAIL_ADDR);
							$('.prqDetailPrice').html(PF_REQUEST_PRICE);
							$('.prqDetailPlace').html(PF_REQUEST_DETAIL_ADDR);
							$('#prqDetailAddr').html(PF_REQUEST_ADDR);
							$('#prq_detail_requestTime').html(redate);
							$('#detail_eq_sup').html(PF_REQUEST_EQ_SUP);
							
							getKakaoMap(x, y);

					}
					
				}else if(prqDetailUserChk == 'A'){
					if(PF_REQUEST_STATE == "P"){
						if(i == 0){
							var html = 
								'<div class="ui-grid-a prqDetailButton">'+
								'<div class="ui-block-a prqDetailBtnNo">'+
								'<p onclick="PerformRequest_nBtn('+ TEAM_NO + "," + PF_REQUEST_NO + ')">거절</p>'+
								'</div>'+
								'<div class="ui-block-b prqDetailBtnYes">'+
								'<p onclick="PerformRequest_yBtn('+ TEAM_NO + "," + PF_REQUEST_NO + ')">수락</p>'+
								'</div>'+				
								'</div>';		
							
							$('#prqDetailPart').append(html);
							
						}
						
							
							$('#prq_detail_teamName').html(TEAM_NAME);
							$('#prq_detail_requestUser').html(USER_NAME);
							$('#prq_detail_requestTeam').html(TEAM_NAME);
							$('#prq_detail_requestDate').append('<p>' + date + '</p>');
							$('#prq_detail_requestPlace').html(PF_REQUEST_DETAIL_ADDR);
							$('.prqDetailPrice').html(PF_REQUEST_PRICE);
							$('.prqDetailPlace').html(PF_REQUEST_DETAIL_ADDR);
							$('#prqDetailAddr').html(PF_REQUEST_ADDR);		
							$('#prq_detail_requestTime').html(redate);
							$('#detail_eq_sup').html(PF_REQUEST_EQ_SUP);
							getKakaoMap(x, y);
					}else{

							$('#prq_detail_teamName').html(TEAM_NAME);
							$('#prq_detail_requestUser').html(USER_NAME);
							$('#prq_detail_requestTeam').html(TEAM_NAME);
							$('#prq_detail_requestDate').append('<p>' + date + '</p>');
							$('#prq_detail_requestPlace').html(PF_REQUEST_DETAIL_ADDR);
							$('.prqDetailPrice').html(PF_REQUEST_PRICE);
							$('.prqDetailPlace').html(PF_REQUEST_DETAIL_ADDR);
							$('#prqDetailAddr').html(PF_REQUEST_ADDR);		
							$('#prq_detail_requestTime').html(redate);
							$('#detail_eq_sup').html(PF_REQUEST_EQ_SUP);
							getKakaoMap(x, y);
							
					}
					
				}
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });				
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});		
});


var prqNo_teamNo;
var prqNo_prqGrpNo;
//공연 의뢰 거절 시
function PerformRequest_nBtn(teamNo, prqGrpNo){
	var conf = confirm('공연 요청을 거절하시겠습니까 ?');
	
	if(!conf){
		return;
	}
	
	prqNo_teamNo = teamNo
	prqNo_prqGrpNo = prqGrpNo
	loadPage('perform_request/perform_request_refuse_msg.jsp');
		
}

//의뢰 거절 버튼 클릭 시
$(document).on('click', '#prq_refuse_btn', function(){
	var msg = $('#prq_refuse_area').val();
	msg = msg.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	if(msg == ''){
		alert('공연 요청 거절 사유를 입력해주세요.');
		return;
	}	
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/perform_request/perform_request_refuse.jsp";
	var data = "team_no=" + prqNo_teamNo + "&prq_grp_no=" + prqNo_prqGrpNo + "&prq_refuse_msg=" + msg;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data : data,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				return;
			}
			
			$(DATA).each(function(i) {
				/* XML 컬럼들 */
				var RESULT = $(this).find("RESULT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				if(RESULT == "true"){	
					alert(MESSAGE);
					perform_request_detailList2(prqNo_teamNo, prqNo_prqGrpNo,'A');
				
				}else if(RESULT == "false"){
					alert(MESSAGE);
					return;
				}
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});			

})

//의뢰 수락 시 
function PerformRequest_yBtn(teamNo, prqGrpNo){
	prqNo_teamNo = teamNo;
	prqNo_prqGrpNo = prqGrpNo;
	
	var conf = confirm('공연 의뢰를 수락하시겠습니까 ?');
	
	if(!conf){
		return;
	}
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/perform_request/perform_request_agree.jsp";
	var data = "team_no=" + prqNo_teamNo + "&prq_grp_no=" + prqNo_prqGrpNo;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		data : data,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				return;
			}
			
			$(DATA).each(function(i) {
				/* XML 컬럼들 */
				var RESULT = $(this).find("RESULT").text();
				var MESSAGE = $(this).find("MESSAGE").text();
				
				
				if(RESULT == "true"){	
					alert(MESSAGE);
					$('#perform_request_detail').trigger('pageinit');
					//perform_request_detailList(prqNo_teamNo, prqNo_prqGrpNo,'A');
				
				}else if(RESULT == "false"){
					alert(MESSAGE);
					return;
				}
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});			
}