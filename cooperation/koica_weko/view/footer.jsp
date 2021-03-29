<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link type="text/css" rel="stylesheet" href="/cooperation/iseoulu/css/footer.css" />
<script type="text/javascript" src="/cooperation/iseoulu/js/footer.js" ></script>

<%
	String headerImagePath2 = "/cooperation/iseoulu/img";
	String[] mainPathChkArray2 = request.getRequestURI().split("/");
	String mainPathChk2 = mainPathChkArray2[mainPathChkArray2.length - 1];
	String[] subPathChkArray2 = mainPathChk2.split("\\?");
	
	String subPathChk2 = subPathChkArray2[0];
%>

<footer>
	<%if(subPathChk2.equals("pdetail.jsp")){ %>
		<p class="pd_cart_btn white_background"><img src="<%=headerImagePath2%>/icon/cart_2.svg">담기</p>
		<p class="pd_buy_btn white_point">구매하기</p>
	<% } %>
</footer>