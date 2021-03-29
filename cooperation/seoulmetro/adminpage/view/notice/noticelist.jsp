<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/notice.js?ver=1.0.6" ></script>
<body>
	<nav class="middle_wapper notice_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle notice">
		<div class="middle_title_wapper flex">
			<p class="ft_20 ft_medium">공지사항</p>
			<select class="ft_14">
				<option selected="selected">전체</option>
			</select>
		</div>
		<div class="middle_cell_wapper">
			<table id="noticelist_table">
			</table>
		</div>
		<div class="middle_pagenum_wapper">
			<div class="middle_pagenum flex" id="paging">
			</div>
		</div>
	</nav>
	</nav>
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/footer.jsp" %>
</body>
</html>