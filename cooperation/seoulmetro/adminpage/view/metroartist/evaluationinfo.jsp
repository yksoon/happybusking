<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/metroartist.css?ver=1.0.2" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/evaluationinfo.js?ver=1.0.5" ></script>
<body>
	<nav class="middle_wapper evaluationinfo_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle evaluationinfo">
		<div class="middle_title_wapper flex">
			<div class="mt_left">
				<select class="ft_20 ft_bold" id="ei_year">
					<option selected="selected">2020</option>
				</select>
				<p class="ft_20 ft_medium">년</p>
				<select class="ft_20 ft_bold mgleft" id="ei_month">
					<option selected="selected">02</option>
				</select>
				<p class="ft_20 ft_medium">월</p>
				<p class="ft_20 ft_medium"> 평가정보</p>
			</div>
			<select class="ft_14">
				<option selected="selected">전체</option>
			</select>
		</div>
		<div class="middle_cell_wapper">
			<table id="evaluationresults_table">
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