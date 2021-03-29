<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%
//상점 IP 셋팅 <MallIP 셋팅>
InetAddress inet = InetAddress.getLocalHost();
String payActionUrl = "https://pg.innopay.co.kr";    

if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    payActionUrl = request.getScheme() + "://" + request.getServerName() ;
} else {
    payActionUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
}   
%>

<%@include file="/importhaed.jsp" %>

<div data-role="page" id="support_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->		
	<div id="support_sec" data-role="content">
		<form action="" name="frm" id="frm" method="post">
			<div class="support_body" style="border-top:1px solid #eee;">
				<div class="spt_main_title">결제 수단 선택</div>
				<div class="spt_sub_title">결제수단선택</div>
				<div class="ui-grid-a">
					<div class="ui-block-a spt_payway spt_payway_select" id="CARD">신용카드</div>
					<div class="ui-block-b spt_payway" id="BANK">계좌이체</div>
					
					<select style="width: 100%; display: none;" name="PayMethod" id="PayMethod" >
                        <option value="CARD">신용카드</option>
                        <option value="BANK">계좌이체</option>
                    </select>
				</div>
			</div>
			<div class="support_body">
				<div class="spt_main_title">기본 정보 입력</div>
				<div class="spt_sub_title">연락처</div>
				<input type="text" name="BuyerTel" id="BuyerTel" placeholder="연락처를 입력해주세요.(- 제외)">
				
				<div class="spt_sub_title">메일주소</div>
				<input type="text" name="BuyerEmail" id="BuyerEmail" placeholder="결제 내역을 받기 위한 메일 주소를 입력해주세요.">
			</div>
			<div class="support_body support_body_last">
				<div class="spt_main_title">후원 정보 입력</div>
				<div class="spt_sub_title">후원자명</div>
				<input type="text" name="BuyerName" id="BuyerName" placeholder="후원하시는분의 성함을 입력해주세요.">
				
				<div class="spt_sub_title">결제 금액</div>
				<div class="spt_input_div">
					<input type="text" name="Amt" id="Amt" placeholder="결제 금액을 입력해주세요.(최소 2,000원)" onKeyUp="javascript:numOnly(this,document.frm,false);">
					<span class="spt_input_text">원</span>
				</div>
			</div>
			<input type="hidden" name="Moid" id ="Moid" value=""> <!-- 가맹점에서 사용하는 주문 번호 -->
			
			<input type="hidden" name="ReturnURL" value="http://happybusking.com/app_root/jsp/support/support_complete.jsp">
			<input type="hidden" name="ResultYN" value="N">
			<input type="hidden" name="FORWARD" value="N">
			<input type="hidden" name="GoodsCnt" value="1">
			<input type="hidden" name="GoodsName" value="tip">
			
			<input type="hidden" name="MID" value="testpay01m"> <!-- 상점 MID 입력 -->
			<input type="hidden" name="ediDate" value=""> <!-- js 내 setEdiDate 함수 사용 -->
			<input type="hidden" name="MerchantKey" value="Ma29gyAFhvv/+e4/AHpV6pISQIvSKziLIbrNoXPbRS5nfTx2DOs8OJve+NzwyoaQ8p9Uy1AN4S1I0Um5v7oNUg=="> <!-- 발급된 가맹점키 -->
			<input type="hidden" name="EncryptData" value=""> <!-- 암호화데이터 -->
			
			<input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/> <!-- 가맹점서버 IP 가맹점에서 설정-->
		    <input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>"> <!-- 구매자 IP 가맹점에서 설정-->
		    
		    <input type="hidden" name="MallResultFWD" value="Y"> <!-- Y 인 경우 PG결제결과창을 보이지 않음 -->
		    <input type="hidden" name="device" value=""> <!-- 자동셋팅 -->
		</form>
		<input type="hidden" id="team_no">
	</div>
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>