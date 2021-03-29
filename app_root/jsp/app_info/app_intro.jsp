<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">

<div data-role="page" id="app_intro">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:left; padding: 15px; font-size:14px; border-top:solid 1px #eeeeee;">
			<p class="appIntroTitle">해피버스킹 소개</p>	
			
			<p style="color:#8d5cb1; font-weight:bold;">아티스트와 관객이 함께 즐기는 공간</p>
			<p class="appIntroContent">가장 빠르게 관중에게 아티스트인 나를 알려보세요. 누구나 아티스트가 될 수 있습니다.</p>
			
			<p class="appIntroName">▶QR코드 스캔으로 아티스트 정보를 한눈에!</p>
			<p class="appIntroContent">지금 공연하고 있는 아티스트는 누구? 아티스트 옆의 QR-CODE를 스캔해보세요. 아티스트의 정보를 한눈에 볼 수 있습니다.</p>
			
			<p class="appIntroName">▶아티스트 정보 확인</p>
			<p class="appIntroContent">QR스캔으로 해당 아티스트가 직접 등록한 모든 정보를 한눈에 볼 수 있습니다. 관심 아티스트로 설정하고 공연 알람을 받아보세요~</p>
					
			<p class="appIntroName">▶공연 일정 확인</p>
			<p class="appIntroContent">아티스트의 또 다른 공연 일정이 궁금하다면? 등록 된 다른 공연 일정도 확인해보세요.</p>
			
			<p class="appIntroName">▶공연 후기 확인</p>
			<p class="appIntroContent">공연을 직접 본 사람만 작성 할 수 있는 생생 리얼 후기! 아티스트의 모든 공연 후기를 확인해보세요.</p>
			
			<p class="appIntroName">▶공연일정 모아보기</p>
			<p class="appIntroContent">등록된 아티스트들의 모든 일정들을 확인할 수 있습니다. 가고 싶은 공연을 클릭해보세요.</p>
			
			<p class="appIntroName">▶아티스트 모아보기</p>
			<p class="appIntroContent">앱에 등록된 모든 아티스트들과 취향 저격 아티스트까지!</p>
			
			<p class="appIntroName">▶다양한 서비스 지원 </p>
			
			<p>&lt;공연 의뢰&gt;</p>
			<p class="appIntroContent">공연 등 행사 기획, 장소 섭외까지 마쳤지만 공연 의도와 딱 맞는 아티스트가 없다면? 공연의뢰 서비스를 이용해보세요. 
			원하는 아티스트뿐만 아니라 나의 예산에 맞는 아티스트까지 검색할 수 있는 편리한 서비스가 지원 되어 나에게 가장 적절하고 필요한 아티스트에게 공연 의뢰를 할 수 있습니다. </p>
			
			<p>&lt;물품 지원&gt;</p>
			<p class="appIntroContent">버스킹은 하고 싶지만 장비가 없어서 거리로 나가기 두려운 버스커들을 위해 꼭 필요한 물품을 지원합니다. 간단한 정보를 입력한 후 필요한 장비를 신청, 대여할 수 있습니다.</p>
											
			<p>&lt;QR-CODE 지원&gt;</p>
			<p class="appIntroContent">가장 쉽고 빠르게 아티스트인 나의 정보를 알리는 방법! 관중에게 QR-CODE로 나를 알리세요. 
			아티스트로 등록된 모든 정보가 QR-CODE 스캔 한번이면 한눈에 확인 가능합니다. 해피버스킹의 아티스트라면 간단한 정보 입력 후 QR-CODE를 지원 받을 수 있습니다.</p>	

			<p>&lt;비디오 업로드&gt;</p>
			<p class="appIntroContent">아티스트의 버스킹 영상을 찍었다면 해당 아티스트의 비디오 업로드 부분에 동영상을 업로드 해보세요. 
			영상의 퀄리티와 내용을 자체 심사, 편집 후 해피버스킹 유튜브 채널에 영상이 업로드 됩니다.</p>	

			<p class="appIntroSourceT">----</p>
			<p class="appIntroSource">해피버스킹 앱에는 네이버에서 제공한 나눔글꼴이 적용되어 있습니다.<br>나눔스퀘어, 나눔손글씨 펜체<br><br>해피버스킹 앱에는 스포카 한 산스 폰트가 적용되어 있습니다.<br>스포카 한 산스 라이선스 출처: https://spoqa.github.io/spoqa-han-sans/ko-KR/ <br>http://scripts.sil.org/OFL  <br><br> 메인 팝업 페이지에는 S-Core에서 제공한 에스코어 드림이 적용되어 있습니다. <br><br>일부 아이콘제공: Attribution 3.0 Unported (CC BY 3.0)  <br> https://creativecommons.org/licenses/by/3.0/</p>					
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>


