<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="support_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="support_sec" data-role="content">
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
		<form action="" name="frm" id="frm" method="post" accept-charset="EUC-KR">
				<!-- CPID --><input type="hidden" name="CPID" size="50" maxlength="50"value="CBI36132">
				<!-- 주문번호 --><input type="hidden" name="ORDERNO" size="50" maxlength="50"value="">
				<!-- 상품구분 --><input type="hidden" name="PRODUCTTYPE" size="10" maxlength="2" value="1">
				<!-- 과금유형 --><input type="hidden" name="BILLTYPE" size="10" maxlength="2"  value="1">
				<div class="common_form_main_title">
					결제 금액
				</div>
				<div class="common_form_input_div">
					<input type="text" name="AMOUNT_TEXT" id="AMOUNT_TEXT" size="10" maxlength="10" readonly="readonly" value="0원">
					<input type="hidden" name="AMOUNT" id="AMOUNT" size="10" maxlength="10" value="0" onkeyup="fnNumCheck();">
				</div>
				<!-- 상품명  --><input type="hidden" name="PRODUCTNAME" id="PRODUCTNAME" size="50" value="모바일팁">
				
				<div class="spt_amt_btn_container">
					<div class="spt_amt_btn spt_amt_plus">+1000</div>
					<div class="spt_amt_btn spt_amt_plus">+5000</div>
					<div class="spt_amt_btn spt_amt_plus">+10000</div>
					<div class="spt_amt_btn spt_amt_minus">-1000</div>
					<div class="spt_amt_btn spt_amt_minus">-5000</div>
					<div class="spt_amt_btn spt_amt_minus">-10000</div>
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
				<div class="common_form_main_title">
					연락처 (선택사항)
				</div>
				<div class="common_form_input_div">
					<input type="text" name="TEL" id="TEL" size="50" maxlength="50" placeholder="결제 이상시 연락 가능한 번호를 입력해주세요.">
				</div>
				<!-- CLOSE URL --><input type="hidden" name="CLOSEURL" value="https://www.happybusking.com/app_root/">
				<!-- RETURN URL --><input type="hidden" name="HOMEURL" value="https://www.happybusking.com/app_root/jsp/support/support_complete.jsp">
				<!-- RETURN URL --><input type="hidden" name="FAILURL" value="https://www.happybusking.com/app_root/">
				
				<input type="hidden" name="DIRECTRESULTFLAG" value="N">
				<input type="hidden" name="PRODUCTCODE" id="PRODUCTCODE">
			<!--비과세결제유무(과세 테스트 <font color='blue'>00</font>, 비과세 테스트 : <font color='red'>01</font>):  --><input type="hidden" name="TAXFREECD" value="00">
			<input class="common_InsertBtnForm" name="btnSubmit" id="btnSubmit" type="button" data-role="none" value="결제하기" style="display: none" onclick="fnSubmit();">
		</form>
		
		<div class="common_form_main_title">
			이용약관
		</div>
		
		<div class="common_terms_container">
			<div class="common_terms_check common_flex_container">
					<input type="checkbox" id="sp_consignment_checkbox" data-role="none">
					<label for="sp_consignment_checkbox">개인정보의 제3자제공 및 위탁동의</label>
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
			
		<input type="hidden" id="team_no">
		
		<!-- 약관 자세히보기 팝업 통합 -->
		<div data-role="popup" class="common_trems_popup_container" id="terms_popup">
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
	<script type="text/javascript">
	var pf;
	
	function fnSubmit() {
		pf = document.frm
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
		
		// window.open = cordova.InAppBrowser.open;
		var ref = cordova.InAppBrowser.open;
		
		if (UserAgent.match(/iPhone|iPod|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null){
			// KIWOOMPAY = window.open("", "KIWOOMPAY", "fullscreen");
			// KIWOOMPAY = ref("", "_blank", "fullscreen");
			// pf.target = "KIWOOMPAY";
		}else{
			// KIWOOMPAY = window.open("", "KIWOOMPAY", "width=579,height=527");
			KIWOOMPAY = ref("", "KIWOOMPAY", "width=579,height=527");
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