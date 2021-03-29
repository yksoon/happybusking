<!DOCTYPE html>    
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>
<meta charset="UTF-8">

<div data-role="page" id="app_useinfoterms">	
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div data-role="content" style="text-align:left; padding: 15px; font-size:14px; border-top:1px solid #eeeeee;">
			<p class="termsTitle">개인정보처리 및 취급 방침</p>

			<p>본 해피버스킹 개인정보취급방침은 가치누리(이하 “회사”)가 www.happybusking.com (이하 “해피버스킹”) 이용자들의 개인정보보호를 매우 중요시하며, 이용자가 회사의 서비스를 이용함과 동시에 온라인상에서 회사에 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있습니다. 이에 “해피버스킹”은 통신비밀보호법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에관한 법률 등 정보통신서비스제공자가 준수하여야 할 관련 법규상의 개인정보보호 규정 및정보통신부가 제정한 개인정보보호지침을 준수하고 있습니다.</p>
			
			<p class="termsTitle">제1조. 개인정보 수집에 대한 동의</p>
			<p>해피버스킹은 이용자들이 회사의 개인정보처리 및 취급방침 또는 이용약관의 내용에 대하여 ‘동의합니다’ 체크박스를 두어, 고객이 직접 ‘동의합니다’에 체크한 경우 개인정보 수집에 대해 동의한 것으로 봅니다.</p>
			
			<p class="termsTitle">제2조. 개인정보의 수집목적 및 이용목적</p>
			<p>해피버스킹은 이용자 서비스를 통하여 이용자들에게 맞춤식 서비스를 비롯한 보다 더 향상된 양질의 서비스를 제공하기 위하여 이용자 개인의 정보를 수집하고 있습니다. 해피버스킹은 이용자의 사전 동의 없이는 이용자의 개인 정보를 공개하지 않으며, 수집목적 및 이용목적은 다음과 같습니다.</p>
			<p>① 이용자관리</p>
			<p>이용자가 서비스 이용에 따른 본인 확인 절차에 이용, 연령제한 서비스 이용, 해피버스킹 이용약관 위반 이용자에 대한 이용제한 조치, 불량이용자의 부정이용 방지와 비인가 사용 방지, 서비스의 원활한 운영에 지장을 미치는 행위 및 서비스 부정이용 행위 제재, 가입의사 확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리 및 해결을 위한 의사소통 경로의 확보, 고지사항 전달, 유료서비스 이용에 대한 요금결제, 물품배송(공연물품)시 정확한 배송지의 확보</p>
			<p>② 서비스 제공에 관한 계약 이행</p>
			<p>콘텐츠 제공, 특정 맞춤 서비스 제공, 물품배송, 본인인증</p>
			<p>③ 신규서비스 개발 및 마케팅 광고 활용</p>
			<p>신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스 유효성 확인, 이벤트 정보 및 참여기회 제공, 광고성 정보 제공, 접속빈도 파악, 신규 서비스 및 신상품이나 이벤트 정보 등의 안내</p>
			
			<p class="termsTitle">제3조. 수집하는 개인정보 항목 및 수집방법</p>
			<p>① 수집하는 개인정보 항목</p>
			<p> 1. 로그인시 :</p>
			<p> 2. 자동수집항목 : 서비스 이용기록, 접속로그, 쿠키, 접속IP정보</p>
			<p> 3. 맞춤 서비스 이용자에 한해 아래와 같이 개인정보를 수집합니다.</p>
			
			<table>
				<tr>
					<th style="width: 15%;">구분</th>
					<th style="width: 20%;">서비스명</th>
					<th style="width: 75%;">수집하는 개인정보 항목</th>
				</tr>
				<tr>
					<td rowspan="2">관람자</td>
					<td>아티스트 등록</td>
					<td class="tLeft">프로필사진, 아티스트명, 이름, 휴대폰번호, SNS계정, 주소</td>
				</tr>
				<tr>
					<td>공연의뢰</td>
					<td class="tLeft">이름, 휴대폰번호, 공연장주소</td>
				</tr>
				
				<tr>
					<td rowspan="2">아티스트</td>
					<td>QR 배너</td>
					<td class="tLeft">아티스트등록 정보와 동일</td>
				</tr>
				<tr>
					<td>물품지원</td>
					<td class="tLeft">아티스트등록 정보와 동일, 배송지주소</td>
				</tr>
			</table>
					
			<p>② 수집방법
			<p>회사는 아래 각 호와 같은 방법으로 개인정보를 수집합니다.
			 1. 애플리케이션을 통한 로그인, 아티스트등록, 공연의뢰, QR배너신청, 물품지원, 고객센터문의, 이벤트응모<br>
			 2. 이용자 직접 입력 방식을 통한 수집<br>
			 3. 생성정보 수집틀을 통한 수집</p>
			
			<p class="termsTitle">제4조. 수집하는 개인정보의 보유 및 이용기간</p>
			<p>① 해피버스킹은 이용자가 회사에서 제공하는 서비스를 이용하는 동안 이용자들의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다.</p>
			<p>② 이용자의 개인정보는 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기하는 것을 원칙으로 합니다. 다만, 해피버스킹 불량 이용자의 부정한 이용의 재발을 방지하기 위해 이용계약 해지일로부터 1년간 해당 이용자의 정보를 보유할 수 있습니다.</p>
			<p>③ 상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 해피버스킹은 관계법령에 정한 일정한 기간 동안 아래 각 호와 같이 이용자 정보를 보관합니다.</p>
			<p> 1. 계약 또는 청약철회 등에 관한 기록<br>
			    보존이유 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
			    보존기간 : 5년</p>
			<p> 2. 대금결제 및 재화 등의 공급에 관한 기록<br>
			    보존이유 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
			    보존기간 : 5년</p>
			<p> 3. 소비자의 불만 또는 분쟁처리에 관한 기록<br>
			    보존이유 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
			    보존기간 : 5년</p>
			<p> 4. 웹 또는 앱 방문기록<br>
			    보존이유 : 통신비밀보호법<br>
			    보존기간 : 3개월</p>
			 <p>5. 표시. 광고에 관한 기록<br>
			    보존이유 : 상거래 등에서의 소비자보호에 관한 법률<br>
			    보존기간 : 6개월</p>
			
			<p class="termsTitle">제5조. 개인정보 취급위탁</p>
			<p>회사는 서비스 향상을 위해서 개인정보를 전문기관 및 업체에 위탁할 수 있으며, 관계 법령에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.</p>
			
			<p class="termsTitle">제6조. 개인정보의 파기절차 및 방법</p>
			<p>이용자의 개인정보는 개인정보의 수집 및 이용목적이 달성되거나 보유 기간이 종료되면 지체 없이 파기합니다. 다만, 다른 법령에 의해 보관해야 하는 정보는 법령이 정한 기간 동안 별도 분리보관 후 파기합니다.</p>
			 <p>1. 파기절차<br>
			   이용자의 개인정보는 개인정보의 수집 및 이용목적이 달성되거나 보유기    간이 종료되면 지체없이 파기합니다. 단, 내부 방침 및 기타 관련 법령에    의한 정보보호 사유에 따라(보유 및 이용기간 참조)일정 기간 저장이 필요    한 경우에는 별도의 DB에 옮겨져 내부 규정 및 관련 법령을 준수하여 일    정 기간 동안 안전하게 보관된 후 파기합니다.</p>
			 <p>2. 파기방법<br>
			  전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방    법을 사용하여 삭제하며, 종이에 출력괸 개인정보는 복구가 불가능한 세단    기로 분쇄하여 파기합니다.</p>
			 <p>3. 개인정보 분리보관 및 파기<br>
			        가. 장기 미접속자의 개인정보는 개인정보보호법에 의거하여 다른 이용자       의 개인정보와 분리하여 보관, 관리 또는 파기합니다.<br>
			      - 1년 이상 미접속자 : 입력한 모든 개인정보 분리 보관 <br>
			      - 3년 이상 미접속자 : 입력한 모든 개인정보 파기 및 자동탈퇴처리<br>
			        나. 미접속 기간은 최종 로그인 일자를 기반으로 산정합니다.<br>
			        다. 분리 보관된 미접속자의 개인정보는 파기시점 이전까지는 해당 이용자       의 요청에 따라 서비스 이용이 다시 제공됩니다.</p>
			 
			<p class="termsTitle">제7조. 이용자 자신의 개인정보 관리(열람,정정,삭제 등)에 관한 사항</p>
			<p>이용자는 언제든지 앱의 “마이페이지>정보수정”을 통하여 개인정보를 열람, 정정 처리할 수 있습니다.</p>
			
			<p class="termsTitle">제8조. 이용자의 의무</p>
			<p>이용자는 자신의 개인정보를 보호할 의무가 있으며, 회사의 귀책사유가 없이 이용자 본인의 부주의나 브라우져 취약점, 관계법령에 의한 보안조치로 차단할 수 없는 방법이나 기술을 사용한 해킹 등 회사가 상당한 주의에도 불구하고 통제할 수 없는 인터넷 상의 문제 등으로 개인정보가 유출되어 발생한 문제에 대해서는 회사는 일체의 책임을 지지않습니다.</p>
			<p>① 이용자는 자신의 개인정보를 최신의 상태로 유지해야 하며, 이용자의 부정확한 정보 입력으로 발생하는 문제의 책임은 이용자 자신에게 있습니다.</p>
			<p>② 이용자는 회사의 서비스를 이용한 후에는 반드시 로그인 계정을 종료하고 프로그램을 종료해야 합니다.</p>
			<p>③ 이용자는 정보통신망이용촉진 및 정보보호 등에 관한 법률, 개인정보보법 등 기타 개인정보에 관한 법률을 준수하여야 합니다.</p>
			
			<p class="termsTitle">제9조. 링크사이트</p>
			<p>① 회사는 해피버스킹을 통해 이용자에게 다른 회사의 웹사이트 또는 앱, 자료에 대한 링크를 제공할 수 있습니다. 이 경우 회사는 외부사이트 및 자료에 대한 아무런 통제권이 없으므로 그로부터 제공받는 서비스나 자료의 신뢰성에 대해 책임질 수 없으며 어떠한 보증도 할 수 없습니다.</p>
			<p>② 해피버스킹이 포함하고 있는 링크를 클릭하여 타 사이트의 페이지로 옮겨갈 경우 해당 사이트의 갸인정보취급방침은 해피버스킹과는 무관하므로 새로 방문한 사이트의 정책을 검토하시기 바랍니다.</p>
			
			<p class="termsTitle">제10조. 개인정보보호를 위한 기술적, 관리적 대책</p>
			<p>해피버스킹은 개인정보의 안전성 확보 조치를 위해 다음과 같이 안전성 확보에 필요한 기술적, 관리적 및 물리적 조치를 취하고 있습니다.</p>
			<p>① 개인정보 취급 직원의 교육
			 개인정보를 취급하는 직원을 지정하고 담당자에게 한정시켜 개인정보를 관   리하는 대책을 시행하고 있습니다.</p>
			<p>② 개인정보의 암호화
			 이용자의 개인정보는 암호화되어 저장 및 관리되고 있으며, 중요한 데이터   는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용한는 등의   별도 보안기능을 사용하고 있습니다.</p>
			<p>③ 접속기록의 보관 및 위변조 방지
			 개인정보처리시스템에 접속한 기록을 최소 3개월 이상 보관, 관리하고 있으   며 접속기록이 위변조되지 않도록 보안기능을 사용하고 있습니다.</p>
			<p>④ 개인정보에 대한 접근 제한
			 개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경,    말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 취하고   있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있   습니다.</p>
			
			<p class="termsTitle">제11조. 개인정보관리책임자 및 담당자</p>
			
			<table>
				<tr>
					<td>개인정보관리책임자</td>
					<td>개인정보관리책임자</td>
				</tr>
				<tr>
					<td class="tLeft">- 성  명 : 박준영<br>
						- 소  속 : 가치누리<br>
						- 직  급 : 대표이사<br>
						- 연락처 : 02-780-2328<br>
						- 메  일 : contact@bizworks.co.kr</td>
					<td class="tLeft">- 성  명 : 용광순<br>
						- 소  속 : 개발팀<br>
						- 직  급 : 사원<br>
						- 연락처 : 02-780-2328<br>
						- 메  일 : contact@bizworks.co.kr</td>
				</tr>
			</table>
			
			<p class="termsTitle">제12조. 고지의 의무</p>
			<p>개인정보취급방침 내용 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일전부터 홈페이지 또는 앱을 통해 고지할 것입니다. 다만, 개인정보의 수집 및 활용, 제3자 제공 등과 같이 이용자 권리의 중요한 변경이 있을 경우에는 최소 30일 전에 고지합니다.</p>
			
			<p class="termsTitle">부칙</p>
			<p>1. 본 개인정보취급방침은 2019년 05월 24일부로 시행합니다.</p>
							
		</div>
		<%@include file="/app_root/jsp/footer/footer.jsp" %>
</div>


