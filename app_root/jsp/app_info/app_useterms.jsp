<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">

<div data-role="page" id="app_useterms">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:left; padding: 15px; font-size:14px; border-top:1px solid #eeeeee;">
			<p class="termsTitle">해피버스킹 이용약관</p>

			<p class="termsTitle">제1장 총칙</p>
			
			<p class="termsTitle">제1조 목적</p>
			<p>본 약관은 가치누리(이하 “회사”)가 운영하는 해피버스킹 애플리케이션(이하 “앱”)에서 제공하는 서비스를 이용함에 있어 아티스트 및 관람자(이하“이용자”)의 권리와 의무 및 책임사항을 규정하고 아티스트와 관람자가 함께 소통할 수 있는 공간을 만들어 버스킹 문화의 활성화에 기여하는데 그 목적이 있습니다.</p>
						
			<p class="termsTitle">제2조 용어의 정의</p>
			<p>본 약관에서 사용하는 용어의 정의는 다음 각 항과 같습니다.</p>
			<p>① “앱”이란 이용자 중 아티스트가 홍보/팀구성/홍보용 QR배너신청/공연물품지원신청/공연일정등록 등을 통해 관람자가 아티스트 콘텐츠를 검색/시청/소통/후원/동영상등록 등이 가능하도록 하는 플랫폼 서비스를 말합니다.</p>
			<p>② “이용자”중 “관람자”란 회사가 제공하는 플랫폼 서비스의 이용자 중 본 약관에 동의하고 아티스트 콘텐츠 검색/시청/소통/후원/동영상등록 등을 이용하는 이용자를 말합니다.</p>
			<p>③ “이용자” 중 “아티스트”란 회사가 제공하는 플랫폼 서비스의 이용자 중 본 약관에 동의하고 홍보/팀구성/홍보용 QR배너신청/공연물품지원신청/공연일정등록 등을 이용하는 이용자를 말합니다.</p>
			<p>④ “유료상품”이란 원할한 플랫폼 서비스 이용을 위해 “회사”가 유료로 제공하는 상품을 의미합니다.</p>
			<p>⑤ “결제”란 “아티스트” 또는 “관람자”가 유료상품을 이용하기 위하여 “앱”에서 제공하는 결제수단을 통해 “회사”에 지급하는 것을 말합니다.</p>
			<p>⑥ “환불”이란 “아티스트” 또는 “관람자”가 유료상품 이용 계약의 해제, 해지, 취소 등을 통해 결제 시 사용한 결제 내역의 취소를 의미합니다. </p>  
			
			<p class="termsTitle">제3조 약관의 효력 및 변경</p>
			<p>① 본 약관은 회사 앱에 가입된 이용자를 포함하여 앱을 이용하고자 하는 모든 이용자에 대하여 그 효력을 발생합니다.</p>
			<p>② 본 약관의 내용은 앱 화면에 게시하거나 기타의 방법으로 이용자에게 공시하고 이용자가 앱에 가입하거나 이용 동의함으로써 효력이 발생합니다.</p>
			<p>③ 회사는 본 약관의 내용과 상호, 대표자, 영업소 소재지, 사업자등록번호, 연락처(전화, 팩스, 전자우편주소 등)등을 이용자가 할 수 알 수 있도록 앱의 초기 서비스화면에 게시 합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.</p>
			<p>④ 회사는 이용자가 약관에 동의하기에 앞서 약관에 정해져 있는 내용 중 QR신청 및 철회, 물품지원 및 철회, 공연의뢰 및 철회, 동영상 등록에 따른 책임과 환불조건, 배상 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.</p>
			<p>⑤ 회사는 전자상거래등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자상거래기본법, 전자서명법, 정보통신망 이용촉진등에 관한 법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.</p>
			<p>⑥ 회사가 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 앱의 초기화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다.</p>
			<p>⑦ 본 약관에서 정하지 아니한 사항과 본 약관의 해석에 관하여는 전자상거래등에서의 소비자 보호에 관한 법률, 약관의 규제에 관한 법률, 전자상거래기본법, 전자서명법, 정보통신망 이용촉진등에 관한 법률, 소비자보호법 등 관계법령 또는 상관례에 따릅니다.</p>
			
			<p class="termsTitle">제2장 서비스 이용</p>
			
			<p class="termsTitle">제4조 서비스의 구분 및 제공</p>
			<p>① “회사”가 “앱”에서 제공하는 서비스는 아티스트 서비스, 관람자 서비스로 구분하며 이는 무료 서비스, 유료 서비스 등으로 구분합니다.</p>
			<p>② 아티스트 서비스는 다음 각 호와 같습니다.</p>
			 <p>1. 팀구성 : 아티스트 간의 팀 결성 매칭 무료 서비스</p>
			 <p>2. QR배너신청 : 버스킹 시 QR코드 삽입된 아티스트 홍보용 배너 제작 유료 서비스</p> 
			<p> 3. 공연물품지원신청 : 버스킹 시 필요한 공연물품 지원 무료 서비스 </p> 
			 <p>4. 공연일정등록 : 관람자 등이 공연일정을 손쉽게 찾아볼 수 있도록 아티스트 본인 또는 팀의 공연일정 등록 무료 서비스</p>
			<p>③ 관람자 서비스는 다음 각 호와 같습니다.</p>
			 <p>1. 공연 및 아티스트 검색 : 앱에 등록된 아티스트 및 공연 일정 검색 무료 서비스</p>
			 <p>2. 공연의뢰신청 : 원하는 아티스트에게 공연료를 지급하고 공연의뢰를 할 수 있는 주최자와 아티스트간 공연 매칭 서비스</p>
			 <p>3. 동영상 등록 : 관람자가 버스킹 동영상을 촬영하여 다른 관람자들과 공유할 수 있는 동영상 업로드 무료 서비스 </p> 
			 <p>4. 후원 : 관람자가 원하는 아티스트에게 계좌이체, 휴대폰결제 등 다양한 결제방식을 통해 일정 금액을 후원할 수 있는 서비스 </p> 
			<p>④ ②항 및 ③항에 따른 서비스의 종류와 이용방법 등은 본 약관 또는 개별 서비스 이용약관 및 “회사”공지 또는 이용안내에서 별도로 정하는 바에 의합니다.</p>
			<p>⑤ 서비스 이용등급은 콘텐츠 초기화면에 표시된 이용등급정보에 따르며, “회사”는 이용고객에 대하여 청소년보험법 등에 따른 등급 및 연령 준수를 위해 이용제한이나 등급별 제한을 할 수 있습니다.</p>
			
			<p class="termsTitle">제5조 서비스 이용의 성립</p>
			<p>① 서비스 이용은 “아티스트” 또는 “관람자”가 되고자 하는 이용자의 본 약관 및 서비스별 이용약관 내용에 대한 동의와 서비스 신청에 대하여 “회사”가 이를 승낙함으로써 성립됩니다.</p> 
			<p>③ “회사”는 이용 승낙의 의사표시를 해당 서비스 화면에 게시하거나 전자 우편 또는 기타의 방법으로 통지할 수 있습니다.</p>
			
			<p class="termsTitle">제6조 서비스 신청</p>
			<p>① 서비스 이용을 원하는 이용자는 앱을 통한 접속 등의 방식으로 “회사”에게 이용자의 개인정보를 3자로부터 제공하는 것과 서비스별 이용약관에 동의함을 통해 신청을 하여야 합니다.</p>
			<p>② “회사”는 약관의 주요 내용을 이용자에게 고지하여야 합니다.</p>
			<p>③ 이용자는 ②항의 고지 하단에 있는 동의 버튼을 클릭하거나 체크박스에 체크하고 서비스 신청을 하는 것으로 약관에 대한 동의로 간주됩니다.</p>
			<p>④ 서비스 신청을 하려는 이용자는 자신의 실명 또는 아이디를 이용하여야 합니다.</p>
			<p>⑤ 타인의 정보를 도용하여 서비스 신청을 한 이용자는 일체의 권리를 주장할 수 없으며 등록된 이용자 계정은 정지 및 삭제됩니다.</p>
			
			<p class="termsTitle">제7조 서비스 신청의 승낙</p>
			<p>“회사”는 제6조의 규정에 의한 서비스 신청에 대하여 업무수행상 또는 기술상 지장이 없는 경우에는 원칙적으로 지체 없이 서비스를 제공하며 이 경우 원칙적으로 접수 순서에 따라 서비스 이용을 승낙합니다.</p>
			<p class="termsTitle">제8조 서비스 신청에 대한 불승낙 및 보류</p>
			<p>① “회사”는 다음 각 호에 해당하는 서비스 신청에 대하여는 불승낙 및 보류를 할 수 있습니다.</p>
			 <p>1. 실명 신청이 필요한 경우 실명이 아니거나 타인 명의의 신청의 경우</p>
			 <p>2. 서비스 신청 내용을 허위로 기재한 경우</p>
			 <p>3. 서비스 신청 이용자가 회사에 납부하여야 할 요금 등을 미납한 경우</p>
			 <p>4. 범죄 행위의 목적으로 본 서비스를 이용하고자 하는 경우</p>
			 <p>5. 청소년보호법의 취지에 위배되는 목적으로 본 서비스를 이용하고자 하는 경우</p>
			 <p>6. 기타 현행 법령에 위배되는 목적으로 본 서비스를 이용하고자 하는 경우</p>
			 <p>7. 기타 규정한 제반 사항을 위반하며 신청하는 경우</p>
			<p>② “회사”는 다음 각호의 하나에 해당하는 사유가 있는 경우에는 그 사유가 해소될 때까지는 승낙을 보류할 수 있습니다.</p>
			 <p>1. 회사의 설비 및 물품 등에 여유가 없는 경우</p>
			 <p>2. 회사의 기술상 지장 및 여타 사유로 서비스에 장애가 있는 경우</p>
			<p>③ “회사”는 이용자가 만 14세 미만인 경우에 법정대리인(부모 등)의 동의없는 서비스 신청에 대하여 승낙을 보류할 수 있습니다.</p>
			
			<p class="termsTitle">제3장 계약당사자의 의무</p>
			
			<p class="termsTitle">제9조 회사의 의무</p>
			<p>① “회사”는 본 약관이 정하는 바에 따라 지속적이고 안정적으로 서비스를 제공하는데 최선을 다하여야 합니다.</p>
			<p>② “회사”는 이용자가 안전하게 서비스를 이용할 수 있도록 이용자의 개인정보보호를 위해 최선을 다하여야 합니다.</p>
			<p>③ “회사”는 이용자로부터 제기되는 의견이나 불만이 정당하다고 인정될 경우 적절한 절차를 거쳐 즉시 처리될 수 있도록 노력하여야 하며, 다음 각 호의 사유 발생시 부득이한 경우 예고 없이 서비스의 전부 또는 일부의 제공을 일시 중지할 수 있습니다. 이 경우 그 사유 및 중지 기간 등을 이용자에게 지체없이 사후 공지합니다.</p>
			 <p>1. 회사가 긴급한 시스템 점검, 증설, 교체, 시설의 보수 또는 공사 등을 하기 위한 부득이한 경우</p>
			 <p>2. 새로운 서비스 시스템으로의 교체 등을 위하여 회사가 필요하다고 판단하는 경우</p>
			 <p>3. 시스템 EH는 기타 서비스 설비의 장애, 유무선 네트워크 장애 등으로 정상적인 서비스 제공이 불가능한 경우</p>
			 <p>4. 천재지변, 국가비상사태, 정전 등 회사가 통제할 수 없는 불가항력적 사유로 인한 경우</p>
			
			<p class="termsTitle">제10조 이용자의 의무</p>
			<p>① 이용자는 회원가입을 통해 서비스 신청을 할 경우 사실에 근거하여 작성하여야 합니다. 허위 또는 타인의 정보를 등록한 경우 일체의 권리를 주장할 수 없으며 “회사”는 이로인해 발생하는 손해에 대하여 책임을 부담하지 않습니다.</p>
			<p>② 이용자는 본 약관에서 규정하는 사항과 기타 회사가 정한 제반 규정과 공지사항을 준수하여야 합니다. 또한 이용자는 회사의 업무에 방해가 되는 행위, 회사의 명예를 손상시키는 행위를 해서는 안됩니다.</p>
			<p>③ 이용자는 청소년보호법 등 관계 법령을 준수하여야 하며, 관계법령을 위반한 경우 해당 법령에 의거 처벌을 받게 됩니다.</p>
			<p>④ 이용자는 회사의 명시적 동의가 없는 한 서비스 이용 권한, 기타 이용 계약상의 지위를 타인에게 양도, 매도, 증여할 수 없으며 무형자산을 담보로 제공할 수 없습니다.</p>
			<p>⑤ 이용자는 회사의 사전 승낙 없이 서비스를 이용하며 영업활동을 할 수 없으며, 그 영업활동의 결과에 대한 책임은 이용자에게 있습니다. 또한 이용자는 이와 같은 영업활동으로 회사에 손해를 끼칠 경우 손해배상 의무를 지며, 회사는 해당 이용자에 대해 서비스 이용 제한 및 적법한 절차를 거쳐 손해배상 등을 청구할 수 있습니다.</p>
			<p>⑥ 이용자는 회사에서 제공하는 서비스 본래의 이용목적 이외의 용도로 사용해서는 안됩니다. 이용자는 아래 각 호의 행위를 하여서는 안되며, 이에 해당되는 경우 본 약관 및 각 서비스 별 약관 및 운영정책 등에 따라 이용자의 서비스 이용을 제한하거나 수사기관의 고발조치 등 적법한 조치를 포함한 제재를 가할 수 있습니다.</p>
			 <p>1. 타인의 개인 정보를 도용하거나 부정하게 사용하는 행위</p>
			 <p>2. “회사”의 운영진 또는 직원을 사칭하는 행위</p>
			 <p>3. “회사”의 클라이언트 프로그램을 변경하거나, 서버를 해킹하는 행위</p>
			 <p>4. “회사”프로그램 상의 버그를 악용하는 행위</p>
			 <p>5. 다른 이용자를 희롱 또는 위협하거나 고통, 피해, 또는 불편을 주는 행위</p>
			<p> 6. “회사”의 게시물 또는 타인의 게시물 일부 또는 전체를 임의로 변경하 거나 삭제하는 행위</p>
			 <p>7. 서비스 이용 목적 외 다른 이용자의 개인정보를 수집 또는 저장하는 행위</p>
			 <p>8. “회사”가 제공하는 “앱” 이용방식, 기획의도를 변경하거나 서비스에       비정상적으로 위해를 가하거나 고의로 발행하는 일체의 행위</p> 
			 <p>9. 본 서비스를 통해 얻은 정보를 회사 또는 다른 이용자의 사전 승낙없이       서비스 이용 외의 목적으로 복제하거나, 이를 방송 등에 사용하거나 제       3자에게 제공하는 행위</p>
			 <p>10. 공공질서 및 미풍양속에 반하는 저속하거나 음란한 내용의 정보, 문장,       음향, 동영상 등을 게시하거나 기타 방법으로 다른 이용자에게 유포하       는 등 불법적인 목적으로 서비스를 이용하는 행위</p>
			 <p>11. 본 약관을 포함하여 기타 회사가 정한 제반 규정 또는 이용 조건을 위       반 하는 행위 및 기타 관계 법령에 위배되는 행위</p>
			
			<p class="termsTitle">제11조 개인정보보호</p>
			<p>“회사”는 이용자들의 개인정보를 중요시하며, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 개인정보보호법, 전기통신사업법 등 관련 법규를 준수하고 있습니다. 다만 회사는 이용자의 귀책사유로 인해 노출된 정보에 대해서 일체의 책임을 지지 않습니다.</p>
			
			<p class="termsTitle">제12조 양도금지</p>
			<p>이용자는 서비스의 이용권한, 기타 이용 계약상 지위를 타인에게 양도, 증여할 수 없으며 게시물에 대한 저작권을 포함한 모든 권리 및 책임은 이를 게시한 이용자에게 있습니다.</p>
			
			<p class="termsTitle">제4장 서비스의 이용제한</p>
			
			<p class="termsTitle">제13조 서비스의 제한 등</p>
			<p>① “회사”는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간통신사업자가 전기통신서비스를 중지하는 등 부득이한 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다.</p>
			<p>② 무료서비스는 “회사”의 경영정책 등의 사유로 서비스의 전부 또는 일부가 제한되거나 중지될 수 있으며, 유료로 전환될 수 있습니다.</p>
			<p>③ “회사”는 서비스의 이용을 제한하거나 정지하는 때와 무료서비스를 유료로 전환하는 때에는 그 사유 및 제한기간, 예정일시 등을 지체없이 이용자에게 알려야 합니다.</p>
			
			<p class="termsTitle">제14조 서비스의 제공중단, 이용제한 등</p>
			<p>① “회사”는 이용자가 유료서비스의 요금 등을 납부하지않은 경우 전부 또는 일부의 서비스 제공을 중단할 수 있습니다.</p>
			<p>② “회사”는 이용자가 다음 각 호에 해당하는 경우 이용자의 서비스 이용을 전부 또는 일부 제한할 수 있습니다.</p>
			 <p>1. 제10조의 규정에 의한 각 의무를 이행하지 않는 경우</p>
			 <p>2. 다량의 정보를 게시, 등록하여 서비스의 안정적인 운영을 방해하는 경우</p>
			 <p>3. 타 이용자의 의사에 반하는 광고성 정보를 지속적으로 게시,전송하는 경우</p>
			 <p>4. 바이러스 프로그램 등을 유포하는 경우</p>
			 <p>5. 제3자의 지적재산권을 침해하는 경우</p>
			
			<p class="termsTitle">제15조 이용제한 및 해제절차</p>
			<p>① “회사”가 제13조에 의하여 이용제한을 하고자 하는 때에는 그 사유, 일시 및 기간을 정하여 이용제한 7일전까지 SMS 또는 전자우편 등의 방법으로 해당 이용자에게 통지합니다. 다만, 긴급하게 이용을 제한할 필요가 있는 경우에는 그러하지 않습니다.</p>
			<p>② 전항의 규정에 의하여 이용정지의 통지를 받은 이용자는 그 이용정지의 통지에 대하여 이의가 있을 때에는 아래와 같은 방법으로 이의신청을 할 수 있습니다.</p>
			<p>고객센터 이메일 : contact@bizworks.co.kr</p>
			<p>③ “회사”는 이용정지 기간 중에 그 이용정지 사유가 해소된 것이 확인된 경우에는 이용정지조치를 즉시 해제합니다.</p>
			
			<p class="termsTitle">제16조 서비스 해제, 해지 및 청약철회</p>
			<p>① 이용자가 “앱” 이용을 해지하고자 할 때에는 회원탈퇴 신청을 통해 이용 해지를 요청할 수 있습니다.</p>
			<p>② “회사”는 이용자의 서비스 청약철회, 해제 또는 해지의 의사표시를 수신한 경우 지체 없이 그 사실을 이용자에게 회신합니다. 다만, 계약당사자가 있는 경우 계약당사자에게 그 사실을 통보하고 계약당사자의 승낙 여부에 따라 서비스 청약철회, 해제 또는 해지 여부를 결정할 수 있습니다.</p>
			<p>③ 유료서비스를 이용하는 이용자는 관련 법령에 따라 청약철회를 할 수 있으며, 이에 대하여는 해당 서비스 별 약관에서 정하는 바에 따릅니다.</p>
			
			<p class="termsTitle">제5장 게시물 관리 및 저작권</p>
			
			<p class="termsTitle">제17조 게시물 관리</p>
			<p>① 이용자의 게시물이 정보통신망법 및 저작권법 등 관련법령에 위배되는 내용을 포함하는 경우, 권리자는 관련법령이 정한 절차에 따라 해당 게시물의 게시중단 및 삭제 등을 요청할 수 있으며, “회사”는 관련법령에 따라 조치를 취하여야 합니다.</p>
			<p>② “회사”는 전항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 회사정책 및 다음 각 호에 해당하는 게시물이나 자료에 대하여 사전 통지 없이 삭제하거나 등록을 거부할 수 있습니다.</p>
			<p> 1. 다른 이용자 또는 제3자에게 심한 모욕을 주거나 명예를 손상시키는 내용인 경우</p>
			 <p>2. 청소년보호법에 위반되는 내용의 정보, 문장, 영상 등을 게시하거나 링크 시키는 경우</p>
			 <p>3. 청소년보호법에 위반되는 음란한 내용이거나 음란사이트를 링크 시키는 경우</p>
			 <p>4. 불법복제 또는 해킹을 조장하는 내용인 경우</p>
			 <p>5. 영리를 목적으로 하는 광고일 경우</p>
			 <p>6. 범죄와 결부된다고 객관적으로 인정되는 내용일 경우</p>
			 <p>7. 다른 이용자 또는 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</p>
			 <p>8. “회사”에서 규정한 게시물 원칙에 어긋나거나, 게시판 또는 동영상 등록 메뉴 성격에 부합하지 않는 경우</p>
			
			<p class="termsTitle">제18조 게시물의 저작권</p>
			<p>① 이용자가 서비스 내에 게시한 게시물의 저작권은 기본적으로 게시한 이용자에게 귀속되며, 저작권법 등 관련법령에 위배되어 분쟁 발생 시 모든 책임은 게시물을 게시한 이용자에게 있습니다.</p>
			<p>② 게시물은 검색결과 내지 회사의 서비스 및 관련 프로모션 등에 노출될 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수 있습니다. 이 경우 회사는 별도의 이용약관을 통해 이용자의 동의를 얻어야 합니다.</p>
			
			<p class="termsTitle">제19조 광고 게재 및 광고주와의 거래</p>
			<p>① “회사”가 이용자에게 서비스를 제공할 수 있는 서비스 투자 기반이 일부는 광고 게재를 통한 수익으로부터 나옵니다. 서비스를 이용하고자 하는 이용자는 서비스 이용 시 노출될 수 있는 광고 게재에 대해 동의하는 것으로 간주됩니다.</p>
			<p>② “회사”는 서비스에 게재되어 있거나 서비스를 통한 광고주의 판촉활동에 이용자가 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다.</p>
			
			<p class="termsTitle">제6장 손해배상 및 면책</p>
			
			<p class="termsTitle">제20조 손해배상</p>
			<p>① “회사”는 무료서비스의 장애, 제공 중단, 보관된 자료 멸실 또는 삭제, 변조 등으로 인한 손해에 대하여는 배상하지 않습니다.</p>
			<p>② 유료 서비스 이용자 또는 회사가 본 약관 또는 별도 서비스 별 약관의 규정을 위반함으로 인하여 상대방에게 손해가 발생하게 되는 경우, 책임있는 일방은 상대방에게 그 손해를 배상하여야 합니다. 그 손해는 통상의 손해에 한하며, 특별한 사정으로 인한 손해는 그것을 알았거나 알 수 있었을 때에 배상책임을 부담합니다.</p>
			<p>③ 이용자가 제10조의 의무를 위반하거나 이용자 간 승낙, 거절을 결정할 수 있는 매칭서비스에 따라 다른 이용자에게 손해가 발생한 경우 회사는 책임을 지지 않으며, 관련 손해배상 등의 책임은 의무를 위반한 이용자 및 상호 이용 당사자에게 있습니다.</p>
			
			<p class="termsTitle">제21조 면책조항</p>
			<p>“회사”는 다음 각 호에 해당하는 경우 책임이 면제됩니다.</p>
			 <p>1. 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우</p>
			 <p>2. 기간통신사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지  아니하여 손해가 발생한 경우</p>
			 <p>3. 서비스영 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해의 경우</p>
			 <p>4. 이용자의 귀책사유로 인한 서비스 이용의 장애 또는 손해가 발생한 경우</p>
			 <p>5. 이용자의 컴퓨터 또는 스마트기기 오류에 의해 손해가 발생한 경우</p>
			 <p>6. 이용자가 신상정보 및 전자우편주소를 부실하게 기재하여 손해가 발생한 경우</p>
			 <p>7. 이용자가 서비스를 이용하여 기대하는 수익을 얻지 못하거나 상실한 경우</p>
			 <p>8. 이용자가 서비스를 이용하며 다른 이용자로 인해 입게되는 물질적,정신적 피해에 대한 경우</p>
			 <p>9. 이용자 상호 간 및 이용자와 제3자 상호 간에 서비스를 매개로 발생한 분쟁 및 이로 인한 손해가 발생한 경우</p>
			
			<p class="termsTitle">제22조 관할법원 및 준거법</p>
			<p>① 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 해당 규정에 따릅니다.</p>
			<p>② 회사의 귀책사유로 인한 서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 회사 본사 소재지를 관할하는 법원을 관할 법원으로 합니다.</p>
			
			<p class="termsTitle">부칙</p>
			
			<p>본 약관은 2019년 05월 24일부터 시행합니다.</p>					
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>

