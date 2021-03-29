<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/metroartist.css?ver=1.0.2" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/serveyresults.js?ver=1.0.3" ></script>
<body>
	<nav class="middle_wapper serveyresults_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle serveyresults">
		<div class="middle_title_wapper flex">
			<p class="ft_20 ft_medium">설문결과</p>
			<select class="ft_14">
				<option selected="selected">전체</option>
			</select>
		</div>
		<div class="middle_cell_wapper">
			<table id="serveyresults_table">
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