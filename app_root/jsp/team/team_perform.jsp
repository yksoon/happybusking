<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="team_perform">

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	<!-- content 부분 -->
	<div id="main_sec" data-role="content"
		style="text-align: center; padding: 0;">


		<div id="team_info_tab"
			style="position: fixed; width: 100%; z-index: 500;">
			<div class="ui-grid-b"
				style='width: 100%; text-align: center; background-color: #fff; border-bottom-width: 6px; height: 40px;'>
				<div class="ui-block-a" style="margin-top: 2.5%;">
					<span id="menu_set_button"
						style="margin: 0; margin-top: 12px; padding-bottom: 7px; color: #707070; font-size: 14px;">아티스트</span>
				</div>
				<div class="ui-block-b" style="margin-top: 2.5%">
					<span id="menu_insert_button"
						style="margin: 0; margin-top: 12px; padding-bottom: 7px; font-size: 14px; color: #707070;">공연일정</span>
				</div>
				<div class="ui-block-c"
					style="border-bottom: 3px solid #c750bf; font-weight: 700; margin-top: 2.5%; height: 31px;"
					id="Go_PfrBtn">
					<span id="option_set_button"
						style="margin: 0; margin-top: 12px; padding-bottom: 7px; font-size: 14px; color: #c750bf;">공연후기</span>
				</div>
			</div>
		</div>


		<div class="ui-grid-a" id="ti_bandImg"
			style="width: 100%; height: 220px; background-repeat: no-repeat; background-position: center; border: 0; background-size: cover; font-size: 15px; color: white; margin-top: 40px;">

			<div class="ui-block-a"
				style="text-align: left; margin-top: 40%; padding-left: 15px;">
				<div
					style="color: white; font-size: 17px; font-weight: 700; line-height: 22px; padding-bottom: 4px;"
					id="ti_bandName"></div>
				<div style="font-size: 11px;">
					<span>발라드,락</span>|<span>2017.05.01</span>공연예정
				</div>
				<div class="ui-grid-a">
					<div class="ui-block-a" style="width: 12%;">
						<img src="/img/detail_team/interest_icon.png" style="width: 80%;">
					</div>
					<div id="ti_bandInterestCount" class="ui-block-b"
						style="font-size: 11px;"></div>
				</div>
			</div>
			<div class="ui-block-b"
				style="text-align: right; margin-top: 32%; padding-right: 15px;">

			</div>
		</div>

		<div class="ui-grid-a"
			style="height: 45px; border-bottom: 1px solid #eeeeee">
			<div  class="ui-block-a"
				style="width: 50%; text-align: left; padding: 5% 0 0 15px; font-size: 15px; font-weight: bold;">
				<p>공연후기</p>
			</div>
			<div class="ui-block-b"
				style="width: 50%; text-align: right; font-size: 12px; padding: 5% 15px 0 0; margin-top: 1%; text-decoration:underline;">
				<span>최신순</span>
			</div>
		</div>
		
		<!-- 공연 후기 -->
		<div class="ui-grid-b"
			style="padding: 15px; height: 115px; text-align: left; border-bottom: 1px solid #eeeeee;">
			<div class="ui-block-a" style="width: 40%;">
				<img src="/img/test/perform_test.png"
					style="width: 120px; height: 115px; display: inline-block;">
			</div>
			<div class="ui-block-b" style="width: 55%; padding-left: 5px;">
				<p style="color: #383838;">
					홍대 버스킹 <span>서울</span>
				</p>
				<div class="ui-grid-a" style="margin-top: 5px;">
					<div class="ui-block-a" style="width: 96px;">
						<p class="tp1"></p>
					</div>
					<div class="ui-block-b"
						style="font-size: 14px; width: 35px; margin-left: 5px; color: #c750bf;">
						<p>4.5</p>
					</div>
				</div>
				<p
					style="font-size: 14px; color: #7b7b7b; margin-top: 5px; height: 45px;">좋은
					선물 받고 멘탈 힐링했다
				<p>
				<p style="font-size: 14px; color: #7b7b7b; margin-top: 5px;">
					<span style="color: #959595; font-weight: bold;">user1</span> <span
						style="color: #c5c5c5; margin-left: 5px;">2018.08.01</span>
				<p>
			</div>
			<div class="ui-block-c"
				style="width: 5%; font-size: 22px; padding-top: 48px; text-align: right; color: #c7c7c7;">
				<img src="/img/common/show_btn.svg"
					style="width: 60%; display: inline-block;">
			</div>
		</div>

	<div class="ui-grid-b"
			style="padding: 15px; height: 115px; text-align: left; border-bottom: 1px solid #eeeeee;">
			<div class="ui-block-a" style="width: 40%;">
				<img src="/img/test/perform_test.png"
					style="width: 120px; height: 115px; display: inline-block;">
			</div>
			<div class="ui-block-b" style="width: 55%; padding-left: 5px;">
				<p style="color: #383838;">
					홍대 버스킹 <span>서울</span>
				</p>
				<div class="ui-grid-a" style="margin-top: 5px;">
					<div class="ui-block-a" style="width: 96px;">
						<p class="tp1"></p>
					</div>
					<div class="ui-block-b"
						style="font-size: 14px; width: 35px; margin-left: 5px; color: #c750bf;">
						<p>4.5</p>
					</div>
				</div>
				<p
					style="font-size: 14px; color: #7b7b7b; margin-top: 5px; height: 45px;">좋은
					선물 받고 멘탈 힐링했다
				<p>
				<p style="font-size: 14px; color: #7b7b7b; margin-top: 5px;">
					<span style="color: #959595; font-weight: bold;">user1</span> <span
						style="color: #c5c5c5; margin-left: 5px;">2018.08.01</span>
				<p>
			</div>
			<div class="ui-block-c"
				style="width: 5%; font-size: 22px; padding-top: 48px; text-align: right; color: #c7c7c7;">
				<img src="/img/common/show_btn.svg"
					style="width: 60%; display: inline-block;">
			</div>
		</div>
			<div class="ui-grid-b"
			style="padding: 15px; height: 115px; text-align: left; border-bottom: 1px solid #eeeeee;">
			<div class="ui-block-a" style="width: 40%;">
				<img src="/img/test/perform_test.png"
					style="width: 120px; height: 115px; display: inline-block;">
			</div>
			<div class="ui-block-b" style="width: 55%; padding-left: 5px;">
				<p style="color: #383838;">
					홍대 버스킹 <span>서울</span>
				</p>
				<div class="ui-grid-a" style="margin-top: 5px;">
					<div class="ui-block-a" style="width: 96px;">
						<p class="tp1"></p>
					</div>
					<div class="ui-block-b"
						style="font-size: 14px; width: 35px; margin-left: 5px; color: #c750bf;">
						<p>4.5</p>
					</div>
				</div>
				<p
					style="font-size: 14px; color: #7b7b7b; margin-top: 5px; height: 45px;">좋은
					선물 받고 멘탈 힐링했다
				<p>
				<p style="font-size: 14px; color: #7b7b7b; margin-top: 5px;">
					<span style="color: #959595; font-weight: bold;">user1</span> <span
						style="color: #c5c5c5; margin-left: 5px;">2018.08.01</span>
				<p>
			</div>
			<div class="ui-block-c"
				style="width: 5%; font-size: 22px; padding-top: 48px; text-align: right; color: #c7c7c7;">
				<img src="/img/common/show_btn.svg"
					style="width: 60%; display: inline-block;">
			</div>
		</div>
			<div class="ui-grid-b"
			style="padding: 15px; height: 115px; text-align: left; border-bottom: 1px solid #eeeeee;">
			<div class="ui-block-a" style="width: 40%;">
				<img src="/img/test/perform_test.png"
					style="width: 120px; height: 115px; display: inline-block;">
			</div>
			<div class="ui-block-b" style="width: 55%; padding-left: 5px;">
				<p style="color: #383838;">
					홍대 버스킹 <span>서울</span>
				</p>
				<div class="ui-grid-a" style="margin-top: 5px;">
					<div class="ui-block-a" style="width: 96px;">
						<p class="tp1"></p>
					</div>
					<div class="ui-block-b"
						style="font-size: 14px; width: 35px; margin-left: 5px; color: #c750bf;">
						<p>4.5</p>
					</div>
				</div>
				<p style="font-size: 14px; color: #7b7b7b; margin-top: 5px; height: 45px;">좋은
					선물 받고 멘탈 힐링했다
				<p>
				<p style="font-size: 14px; color: #7b7b7b; margin-top: 5px;">
					<span style="color: #959595; font-weight: bold;">user1</span> <span
						style="color: #c5c5c5; margin-left: 5px;">2018.08.01</span>
				<p>
			</div>
			<div class="ui-block-c"
				style="width: 5%; font-size: 22px; padding-top: 48px; text-align: right; color: #c7c7c7;">
				<img src="/img/common/show_btn.svg"
					style="width: 60%; display: inline-block;">
			</div>
		</div>
		<div class="ui-grid-b"
			style="padding: 15px; height: 115px; text-align: left; border-bottom: 1px solid #eeeeee;">
			<div class="ui-block-a" style="width: 40%;">
				<img src="/img/test/perform_test.png"
					style="width: 120px; height: 115px; display: inline-block;">
			</div>
			<div class="ui-block-b" style="width: 55%; padding-left: 5px;">
				<p style="color: #383838;">
					홍대 버스킹 <span>서울</span>
				</p>
				<div class="ui-grid-a" style="margin-top: 5px;">
					<div class="ui-block-a" style="width: 96px;">
						<p class="tp1"></p>
					</div>
					<div class="ui-block-b"
						style="font-size: 14px; width: 35px; margin-left: 5px; color: #c750bf;">
						<p>4.5</p>
					</div>
				</div>
				<p
					style="font-size: 14px; color: #7b7b7b; margin-top: 5px; height: 45px;">좋은
					선물 받고 멘탈 힐링했다
				<p>
				<p style="font-size: 14px; color: #7b7b7b; margin-top: 5px;">
					<span style="color: #959595; font-weight: bold;">user2</span> <span
						style="color: #c5c5c5; margin-left: 5px;">2018.08.01</span>
				<p>
			</div>
			<div class="ui-block-c"
				style="width: 5%; font-size: 22px; padding-top: 48px; text-align: right; color: #c7c7c7;">
				<img src="/img/common/show_btn.svg"
					style="width: 60%; display: inline-block;">
			</div>
		</div>
	
	</div>
	
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>



