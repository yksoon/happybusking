<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="user_write_review">
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>

	<div data-role="content" style="padding: 0;">
		<form id = "fileform" method="post" enctype = "multipart/form-data">
			<input type="hidden" id="user_no" name="user_no" value="<%=USER_NO %>">
			<input type="hidden" id="pf_no" name="pf_no">
			<input type="hidden" id="team_no" name="team_no">
			<div id="uwr_img_form"
				style="">
				<div id="uwr_title" style="text-align: center;">
					<span id="uwr_title_btn">관람한공연</span>
					<span class="uwr_title_tname" id="team_pf_name"></span>
				</div>

				<div id="uwr_img_cont">
			
				</div>
				<div class="uwr_file_div">
					<input type="file" id="img_file" name="img_file" accept="image/*" onchange = "loadFile(event);">
				</div>
				<div>
					<div id="uwr_rating_title">< 평가하기 ></div>
					<div class="stars stars-example-fontawesome">
						<select class="rating" name="rating" autocomplete="off" id="rrating">
							<option value="1">1</option>
							  <option value="2">2</option>
							  <option value="3">3</option>
							  <option value="4">4</option>
							  <option value="5">5</option>
						</select>
					</div>
					<div id="starnum"></div>
					<input type="hidden" id = "starrate" name="starrate">
				</div>
			</div>

			<div id="uwr_text_form" style="">
				<input id="rtitle" name="rtitle" type="text" placeholder="제목을 입력해주세요">
				<textarea id="rcontent" name="rcontent" cols="40" rows="8" placeholder="후기를 입력해주세요"></textarea>
			</div>
		</form>
	</div>
<%@include file="/app_root/jsp/footer/footer.jsp" %>
<script type="text/javascript">
$(function() {
    $('.rating').barrating({
		theme: 'fontawesome-stars',
		showSelectedRating: false,
		onSelect: function(value, text, event) {
		    if (typeof(event) !== 'undefined') {
				$("#starnum").text(value + " / 5");
				$("#starrate").val(value);
		    } else {
		      // rating was selected programmatically
		      // by calling `set` method
			}
		}
    });
 });
</script>

</div>
