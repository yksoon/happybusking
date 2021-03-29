<!DOCTYPE html>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<div data-role="page" id="supply_item_request">	

	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:center; padding: 0;">
				
			<div class="supply_item_request_header1">
				<h2>1. 신청 정보 입력</h2>
			</div>
<!-- 			<div class="supply_item_request_title">
				아이디
			</div>
			<div class="supply_item_request_content">
				<input type="text" class="supply_item_request_text" id="rq_supply_id" placeholder="아이디를 입력해주세요">
			</div>	
			<div class="supply_item_request_title">
				활동명
			</div>
			<div class="supply_item_request_content">
				<input type="text" class="supply_item_request_text" id="rq_supply_aname" placeholder="활동명을 입력해주세요">
			</div>	 -->				
			<div class="supply_item_request_title">
				팀이름선택
			</div>
			<div id="rqSupply-select-box">
				<select name="rq-team-select" id="rq-team-select">
					<option value="">팀 이름을 선택하세요</option>
				</select>
			</div>
<!-- 			<div class="supply_item_request_title">
				휴대폰
			</div>
			<div class="supply_item_request_content">
				<input type="text" class="supply_item_request_text" id="rq_supply_phoneNumber" placeholder="휴대폰 번호(-없이 입력)">
			</div>	 -->
			<div class="supply_item_request_title">
				주소
			</div>
			<div class="supply_item_request_content">
				<div class="ui-grid-a">
					<div class="ui-block-a" style="width: 78%">
						<!-- <input type="text" class="supply_item_request_text" id="rq_supply_addr" placeholder="ex)여의도동"> -->
						<textarea class="supply_item_request_textarea" id="rq_supply_addr" data-role="none" placeholder="ex)여의도동"></textarea>
					</div>
					<div class="ui-block-b" id="rq_addr_sc_btn" onclick="open_execDaumPostcode('rqs_addr_layer')">
						검색
					</div>
				</div>
			</div>
			<div id="rqs_addr_layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch; z-index: 500000;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1;" onclick="closeDaumPostcode('rqs_addr_layer')" alt="닫기 버튼">
			</div>
			<div class="supply_item_request_title">
				우편번호
			</div>
			<div class="supply_item_request_content">
				<input type="text" class="supply_item_request_text" id="rq_supply_postcode" placeholder="우편번호를 입력해주세요">
			</div>
			<div class="supply_item_request_title">
				상세주소
			</div>		
			<div class="supply_item_request_content">
				<input type="text" class="supply_item_request_text" id="rq_supply_detail_addr" placeholder="상세주소를 입력해주세요">
			</div>			
			<div class="div_division">
			</div>	
			<div class="supply_item_request_header2">
				<h2>2. 지원물품 선택</h2>
			</div>		
			<div class="supply_item_request_title">
				물품신청
			</div>
			<div id="rqSupply-select-box">
				<select name="rq-item-select" id="rq-item-select">
					<option value="">물품을 선택하세요</option>
				</select>
			</div>		
			<div class="div_division">
			</div>		
			<div class="supply_item_request_title" style="border-bottom: 1px solid #ddd; padding-bottom: 15px;">
				선택물품 내역
			</div>		
			<div id="rq_selected_part">
				
			</div>	
			<div class="ui-grid-b ui-user-check" style="margin-bottom: 70px;">
				<div class="ui-block-a">
					<input type="checkbox" id="si_req_checkbox" name="useAgree_checkbox" data-role="none">
				</div>
				<div class="ui-block-b" id="si_req_checkbox_btn">
					<p>지원 물품 신청 이용약관(필수)</p>
				</div>
				<div class="ui-block-c">
					<p><span id="si_req_checkboxView">보기</span></p>
				</div>
			</div>
		</div>
		
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
		<div data-role="popup" id="si_req_terms">
		<div id="si_req_terms_close"><img src="/img/common/close.png"></div>
		<p>해피버스킹 공연물품지원 이용약관</p>

		<p>본 약관은 비즈웍스(이하 “회사”)에서 운영하고 있는 해피버스킹 애플리케이션(이하 “앱”)의 공연물품지원 서비스(이하 “대여 또는 렌트)를 이용하는 아티스트(이하 "이용자")가 서비스를 이용하는데 있어서 "회사"와 "이용자"의 권리 및 의무, 책임사항을 규정합니다.</p>
		
		<p>제 1 조 [목적]</p>
		<p>본 계약의 목적은 "회사"의 서비스를 "이용자"가 이용하는데 있어서 공연물품지원 서비스 신청에서부터 제품 인수 인도, 대금 결제 및 사후서비스에 이르기까지 모든 절차상의 규정을 정하는데 그 목적이 있습니다.</p>
		
		<p>제 2 조 [용어]</p>
		<p>① 대여(또는 렌트): "회사"가 "이용자"로부터 "회사"가 규정하는 무상 또는 일정금액 또는 일정보증금을 받고 약정된 기간 동안 "회사"의 대여물품을 "이용자"에게 임대함을 말합니다.</p>
		<p>② 대여물품(또는 대여장비): "회사"가 대여를 목적으로 "이용자"에게 제공하는 물품을 말합니다.</p>
		<p>③ 대여기간: "회사"가 "이용자"에게 대여물품을 대여하는데 있어 약정된 사용 기간을 말합니다.</p>
		<p>④ 대여금액: "회사"가 "이용자"에게 대여물품을 대여하는 과정에서 "이용자"가 "회사"에 지불해야 하는 일정금액 또는 일정보증금을 말합니다.</p>
		<p>⑤ 배송일: "회사"가 "이용자"에게 대여물품을 인도하는 날을 말합니다.</p>
		<p>⑥ 반납일: "회사"가 "이용자"로부터 대여물품을 회수하는 날을 말합니다.</p>
		
		<p>제 3 조 [대여신청 및 취소]</p>
		<p>① 대여신청은 “앱”을 이용하여 신청합니다.</p>
		<p>② "이용자"의 대여신청에 대해 "회사"의 담당자가 정상적으로 예약 접수가 되었음을 통보한 경우에 한하여 신청이 완료됩니다.</p>
		<p>③ "이용자"는 "이용자"에게 인도된 대여물품이 대여신청 내용상의 물품과 상이하거나 파손 및 손상되어 정상적인 작동이 불가능한 경우에 한하여 교체신청 또는 대여신청취소가 가능합니다.</p>
		<p>④ "이용자"는 대여 신청 후 물품 인수일 24시간 이전까지는 예약 취소를 할 수 있습니다. 예약을 취소할 경우에는 인수일 24시간 이전에 "회사"에 그 사실을 신청방법과 동일하게 “앱”을 이용하여 신청하거나 유선 상으로 통보해야 합니다. 정당한 사유없이 위 취소 규정을 준수하지 못한 "이용자"에 대해서 "회사"는 차후 대여 접수를 거부할 수 있습니다.</p>
		
		<p>제 4 조 [배송 및 반납]</p>
		<p>① "회사"는 배송일에 대여제품을 "이용자"가 지정한 장소로 배송하고 반납일에 “이용자”와 협의된 장소를 방문하여 대여물품을 회수합니다.</p>
		<p>② 배송장소는 "이용자"의 주민등록증상에 기재된 자택이나 소속 직장 중 한 곳으로 하여야 하며 공공장소는 불가능 합니다.</p>
		<p>③ 서울 전지역에 한하여 배송 및 회수는 무료이며, 수도권 일부 지역은 유료 배송이 가능하고 기타 지역의 경우에는 원칙적으로 대여가 불가능 합니다.</p> 
		<p>단, “회사”와 별도 협의후 배송요금을 책정한 후 대여가 가능할 수도 있습니다.</p>
		            
		<p>제 5 조 [대금결제]</p>
		<p>"회사"가 규정한 대여금액(부가세포함)은 "회사"에 공지되어 있으며, "이용자"는 대여물품 인수 이전 또는 인수와 동시에 결제해야 합니다.</p>
		 
		<p>제 6 조 [책임 및 의무]
		<p>① "이용자"는 다음 각 호와 같은 책임과 의무를 집니다.</p>
		 <p>1. "이용자"가 대여한 대여물품은 대여기간 중에도 그 소유가 "회사"에 있으므로 "이용자"는 대여물품을 임의로 분해하거나 정상적이지 않은 전원의 사용 등 고장의 원인이 되는 여타의 방법으로 조작해서는 안됩니다.</p>
		 <p>2. 대여기간 중 혹은 대여기간이 끝난 후에도 "이용자"의 부주의로 인한 대여물품의 파손 및 이상이 명백한 경우 그 모든 책임이 "이용자"에게 있으며, "이용자"는 대여물품의 원상복귀를 위해 "회사"가 제시한 방법으로 손해배상을 해야 합니다.</p>
		 <p>3. 대여기간 중 "이용자" 부주의로 인하여 대여물품을 도난 혹은 분실했을 경우, "이용자"는 대여물품의 현 구입가격에 해당 하는 금액을 변상하여야 합니다.</p>
		<p>② "회사"는 다음 각 호와 같은 책임과 의무를 집니다.</p>
		 <p>1. "회사"는 대여 서비스와 관련하여 취득한 "이용자"의 개인정보를 "이용자"의 사전 승인 없이 제3자에 유출하여서는 안되며 이를 위반하여 그로 인해 발생되는 손해에 대해서는 손해배상하고 민, 형사상의 책임을 집니다.</p>
		 <p>2. "회사"는 "이용자"와 약정한 대여기간을 고려하여 대여물품을 고객에게 안전하게 인도해야 하는 의무가 있습니다.</p>
		 <p>3. 대여기간 중 대여물품 자체의 결함으로 인하여 "이용자"가 대여물품의 일부 또는 전체를 사용하지 못했을 경우에 "회사"는 대체품을 최단기간 내에 "이용자"에게 보내는 데에 최선을 다하여야 하며, 재고 부족 등의 이유로 대체품의 사용이 불가능할 경우에는 남은 대여기간에 해당하는 대여금액을 "이용자"에게 전액 환불해야 합니다. 다만, 무상 대여일 경우에는 제외합니다.</p>
		
		<p>제 7 조 [계약의 성립 및 변경]</p>
		<p>① 본 약관의 내용은 "이용자"가 대여 신청한 순간부터 "회사"와 "이용자"간에 그 효력이 발생됩니다.</p>
		<p>② 본 약관의 내용 일부 또는 전부를 변경할 필요가 있을 때에 "회사"는 그 변경 내용을 사전에 "이용자"에게 통보할 의무는 없으며, 다만 "회사"의 홈페이지 또는 앱을 통하여 그 변경 내용을 공지하도록 합니다.</p>
		
		<p>제 8 조 [분쟁해결 및 재판권, 준거법]</p>
		<p>① 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 해당 규정에 따릅니다.</p>
		<p>② 회사의 귀책사유로 인한 서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 회사 본사 소재지를 관할하는 법원을 관할 법원으로 합니다.</p>
		  
		<p>부칙</p>
		
		<p>본 해피버스킹 공연물품신청 이용약관은 2018년 09월 21일부터 시행합니다.</p>     
		</div>

</div>

