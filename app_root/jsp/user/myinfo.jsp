<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="myinfo" >
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div data-role="content" id="myinfoContent" style="padding: 0px;">
		<p class="common_form_header_title">기본정보수정</p>
		<div class="common_form_main_title">
			아이디
		</div>
		<div class="common_form_input_div">
			<input type="text" id="myinfo_Email" name="myinfo_Email"  readonly="readonly">
		</div>	
		<div class="common_form_main_title">
			닉네임
		</div>
		<div class="common_form_input_div">
			<input type="text" id="myinfo_Nicname" name="myinfo_Nicname" placeholder="닉네임을 입력해주세요">
		</div>	
		<div class="common_UpdateBtnForm" id="myinfoUpdateBtn">
			수정완료
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>