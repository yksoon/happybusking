<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="detail_artist">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	
		<!-- content 부분 -->		
		<div id="detail_artist_content" data-role="content">		
			<div class="ui-grid-a da_img" id="detail_artistImg">
				<div class="ui-block-a da_text_container">
					<div class="da_teamname" id="detail_artistName"></div>
					<div class="da_infobox"><div id="da_part"></div> | <span id="da_team"></span></div>
					<div class="ui-grid-a">
						<div class="ui-block-a da_interest_img">
							<img src="/img/detail_team/interest_icon.svg" >
						</div>
						<div class="ui-block-b da_interest_count" id="dai_bandInterestCount">
						</div>						
					</div>
				</div>		
			</div>
			<div>
				<div class="ui-grid-a da_middle_header">
					<div class="ui-block-a da_mh_left">
						<p>소개</p>
					</div>
					<div class="ui-block-b da_mh_right">
						<span id="dainfo_showBtn" onclick="dainfo_showAll();">전체보기</span>
					</div>
				</div>
<!-- 				<div id="da_intro" style="/* height: 80px; */ font-size : 13px; text-align:  left; padding: 15px; line-height:25px; overflow: hidden; white-space: normal; height: 8em; 
					word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical;">
				
				</div> -->
				<div class="da_intro" id="da_intro">
				
				</div>				
				<div class="da_content_header">정보</div>
				<div class="da_content_container">
					<p>
						<span class="da_cc_title">소속 그룹</span>
						<span id="dai_tname" class="da_cc_conent"></span>
					</p>
					<!-- <p class="ainfo_style">
						<span class="da_info_title">성별</span>
						<span id="dai_gender" class="da_info_content"></span>
					</p>
					<p class="ainfo_style">
						<span class="da_info_title">생년월일</span>
						<span id="dai_age" class="da_info_content"></span>
					</p> -->
					<!-- <p class="da_cc_style">
						<span class="da_cc_title">장르</span>
						<span id="dai_genre" class="da_cc_conent"></span>
					</p> -->
					<p class="da_cc_style">
						<span class="da_cc_title">사용하는 악기/도구</span>
						<span id="dai_tool" class="da_cc_conent"></span>
					</p>
					<p class="da_cc_style">
						<span class="da_cc_title">SNS</span>
						<span id="dai_site" class="da_cc_conent"></span>
					</p>																																											
				</div>

			</div>	
		</div>
<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>


