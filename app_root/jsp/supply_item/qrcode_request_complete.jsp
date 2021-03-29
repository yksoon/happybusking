<%@page import="db.dbconn"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/importhaed.jsp" %>

<%
	//request.setCharacterEncoding("utf-8");
	String PayMethod = request.getParameter("PayMethod")==null?"":request.getParameter("PayMethod");
	String name = request.getParameter("name")==null?"":request.getParameter("name"); // 구매자명
	String Amt = request.getParameter("Amt")==null?"":request.getParameter("Amt"); // 결제금액
	String TID = request.getParameter("TID")==null?"":request.getParameter("TID"); // 결제금액

	String ResultCode = request.getParameter("ResultCode")==null?"":request.getParameter("ResultCode");
	String ResultMsg = request.getParameter("ResultMsg")==null?"":request.getParameter("ResultMsg");
	String AuthDate	= request.getParameter("AuthDate")==null?"":request.getParameter("AuthDate");
	
	String fn_name	= request.getParameter("fn_name")==null?"":request.getParameter("fn_name"); 
	String BankName = request.getParameter("BankName")==null?"":request.getParameter("BankName");
%>

<div data-role="page" id="qrcode_request_complete_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<input type="hidden" id="Amt" value="<%=Amt %>">
		<input type="hidden" id="TID" value="<%=TID %>">
		<input type="hidden" id="ResultCode" value="<%=ResultCode %>">
		<input type="hidden" id="qr_request_no">
		
		<div id ="qrcode_request_complete_sec" data-role="content">
			<%if(ResultCode.equals("3001")||"4000".equals(ResultCode)||"4100".equals(ResultCode)){ %>
			<div class="qrb_comp_div">
				<div class="qrb_comp_header">
					<span class="qrb_comp_name"><%=name %></span>
					님 결제가 완료되었습니다.<br>
				</div>
				<div class="qrb_comp_body">
					<div class="ui-grid-a qrb_comp_content">
						<div class="ui-block-a qrb_comp_content_title">결제일시</div>
						<div class="ui-block-b qrb_comp_content_subject"><%=AuthDate %></div>
						<%if(PayMethod.equals("CARD")) { %>
						<div class="ui-block-a qrb_comp_content_title">신용카드</div>
						<div class="ui-block-b qrb_comp_content_subject"><%=fn_name %></div>
						<%} else { %>
						<div class="ui-block-a qrb_comp_content_title">계좌이체</div>
						<div class="ui-block-b qrb_comp_content_subject"><%=BankName %></div>
						<%} %>
					</div>
					<div class="ui-grid-a qrb_comp_price">
						<div class="ui-block-a qrb_comp_price_title">최종 결제 금액</div>
						<div class="ui-block-b qrb_comp_price_content"><span><%=Amt %></span>원</div>
					</div>
				</div>
			</div>
			<%} else { %>
			<div class="qrb_fail_div">
				<div class="qrb_comp_header">
					<span class="qrb_comp_name"><%=name %></span>
					님 결제를 실패했습니다.<br>
				</div>
				<div class="qrb_fail_body">
					결제 실패 사유 : 
					<span><%=ResultMsg %></span>
				</div>
			</div>
			<%} %>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>