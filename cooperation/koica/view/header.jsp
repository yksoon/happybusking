<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String headerImagePath = "/cooperation/koica/img";
	String[] mainPathChkArray = request.getRequestURI().split("/");
	String mainPathChk = mainPathChkArray[mainPathChkArray.length - 1];
	String[] subPathChkArray = mainPathChk.split("\\?");
	
	String subPathChk = subPathChkArray[0];
%>
<%if(mainPathChk.equals("index.jsp") || mainPathChk.equals("koica")) {%>
<!-- 메인부분 헤더 -->
<header>
	<div class="header_wapper">
		<div class="hw_image_container" onclick="location.href='/cooperation/koica'"><img src="<%=headerImagePath %>/logo-hb1.svg"></div>
		<img class="hw_panel_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/menu.svg">
	</div>
</header>

<% } else if(subPathChk.equals("pdetail.jsp")){ %>
<!-- 헤더 투명해야하는 부분 -->
<header>
	<div class="header_wapper">
		<div class="hw_left">
			<img class="hw_back_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/back.svg" onclick="history.go(-1);">
		</div>
		<div class="hw_right">
			<img class="hw_cart_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/cart.svg">
			<img class="hw_panel_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/menu.svg">
		</div>
	</div>
</header>

<% } else if(subPathChk.equals("partners.jsp")) { %>
<!-- 헤더 불투명해야하는 부분 -->
<header class="white_background">
	<div class="header_wapper_2">
		<div class="hw_left">
			<img class="hw_back_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/back_2.svg" onclick="history.go(-1);">
		</div>
		<div class="hw_right">
			<%-- <img class="hw_cart_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/cart.svg"> --%>
			<img class="hw_panel_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/menu_2.svg">
		</div>
	</div>
</header>	
		
<% } else { %>

<!-- 헤더 불투명해야하는 부분 -->
<header class="white_background">
	<div class="header_wapper_2">
		<div class="hw_left">
			<%-- <img class="hw_home_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/back_2.svg"  onclick="location.href='/cooperation/iseoulu'"> --%>
		</div>
		<div class="hw_right">
			<img class="hw_cart_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/cart_2.svg">
			<img class="hw_panel_btn" style="cursor: pointer;" src="<%=headerImagePath %>/icon/menu_2.svg">
		</div>
	</div>
</header>	

<% } %>