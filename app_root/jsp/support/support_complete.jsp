<%@page import="db.dbconn"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/importhaed.jsp" %>
<div data-role="page" id="support_complete_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->			
		<div id ="support_complete_sec" data-role="content">
			<div class="spt_comp_div">
				<div class="spt_comp_header spt_success" style="display: none;">
					결제가 완료되었습니다.<br>
					응원 한 마디를 남겨주세요~
				</div>
				
				<div class="spt_comp_header spt_failed" style="display: none;">
					결제가 완료되지 않았습니다.<br>
					실제 결제는 되었는데 이 메시지가 뜬 경우 해피버스킹에 문의 부탁드리겠습니다.
				</div>
				
				<div class="spt_comp_footer" style="display: none;">
					<div class="spt_comp_footer_title">응원 한마디</div>
					<input type="text" id="spt_comp_msg" placeholder="아티스트에게 보낼 메시지를 입력해주세요.">
				</div>
			</div>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>