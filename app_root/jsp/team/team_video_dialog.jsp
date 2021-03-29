<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">
<div data-role="page" id="team_video_dialog" style="height: 100%; background-color: #353535 !important; min-height: 100%; color: white;">
<header data-role="header" style="background-color: silver; margin-top: 50px;" >

<a role="button" href="#" class="ui-btn ui-corner-all ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
	<h1 style="margin: 0;">아티스트 소개 동영상</h1>
</header>
<div data-role="content" style="font-size: 14px;">
	<iframe id="dVideo_src" width="100%" height="270" src="" frameborder="0" allowfullscreen>
	</iframe>
	<div class="ui-grid-a" style="margin-top: 15px;">
		<div class='ui-block-a' style="width: 20%;">
			<p style="font-weight: bold;">내용 :</p> 
		</div>
		<div class='ui-block-b' style="width: 80%;">
				<p id="dVideo_content"></p>
			</div>					
		</div>				
	</div>
</div>
