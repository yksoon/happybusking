<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="video_upload">	
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
	
	<div id = "video_upload_sec" data-role="content" style="text-align:center; padding: 0; height: auto !important;">
		<input type="hidden" id="user_no" value="<%=USER_NO %>">
		<div class="upload_title">공연 파일 선택</div>
		<div id="video_upload_part">
			<input type="file" id="video_uploadFile" name="video_uploadFile" accept="video/*"/>
			<input type="hidden" id="url" />
			<!-- <div id="upload_img_default" class="upload_img"></div> -->
		</div>
		<div class="upload_title">공연 장소</div>
		<div class="upload_content">
			<input type="text" id="vu_place" name="vu_place" placeholder="아티스트가 공연한 장소를 입력해주세요. ex) 홍대 거리">
		</div>
		<div class="upload_title">내용</div>
		<div class="upload_content">
			<textarea id="vu_content" name="vu_content" rows="7" cols="" placeholder="곡명 등 간단한 내용을 입력해주세요."></textarea>
		</div>
		
		<div class="ui-grid-b ui-user-check">
			<div class="ui-block-a">
				<input type="checkbox" id="videoUpload_checkbox" name="videoUpload_checkbox" data-role="none">
			</div>
			<div class="ui-block-b" id="videoUpload_checkbox_btn">
				<p>이용약관 동의(필수)</p>
			</div>
			<div class="ui-block-c join_view_more_block">
				<div class="join_view_more" id="videoUpload_checkboxView">보기</div>
			</div>
		</div>
	</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
		<div data-role="popup" id="video_upload_ing">
			<div class="video_upload_ing_title">업로드 상태</div>
			<div id="myProgress">
			  <div id="myPercent">0%</div>
			  <div class="ui-grid-a">
			  	<div class="ui-block-a" style="width: 90%;">
			  		<div id="myBar"></div>
			  	</div>
			  	<div class="ui-block-b" id="myCancle"></div>
			  </div>
			</div>
			<div class="ui-grid-a" id="vu_popup_footer">
				<div class="ui-block-a" id="vu_status">업로드 진행중...</div>
				<div class="ui-block-b" id="vu_btn">확인</div>
			</div>
		</div>
		
		<div data-role="popup" id="video_upload_terms">
			<div id="video_upload_terms_close"><img src="/img/common/close.png"></div>
		<p>제5장 게시물 관리 및 저작권</p>

		<p>제17조 게시물 관리</p>
		<p>① 이용자의 게시물이 정보통신망법 및 저작권법 등 관련법령에 위배되는 내용을 포함하는 경우, 권리자는 관련법령이 정한 절차에 따라 해당 게시물의 게시중단 및 삭제 등을 요청할 수 있으며, “회사”는 관련법령에 따라 조치를 취하여야 합니다.</p>
		<p>② “회사”는 전항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 회사정책 및 다음 각 호에 해당하는 게시물이나 자료에 대하여 사전 통지 없이 삭제하거나 등록을 거부할 수 있습니다.</p>
		<p> 1. 다른 이용자 또는 제3자에게 심한 모욕을 주거나 명예를 손상시키는 내용인 경우</p>
		 <p>2. 청소년보호법에 위반되는 내용의 정보, 문장, 영상 등을 게시하거나 링크 시키는 경우</p>
		 <p>3. 청소년보호법에 위반되는 음란한 내용이거나 음란사이트를 링크 시키는 경우</p>
		 <p>4. 불법복제 또는 해킹을 조장하는 내용인 경우</p>
		 <p>5. 영리를 목적으로 하는 광고일 경우</p>
		 <p>6. 범죄와 결부된다고 객관적으로 인정되는 내용일 경우</p>
		 <p>7. 다른 이용자 또는 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</p>
		<p> 8. “회사”에서 규정한 게시물 원칙에 어긋나거나, 게시판 또는 동영상 등록 메뉴 성격에 부합하지 않는 경우</p>
		
		<p>제18조 게시물의 저작권</p>
		<p>① 이용자가 서비스 내에 게시한 게시물의 저작권은 기본적으로 게시한 이용자에게 귀속되며, 저작권법 등 관련법령에 위배되어 분쟁 발생 시 모든 책임은 게시물을 게시한 이용자에게 있습니다.</p>
		<p>② 게시물은 검색결과 내지 회사의 서비스 및 관련 프로모션 등에 노출될 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수 있습니다. 이 경우 회사는 별도의 이용약관을 통해 이용자의 동의를 얻어야 합니다.</p>
		
		<p>제19조 광고 게재 및 광고주와의 거래</p>
		<p>① “회사”가 이용자에게 서비스를 제공할 수 있는 서비스 투자 기반이 일부는 광고 게재를 통한 수익으로부터 나옵니다. 서비스를 이용하고자 하는 이용자는 서비스 이용 시 노출될 수 있는 광고 게재에 대해 동의하는 것으로 간주됩니다.</p>
		<p>② “회사”는 서비스에 게재되어 있거나 서비스를 통한 광고주의 판촉활동에 이용자가 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다.</p>
		
		<p>제6장 손해배상 및 면책</p>
		
		<p>제20조 손해배상</p>
		<p>① “회사”는 무료서비스의 장애, 제공 중단, 보관된 자료 멸실 또는 삭제, 변조 등으로 인한 손해에 대하여는 배상하지 않습니다.</p>
		<p>② 유료 서비스 이용자 또는 회사가 본 약관 또는 별도 서비스 별 약관의 규정을 위반함으로 인하여 상대방에게 손해가 발생하게 되는 경우, 책임있는 일방은 상대방에게 그 손해를 배상하여야 합니다. 그 손해는 통상의 손해에 한하며, 특별한 사정으로 인한 손해는 그것을 알았거나 알 수 있었을 때에 배상책임을 부담합니다.</p>
		<p>③ 이용자가 제10조의 의무를 위반하거나 이용자 간 승낙, 거절을 결정할 수 있는 매칭서비스에 따라 다른 이용자에게 손해가 발생한 경우 회사는 책임을 지지 않으며, 관련 손해배상 등의 책임은 의무를 위반한 이용자 및 상호 이용 당사자에게 있습니다.</p>
		
		<p>제21조 면책조항
		<p>“회사”는 다음 각 호에 해당하는 경우 책임이 면제됩니다.</p>
		 <p>1. 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우</p>
		 <p>2. 기간통신사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우</p>
		 <p>3. 서비스영 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한  손해의 경우</p>
		 <p>4. 이용자의 귀책사유로 인한 서비스 이용의 장애 또는 손해가 발생한 경우</p>
		 <p>5. 이용자의 컴퓨터 또는 스마트기기 오류에 의해 손해가 발생한 경우</p>
		 <p>6. 이용자가 신상정보 및 전자우편주소를 부실하게 기재하여 손해가 발생한 경우</p>
		 <p>7. 이용자가 서비스를 이용하여 기대하는 수익을 얻지 못하거나 상실한 경우</p>
		 <p>8. 이용자가 서비스를 이용하며 다른 이용자로 인해 입게되는 물질적, 정신 적 피해에 대한 경우</p>
		 <p>9. 이용자 상호 간 및 이용자와 제3자 상호 간에 서비스를 매개로 발생한 분쟁 및 이로 인한 손해가 발생한 경우</p>
		
		
		</div>
</div>