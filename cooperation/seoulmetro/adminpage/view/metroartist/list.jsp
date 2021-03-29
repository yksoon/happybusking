<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/metroartist.css?ver=1.0.4" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/metroartist.js?ver=1.0.5" ></script>
<body>
	<nav class="middle_wapper metroartist_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle metroartist">
		<div class="middle_title_wapper flex">
			<select class="ft_20 ft_medium" id="change_sub_menu">
				<option selected="selected" value="1">소속 아티스트 정보</option>
				<option value="2">신청 관리</option>
			</select>
			<select class="ft_14">
				<option selected="selected">전체</option>
			</select>
		</div>
		<div class="middle_cell_wapper">
			<table id="metroartist_table">
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