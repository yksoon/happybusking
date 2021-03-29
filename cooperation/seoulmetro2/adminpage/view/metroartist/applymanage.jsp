<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/metroartist.css?ver=1.0.4" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/applymanage.js?ver=1.0.6" ></script>
<body>
	<nav class="middle_wapper applymanage_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle applymanage">
		<div class="middle_title_wapper flex">
			<select class="ft_20 ft_medium" id="change_sub_menu">
				<option value="1">소속 아티스트 정보</option>
				<option selected="selected" value="2">신청 관리</option>
			</select>
			<select class="ft_14">
				<option selected="selected">전체</option>
			</select>
		</div>
		<div class="middle_cell_wapper">
			<table id="applymanage_table">
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