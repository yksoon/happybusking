<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/cooperation/seoulmetro/adminpage/importhead.jsp" %>
<!DOCTYPE html>
<html>
<link type="text/css" rel="stylesheet" href="/cooperation/seoulmetro/adminpage/resource/css/notice.css?ver=1.0.0" />
<script type="text/javascript" src="/cooperation/seoulmetro/adminpage/resource/js/active/noticedetail.js?ver=1.0.3" ></script>
<body>
	<nav class="middle_wapper noticedetail_wapper">
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/header.jsp" %>
	<nav class="middle noticedetail">
		<p class="ft_20 ft_medium detail_title">공지사항</p>
		<div class="flex bg_l_gray detail_table_a">
			<p class="ft_15 ft_medium" id="nd_title"></p>
			<p class="ft_14 ft_l_gray_d" id="nd_nickname"></p>
		</div>
		<p class="ft_14 ft_l_gray_d detail_date" id="nd_date"></p>
		<div class="ft_15 ft_light detail_content" id="nd_content">
		</div>
		<table class="detail_table">
			<tr class="dt_item dt_prev">
				<td class="ft_15 cursorpointer detail_table_left">이전글</td>
				<td class="ft_15 cursorpointer detail_table_center" id="prev_title"></td>
				<td class="ft_15 cursorpointer detail_table_right" id="prev_date"></td>
			</tr>
			<tr class="dt_item dt_next">
				<td class="ft_15 cursorpointer detail_table_left">다음글</td>
				<td class="ft_15 cursorpointer detail_table_center" id="next_title"></td>
				<td class="ft_15 cursorpointer detail_table_right" id="next_date"></td>
			</tr>
		</table>
		<p class="ft_14 bg_purple ft_white detail_btn cursorpointer goNotice">목록으로</p>
	</nav>
	</nav>
	<%@include file="/cooperation/seoulmetro/adminpage/tracker/footer.jsp" %>
</body>
</html>