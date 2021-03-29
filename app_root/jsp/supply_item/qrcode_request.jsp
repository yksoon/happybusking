<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="qrcode_request">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:center; padding: 0; overflow: unset;">
			<!-- <div data-history="false" data-role="popup" id="qrRequestPopup">
				<img id="qrp_image" src="/img/event/qr_request_popup.png">
				<div class="ui-grid-a">
					<div class="ui-block-a">
					</div>
					<div class="ui-block-b qrp_close_btn">
						<img id="qrRequestPopupClose2" src="/img/common/close.png">
						닫기
					</div>
				</div>
			</div> -->
			<div class="qrcode_request_info">
				<div class="qr_video_info_container">
					<div class="qr_video_info">
						<img src="/img/common/qr_help_3.png">
					</div>
					<div class="qr_video_chkbox_div">
						<p class="qr_video_chkbox_title">해피버스킹 QR이란?</p>
						
						<p class="qr_video_chkbox_text">팀/솔로를 식별하는 고유 코드를 가진 QR이 인쇄된 배너로써 관람객이 스마트폰으로 QR코드를 스캔하여 다음과 같은 기능으로 연결하는 해피버스킹의 서비스입니다.</p><br>
						
						<p class="qr_video_chkbox_text">1. 아티스트 소개 및 공연일정 확인<br>
														2. 신용카드, 계좌이체를 통하여 모바일팁 후원 및 공연티켓 구매<br>
														3. 공연후기, 팬커뮤니티 등을 통한 지속적인 관객과 소통</p>
														
						<p class="qr_video_chkbox_title">QR 신청 주의사항</p>
						<p class="qr_video_chkbox_text">* 아티스트 되기 후 팀·솔로 등록을 하여 아티스트 리스트에 보여지는 회원만 신청 가능.<br>
														* 팀·솔로  등록/수정 페이지에서 유튜브 링크를 첨부<br>
														&#32;&#32;&#32;&#32;※유튜브 계정이 없는 경우 <span style="font-weight: bold;">contact@happybusking.com</span> 이메일로 동영상 제출.<br>
														* 등록된 동영상이 선정적이거나 유해한 경우 접수가 불가.</p>
														
						<p class="qr_video_chkbox_title2">등록한 동영상이 해피버스킹 유튜브 채널에 노출되는 것에 동의하시겠습니까?</p>
						<p class="qr_video_chkbox_text">(동의 시 동영상에 QR코드가 삽입되어 재생되며, QR배너와 동일한 기능 제공)</p>
						
						<input type="radio" name="qr_reqeust_radio" id="qr_request_yes" value="Y" checked="checked"><label for="qr_request_yes">동의합니다</label>
						<input type="radio" name="qr_reqeust_radio" id="qr_request_no" value="N"><label for="qr_request_no">동의하지 않습니다</label>
					</div>
				</div>
				
				<div class="common_form_header_title">
					배너 수령지 정보
				</div>
				
				<div class="common_form_main_title">
					팀이름선택
				</div>
				<div class="common_form_default_select_div" id="qrRequest-select-box">
					<select name="qr-team-select" id="qr-team-select">
						<option value="">팀 이름을 선택하세요</option>
					</select>
				</div>
				
				<div class="common_form_main_title">
					QR배너 사이즈 선택
				</div>
				<div class="common_form_default_select_div" id="qrRequest-box">
					<select name="qr-select" id="qr-select">
						<option value="" selected="selected" disabled="disabled">QR배너 사이즈를  선택하세요</option>
						<option value="A">400X1200(mm) - 거치대포함</option>
						<option value="B">500x1600(mm) - 배너만 제공(거치대별도구매)</option>
						<option value="C">600x1800(mm) - 배너만 제공(거치대별도구매)</option>
					</select>
				</div>
				
				<div class="common_form_main_title">
					우편번호
				</div>
				<div class="common_form_input_div">
					<input type="text" id="postcode" readonly="readonly" placeholder="주소를 검색하면 자동으로 입력됩니다.">
				</div>
				
				<div class="common_form_main_title">
					주소
				</div>
				<div class="common_form_input_div common_flex_container">
					<div class="common_form_input_div_left">
						<input type="text" id="address" placeholder="ex) 여의도동"></input>
					</div>
					<div class="common_form_input_div_right" id="qrRequest_btn" onclick="open_execDaumPostcode('qrRequest_addr_layer')">
						검색
					</div>
				</div>
				<div id="qrRequest_addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
					<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1;" onclick="closeDaumPostcode('qrRequest_addr_layer')" alt="닫기 버튼">
				</div>
				
				<div class="common_form_main_title">
					상세주소
				</div>		
				<div class="common_form_input_div">
					<input type="text" id="qrRequest_detail_addr" placeholder="상세주소를 입력해주세요">
				</div>
				
				<div class="common_form_main_title" id="useagree_title">
					이용약관
				</div>	
				<div class="common_terms_container">
					<div class="common_terms_all_check common_flex_container">
						<input type="checkbox" id="qr_total_checkbox" data-role="none">
						<label for="qr_total_checkbox">아래 약관에 모두 동의합니다</label>
					</div>
					<div class="common_terms_check common_flex_container">
							<input type="checkbox" id="qr_delivery_checkbox" data-role="none">
							<label for="qr_delivery_checkbox">QR코드 배너 배송정책 동의</label>
							<div class="common_terms_view_more" id="delivery_view">보기</div>
					</div>
					<div class="common_terms_check common_flex_container">
							<input type="checkbox" id="qr_request_service_checkbox" data-role="none">
							<label for="qr_request_service_checkbox">QR코드 배너 신청 이용약관</label>
							<div class="common_terms_view_more" id="qr_requset_service_view">보기</div>
					</div>
					<div class="common_terms_check common_flex_container">
							<input type="checkbox" id="qr_consignment_checkbox" data-role="none">
							<label for="qr_consignment_checkbox">개인정보의 제3자제공 및 위탁동의</label>
							<div class="common_terms_view_more" id="consignment_view">보기</div>
					</div>
				</div>
				
				<div style="margin-top: 55px;">
					<p class="common_form_under_title" style="padding:15px; background-color: #f6f6f6;">
						고객센터 상담 가능 시간 : 평일 09:00 ~ 17:00 (주말, 공휴일 제외)<br>
						TEL.  02-780-2330<br>
						EMAIL. contact@happybusking.com<br>
					</p>
				</div>
			</div>
			<!-- QR신청 유료 전환 후 -->
			<div class="qrcode_request_payment" style="display: none;">
				<div class="common_form_main_title">
					결제 방법
				</div>
				<div class="common_form_default_select_div">
					<select id="kiwoompay_method">
						<!-- 결제방법 추가할때마다 option 추가하고, function만들어서 해당 결제방법 url 에 연동해줘야함. test.js -->
						<option selected="" disabled="" hidden="">결제 방법을 선택해주세요.</option>
						<option value="CARD">카드</option>
						<option value="BANK">계좌이체</option>
						<option value="VAACOUNT">가상계좌</option>
						<option value="MOBILE">핸드폰</option>
						<option value="CULTURE">문화상품권</option>
						<option value="HAPPY">해피머니상품권</option>
						<option value="BOOK">도서문화상품권</option>
						<option value="TMONEY">티머니</option>
					</select>
				</div>
				
				<form name="frmConfirm" action="" accept-charset="EUC-KR"> 
				<!-- CPID --><input type="hidden" name="CPID" size="50" maxlength="50"value="CBI36132">
				<!-- 주문번호 --><input type="hidden" name="ORDERNO" size="50" maxlength="50"value="">
				<!-- 상품구분 --><input type="hidden" name="PRODUCTTYPE" size="10" maxlength="2" value="1">
				<!-- 과금유형 --><input type="hidden" name="BILLTYPE" size="10" maxlength="2"  value="1">
				<div class="common_form_main_title">
					결제 금액
				</div>
				<div class="common_form_input_div">
					<input type="text" name="AMOUNT_TEXT" id="AMOUNT_TEXT" size="10" maxlength="10" value="20,000원" readonly="readonly">
					<input type="hidden" name="AMOUNT" id="AMOUNT" size="10" maxlength="10" value="20000" onkeyup="fnNumCheck();">
				</div>
				<!-- 상품명  --><input type="hidden" name="PRODUCTNAME" id="PRODUCTNAME" size="50" value="X배너(중)">
				
				<div class="qr_payment_price_container">
					<div class="qr_payment_price qrp_on" id="20000&X배너(중)">사이즈 중: 20,000원</div>
					<div class="qr_payment_price" id="23000&X배너(대)">사이즈 대: 23,000원</div>
				</div>
				
				<div class="common_form_main_title">
					고객 E-MAIL
				</div>
				<div class="common_form_input_div">
					<input type="text" name="EMAIL" id="EMAIL" size="100" maxlength="100">
				</div>
				<div class="common_form_main_title">
					고객명
				</div>
				<div class="common_form_input_div">
					<input type="text" name="USERNAME" id="USERNAME" size="50" maxlength="50">
				</div>
				<!-- CLOSE URL --><input type="hidden" name="CLOSEURL" value="https://www.happybusking.com/app_root/jsp/supply_item/qrcode_request.jsp">
				<!-- RETURN URL --><input type="hidden" name="HOMEURL" value="https://www.happybusking.com/app_root/jsp/supply_item/qrcode_request_list.jsp">
				<!-- RETURN URL --><input type="hidden" name="FAILURL" value="https://www.happybusking.com/app_root/">
				
				<input type="hidden" name="DIRECTRESULTFLAG" value="N">
				<input type="hidden" name="PRODUCTCODE" id="PRODUCTCODE">
				<!--비과세결제유무(과세 테스트 <font color='blue'>00</font>, 비과세 테스트 : <font color='red'>01</font>):  --><input type="hidden" name="TAXFREECD" value="00">
				<input class="common_InsertBtnForm" name="btnSubmit" id="btnSubmit" type="button" data-role="none" value="결제하기" style="display: none" onclick="fnSubmit();">
				</form>
				
				<div class="common_form_main_title" id="useagree_title">
					이용약관
				</div>	
				<div class="common_terms_container">
					<div class="common_terms_all_check common_flex_container">
						<input type="checkbox" id="qr_total_checkbox" data-role="none">
						<label for="qr_total_checkbox">아래 약관에 모두 동의합니다</label>
					</div>
					<div class="common_terms_check common_flex_container">
							<input type="checkbox" id="qr_delivery_checkbox" data-role="none">
							<label for="qr_delivery_checkbox">QR코드 배너 배송정책 동의</label>
							<div class="common_terms_view_more" id="delivery_view">보기</div>
					</div>
					<div class="common_terms_check common_flex_container">
							<input type="checkbox" id="qr_request_service_checkbox" data-role="none">
							<label for="qr_request_service_checkbox">QR코드 배너 신청 이용약관</label>
							<div class="common_terms_view_more" id="qr_requset_service_view">보기</div>
					</div>
					<div class="common_terms_check common_flex_container">
							<input type="checkbox" id="qr_consignment_checkbox" data-role="none">
							<label for="qr_consignment_checkbox">개인정보의 제3자제공 및 위탁동의</label>
							<div class="common_terms_view_more" id="consignment_view">보기</div>
					</div>
				</div>
				
				<div style="margin-top: 55px;">
					<p class="common_form_under_title" style="padding:15px; background-color: #f6f6f6;">
						고객센터 상담 가능 시간 : 평일 09:00 ~ 17:00 (주말, 공휴일 제외)<br>
						TEL.  02-780-2330<br>
						EMAIL. contact@happybusking.com<br>
					</p>
				</div>
			</div>
		</div>		
		<!-- 약관 자세히보기 팝업 통합 -->
		<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
	
	<script type="text/javascript">
	var pf;
	
	function fnSubmit() {
		pf = document.frmConfirm
		pf.ORDERNO.value= getTimeStamp();
		
		var fileName;
		var typeChk = $('#kiwoompay_method').val();
		if(typeChk == '' || typeChk == undefined || typeChk == 'undefined'){
			alert('결제 수단을 선택해주세요.');
			$('#kiwoompay_method').focus();
			return;
		} else if(typeChk == 'CARD'){
			//카드결제
			fileName = "https://ssl.kiwoompay.co.kr/m/card/DaouCardMng.jsp";	
		} else if(typeChk == 'BANK'){
			//계좌이체
			fileName = "https://ssl.kiwoompay.co.kr/m/bank2/DaouBankMng.jsp";
		} else if(typeChk == 'MOBILE'){
			//핸드폰결제
			fileName = "https://ssl.kiwoompay.co.kr/m/mobile/DaouMobileMng.jsp";
		} else if(typeChk == 'CULTURE'){
			//문화상품권 결제
			fileName = "https://ssl.kiwoompay.co.kr/m/culture/CultureMng.jsp";
		} else if(typeChk == 'HAPPY'){
			//해피머니상품권 결제
			fileName = "https://ssl.kiwoompay.co.kr/m/happymoney/DaouHappyMoneyMng.jsp";
		} else if(typeChk == 'BOOK'){
			//도서문화상품권 결제
			fileName = "https://ssl.kiwoompay.co.kr/m/book/BookMng.jsp";
		} else if(typeChk == 'VAACOUNT'){
			//가상계좌 결제
			fileName = "http://ssl.kiwoompay.co.kr/m/vaccount/DaouVaccountMng.jsp";
		} else if(typeChk == 'TMONEY'){
			//티머니 결제
			fileName = "https://ssl.kiwoompay.co.kr/m/tmoney/DaouTmoneyMng.jsp";
		}
		
		var UserAgent = navigator.userAgent;
		
		window.open = cordova.InAppBrowser.open;
		
		if (UserAgent.match(/iPhone|iPod|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null){
			KIWOOMPAY = window.open("", "KIWOOMPAY", "fullscreen");
			pf.target = "KIWOOMPAY";
		}else{
			KIWOOMPAY = window.open("", "KIWOOMPAY", "width=579,height=527");
			pf.target = "KIWOOMPAY";
		}
		pf.action = fileName;
		pf.method = "post";
		pf.submit();
	}

	function fnCheck() {	

		var frm = document.frmConfirm;
		
		//주문번호
		if(trim(frm.ORDERNO.value) == "" || getByteLen(frm.ORDERNO.value) > 50) {
			alert("주문번호 (ORDERNO) 를 입력해주세요. (최대:50byte, 현재:" + getByteLen(frm.ORDERNO.value) + ")");
			return;
		}
		//상품구분
		if(trim(frm.PRODUCTTYPE.value) == "" || getByteLen(frm.PRODUCTTYPE.value) > 2) {
			alert("상품구분 (PRODUCTTYPE) 를 입력해주세요. (최대:2byte, 현재:" + getByteLen(frm.PRODUCTTYPE.value) + ")");
			return;
		}
		//과금유형
		if(trim(frm.BILLTYPE.value) == "" || getByteLen(frm.BILLTYPE.value) > 2) {
			alert("과금유형 (BILLTYPE) 를 입력해주세요. (최대:2byte, 현재:" + getByteLen(frm.BILLTYPE.value) + ")");
			return;
		}
		//결제금액
		if(trim(frm.AMOUNT.value) == "" || getByteLen(frm.AMOUNT.value) > 10) {
			alert("결제금액 (AMOUNT) 를 입력해주세요. (최대:10byte, 현재:" + getByteLen(frm.AMOUNT.value) + ")");
			return;
			
		}
		/********************  필수 입력 체크 끝  ***/
	}

		   
	function trim(txt) {
		while (txt.indexOf(' ') >= 0) {
			txt = txt.replace(' ','');
		}
		return txt;
	}

	function getTimeStamp() {
		var d = new Date();
		var month = d.getMonth() + 1;
		var date = d.getDate();
		var hour = d.getHours();
		var minute = d.getMinutes();
		var second = d.getSeconds();

		month = (month < 10 ? "0" : "") + month;
		date = (date < 10 ? "0" : "") + date;
		hour = (hour < 10 ? "0" : "") + hour;
		minute = (minute < 10 ? "0" : "") + minute;
		second = (second < 10 ? "0" : "") + second;

		var s = d.getFullYear() + month + date + hour + minute + second;

		return s;
	}

	function getByteLen(p_val) {
		var onechar;
		var tcount = 0;
		
		for(i = 0; i < p_val.length; i++) {
			onechar = p_val.charAt(i);
			if(escape(onechar).length > 4)
				tcount += 2;
			else if(onechar != '\r')
				tcount++;
		}
		return tcount;
	}

	function fnNumCheck() {
		if(event.keyCode >= 48 && event.keyCode <= 57)
			event.returnValue = true;
		else
			event.returnValue = false;
	}
	</script>
</div>

