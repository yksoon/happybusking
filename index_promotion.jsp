<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">

</style>
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js"></script>

<%
	String userAgent = request.getHeader("user-agent");
	if (userAgent.indexOf("Android") > -1 || userAgent.indexOf("iPhone") > -1) {
%>
<script type="text/javascript" src="/js/homepage/m_homepage.js?ver=1.0.0"></script>
<%
	} else {
%>
<%-- <script type="text/javascript" src="/js/index_promotion/index_promotion.js?ver=1.0.4"></script> --%>
<%
	}
%>

<script type="text/javascript" src="/js/index_promotion/index_promotion.js?ver=1.0.5" ></script>
<link type="text/css" rel="stylesheet" href="/css/index_promotion/index_promotion.css?ver=1.0.8"  />
<%-- <link type="text/css" rel="stylesheet" href="/css/index_promotion/index_promotion.css?ver=1.0.7" media="only screen and (min-width: 1281px)" />
<link type="text/css" rel="stylesheet" href="/css/index_promotion/index_promotion2.css?ver=1.0.0" media="only screen and (min-width: 641px) and (max-width: 1280px)" />
<link type="text/css" rel="stylesheet" href="/css/index_promotion/index_promotion3.css?ver=1.0.0" media="only screen and (max-width: 640px)" /> --%>

<script type="text/javascript">

</script>

<head>
<title>예술인 고용보험!</title>
</head>
<body>
	<div class="wrapper" >
		<div id="ip_container">
            <!-- 이미지 자세히보기 팝업 -->
            <div id="ip_ct2_popup"></div>
			<div class="ip_header" >
				<div class="ip_header_t_on" id="ip_artist_main"><span class="ip_header_t_s">예술인 고용보험 제도 안내</span></div>
				<div class="ip_header_t_base" id="ip_artist_qa"><span class="ip_header_t_s">예술인 고용보험 Q&A</span></div>
			</div>
			<div class="ip_container_content_a" >
				<div class="ip_main_content">
					<div class="ip_main_content_a">‘2020년 12월 10일, 예술인 고용보험 적용 시행’</div>
					<div class="ip_main_content_b">이제 예술인도 고용보험 가입으로</div>
					<div class="ip_main_content_c">실업급여, 출산급여 받자</div>
					<div class="ip_main_content_d">
						<span>실업급여 : 1일 평균 급여액(기초일액)의 60%를 기준으로 120일~270일간 지급 (2021년 기준보수 기준 최소 월 120만원 예상)</span>
						<span>출산전후급여 : 출산일 직전 1년간 월평균 보수의 100% 지급 (최대 월 200만원 예상)</span>
					</div>
					<div class="ip_main_content_e"><span>나의 대상여부 확인해보기</span></div>
					<a href='http://www.freepik.com'>Designed by Freepik</a>
				</div>
				<div class="ip_page_body_container">
					<div class="ip_content1">
						<div class="ip_content_title">
							<div class="ip_line"></div>
							<div class="ip_content_title_b">
								<div class="ip_content_title_f">01. 예술인고용보험</div>
							</div>
						</div>	
						<div class="ip_content_no">01</div>
						<div class="ip_content_ct1">
							<div class="ip_content_sub_title">예술인 고용보험이란?</div>
							<div class="ip_content_ct1_q"><span class="ip_content_q">Q.</span><span class="ip_conrent_q_f" style="margin-left: 10px;">버스커도 예술인 고용보험에 가입할 수 있나요?</span></div>
							<div class="ip_content_ct1_box">
								<div style="padding-top: 15px;">네. 일정 요건에 해당되면 가입 대상에 해당됩니다.</div>
								<div>예술인 고용보험은 프리랜서 예술인을 위한 사회보장 보험입니다.</div>
								<div> 1개월 미만 문화예술용역계약 및 공연활동을 통한 소득(소득기준 없음)만 있다면 단기예술인으로 예술활동증명</div>
								<div>여부와 관계없이 가입대상에 해당됩니다.</div>
							</div>
							<div class="ip_content_ct1_img_list">
								<div class="ip_content_ct1_img_list_box">	
									<img src="/img/index_promotion/ct_img.svg">
									<div class="ip_content_ct1_img_text1">고용보험 당연가입</div>
								</div>
								<div class="ip_content_ct1_img_list_box">	
									<img src="/img/index_promotion/ct_img4.svg">
									<div class="ip_content_ct1_img_text2">서면계약 체결</div>
								</div>
								<div class="ip_content_ct1_img_list_box">	
									<img src="/img/index_promotion/ct_img3.svg">
									<div class="ip_content_ct1_img_text3"><div>실업급여 및</div><div>출산전후 급여</div></div>
								</div>
								<div class="ip_content_ct1_img_list_box_end">	
									<img src="/img/index_promotion/ct_img2.svg">
									<div class="ip_content_ct1_img_text4">보험료 지원</div>
								</div>	
							</div>	
							<%-- <div class="ip_content_ct1_img_text_list">
								<div class="ip_content_ct1_img_text1">고용보험 당연가입</div>
								<div class="ip_content_ct1_img_text2">서면계약 체결</div>
								<div class="ip_content_ct1_img_text3"><div>실업급여 및</div><div>출산전후 급여</div></div>
								<div class="ip_content_ct1_img_text4">보험료 지원</div>
							</div> --%>
							<div class="ip_content_ct_but" id="ip_ct_but_a"><span>예술인 고용보험 알아보기</span></div>
						</div>
					</div>
					<div class="ip_content2">
						<div class="ip_content_title">
							<div class="ip_line"></div>
							<div class="ip_content_title_b"><div class="ip_content_title_f">02. 해피버스킹</div></div>
						</div>
						<div class="ip_content_no">02</div>
						<div class="ip_content_ct2">
							<div class="ip_content_sub_title"><div>버스커 고용보험,</div><div>해피버스킹과 함께하면 쉬워집니다</div></div>
							<div class="ip_content_ct2_content">
								<div class="ip_content_ct2_content_l">
									<img class="ip_content_ct2_img1" src="/img/index_promotion/happybusking_1292.png">
									<img class="ip_content_ct2_img2" src="/img/index_promotion/happybusking_1292.png">
									<img class="ip_content_ct2_img3" src="/img/index_promotion/happybusking_1292.png">
								</div>
								<div class="ip_content_ct2_content_r">
									<div class="ip_content_ct2_content1">
										<div class="ip_content_ct2_content_t">
											문화예술용역계약 체결, 고용보험 가입 이렇게 하세요!
										</div>
										<div class="ip_content_ct2_content1_box">
											<div class="ip_content_ct2_content_box_b">
												<div class="ip_content_ct2_content_box_b_l">해피버스킹 앱 ‘전자계약’과 ‘보험사무대행기관’을 활용해 보세요.</div>
												<div class="ip_content_ct2_content_box_b_r"><div class="ip_content_ct2_content_box_b_r_b"></div><div class="ip_content_ct2_content_box_b_r_a" id="ip_signature_detail">전자계약 자세히 보기</div></div>
											</div>
											<div class="ip_content_ct2_content_box_n" style="margin-top: 8px;">해피버스킹에서는 버스커와 주최측의 고용보험 취득, 신고 편의를 위해 앱을 이용해 체결할 수 있는</div>
											<div class="ip_content_ct2_content_box_n">문화예술용역 전자계약 – 전자서명 플랫폼을 제공하고 있으며 근로복지공단 인가 *보험사무대행기관을</div>
											<div class="ip_content_ct2_content_box_n">통해 무상으로 예술인 고용보험 취득신고를 제공해 드리고 있습니다.</div>
										</div>
										<div class="ip_content_ct2_content1_box2">
											<div class="ip_content_ct2_content1_box2_l">
												*
											</div>
											<div class="ip_content_ct2_content1_box2_r">
												<div>보험사무대행기관 제도란?</div>
												<div>사업주의 보험사무 행정처리 부담을 덜어 주기위해 공단의 인가를 받은 노무 전문가로 이루어진 보험사무대행기관이 사업주의</div>
												<div>위임을 받아 대행 서비스를 제공하는 제도입니다. (특히 상시근로자수 30인 미만 사업장에게는 무상 서비스 지원 제공)</div>
											</div>
										</div>
									</div>
									<div class="ip_content_ct2_content2">
										<div class="ip_content_ct2_content_t">
											공연모집 정보를 제공하고 있어요, 공연 활동을 통한 소득을 만들어 보세요!
										</div>
										<div class="ip_content_ct2_content2_box">
											<div class="ip_content_ct2_content_box_b">
												<div class="ip_content_ct2_content_box_b_l">해피버스킹 앱에서 ‘공연모집정보’를 활용해 보세요.</div>
												<div class="ip_content_ct2_content_box_b_r"><div class="ip_content_ct2_content_box_b_r_b"></div><div class="ip_content_ct2_content_box_b_r_a" id="ip_perform_detail">공연모집정보 자세히 보기</div></div>
											</div>
											<div class="ip_content_ct2_content_box_n" style="margin-top: 8px;">전국의 다양한 공연모집 정보와 카페 등 상업공간 등의 공연모집정보를 확인하고 신청해보세요.</div>
											<div class="ip_content_ct2_content_box_n">여러분의 공연활동과 공연소득을 만들 수 있습니다. 매칭된 공연모집 주최와 해피버스킹 앱에서</div>
											<div class="ip_content_ct2_content_box_n">전자계약 체결, 예술인 고용보험 가입까지 편리하게 이용해 보세요.</div>
										</div>
									</div>
									<div class="ip_content_ct2_content3">
										<div class="ip_content_ct2_content_t">
											거리공연(버스킹) 공연팁으로도 예술인 고용보험 가입 대상에 해당될 수 있어요!
										</div>
										<div class="ip_content_ct2_content3_box">
											<div class="ip_content_ct2_content_box_b">
												<div class="ip_content_ct2_content_box_b_l">거리공연 시 해피버스킹 앱 ‘팁박스’를 활용해 보세요.</div>
												<div class="ip_content_ct2_content_box_b_r"><div class="ip_content_ct2_content_box_b_r_b"></div><div class="ip_content_ct2_content_box_b_r_a" id="ip_tip_box_detail">팁박스 자세히 보기</div></div>
											</div>
											<div class="ip_content_ct2_content_box_n" style="margin-top: 8px;">관객이 해피버스킹 팁박스 모바일 간편결제를 이용해 버스커에게 공연 팁 제공 시 해피버스킹을 통해</div>
											<div class="ip_content_ct2_content_box_n">공연활동 및 공연소득 책정이 가능해 단기예술인으로 고용보험가입 대상이 될 수 있습니다.</div>
										</div>
									</div>
								</div>
							</div>
							<div class="ip_content_ct_but" id="ip_ct_but_b"><span>보험사무대행기관 제도 알아보기</span></div>
						</div>
					</div>
					<div class="ip_content3">
						<div class="ip_content_title">
							<div class="ip_line"></div>
							<div class="ip_content_title_b"><div class="ip_content_title_f">03. 프로세스</div></div>
						</div>
						<div class="ip_content_no">03</div>
						<div class="ip_content_ct3">
							<div class="ip_content_sub_title"><div>해피버스킹 앱에서 더 간편해진</div><div>전자계약 체결 단계</div></div>
							<div class="ip_content_ct3_ct">
								<div class="ip_content_ct3_ct_a">공연</div>
								<div class="ip_content_ct3_ct_b">계약</div>
								<div class="ip_content_ct3_ct_c">신고</div>
								<div class="ip_content_ct3_ct_d">지급</div>
								<div class="ip_content_ct3_ct_left">
									<div class="ip_content_ct3_left_img1"><div>예술인을 고용했어요!</div></div>
									<img class="ip_content_ct3_left_img2" src="/img/index_promotion/boss_img.svg">
									<div class="ip_content_ct3_left_text_a">
										<div class="ip_content_ct3_text_b">공연 일정 등록</div>
										<div class="ip_content_ct3_text_s">상업 공간 홍보 및 공연 일정 등록</div>
									</div>
									<div class="ip_content_ct3_left_text_b">
										<div class="ip_content_ct3_text_b">문화예술용역 계약 및 서명</div>
										<div class="ip_content_ct3_text_s">APP 내 문화예술용역 계약 및 서명</div>
									</div>
									<div class="ip_content_ct3_left_text_b">
										<div class="ip_content_ct3_text_b">고용보험 신고</div>
										<div class="ip_content_ct3_text_s">사무대행위탁으로 빠른 신고</div>
									</div>
									<div class="ip_content_ct3_left_text_b">
										<div class="ip_content_ct3_text_b">예술인에게 공연비 입금</div>
										<div class="ip_content_ct3_text_s">고용보험료 제외한 금액 입금</div>
									</div>
								</div>
								<div class="ip_content_ct3_ct_right">
									<div class="ip_content_ct3_right_img1"><div>공연을 계약했어요!</div></div>
									<img class="ip_content_ct3_right_img2" src="/img/index_promotion/artist_img.svg">
									<div class="ip_content_ct3_right_text_a">
										<div class="ip_content_ct3_text_b">상업 공간 공연 신청</div>
										<div class="ip_content_ct3_text_s">상업 공간 공연 확인 및 신청</div>
									</div>
									<div class="ip_content_ct3_right_text_b">
										<div class="ip_content_ct3_text_b">문화예술용역 계약 및 서명</div>
										<div class="ip_content_ct3_text_s">APP 내 문화예술용역 계약 및 서명</div>
									</div>
									<div class="ip_content_ct3_right_text_b">
										<div class="ip_content_ct3_text_b">고용보험 신청</div>
										<div class="ip_content_ct3_text_s">공연 끝난 후 정보 작성</div>
									</div>
									<div class="ip_content_ct3_right_text_b">
										<div class="ip_content_ct3_text_b">공연비 확인</div>
										<div class="ip_content_ct3_text_s">고용보험료 제외한 금액</div>
									</div>
								</div>
							</div>
							<div class="ip_content_ct3_foot">
								<div class="ip_content_ct3_foot_a">복잡한 고용보험 신고 해피버스킹에서 확 줄였습니다</div>
								<div class="ip_content_ct3_foot_b">근로복지공단 인가 보험 사무대행기관 사무대행 위탁</div>
							</div>
						</div>
					</div>
					<div class="ip_content4">
						<div class="ip_content_title">
							<div class="ip_line"></div>
							<div class="ip_content_title_b"><div class="ip_content_title_f">04. 대상확인</div></div>
						</div>
						<div class="ip_content_no">04</div>
						<div class="ip_content_ct4">
							<div class="ip_content_sub_title">고용보험 대상여부 확인하기</div>
							<div class="ip_content_ct4_q1"><span class="ip_content_q" style="margin-left: 17px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 10px;">예술인의 기준이 어떻게 되나요?</span></div>
							<div class="ip_content_ct4_q2"><span class="ip_content_q" style="margin-left: 17px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 10px;">월수입이 적어도 실업급여 받을 수 있나요?</span></div>
							<div class="ip_content_ct4_q3"><span class="ip_content_q" style="margin-left: 17px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 10px;">계약기간이 짧아도 가입할 수 있나요?</span></div>
							<div class="ip_content_ct4_text">	
								<div>여러분이 예술인 고용보험 가입 대상인지, 실업급여는 어느 기간동안 얼마나 받을 수 있는지</div>
								<div>보험료는 얼마나 내야 되는지 해피버스킹에서 제공드리는 시뮬레이터를 통해 확인해 보세요.</div>
							</div>	
							<div class="ip_content_ct_but" id="ip_ct_but_c"><span>나의 대상여부 확인해보기</span></div>
						</div>
					</div>
				</div>
			</div>
			<div class="ip_container_content_b" style="display: none">
				<div class="ip_qa_content_list">
					<div class="ip_qa_content">
						<div class="ip_qa_content_q" id="ip_q_1" style="margin-top: 60px;">
							<span class="ip_content_q" style="margin-left: 33px;line-height: 89px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준이 어떻게 되나요?</span>
						</div>
						<div class="ip_qa_content_a" id="ip_a_1" style="display: none; margin-top: 60px;">
							<div class="ip_qa_content_a_q">
								<span class="ip_content_q" style="margin-left: 33px;line-height: 89px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준이 어떻게 되나요?</span>
							</div>
							<div class="ip_qa_content_a_line">
							</div>
							<div class="ip_qa_content_a_a">
								<div>
									<span class="ip_content_a" style="margin-left: 33px;line-height: 89px;">A.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준을 알려드립니다</span>
								</div>
								<div class="ip_qa_content_a_text">
									특검은 “대법원 전원합의체는 이 부회장이 직무와 관련한 이익을 얻기 위해 매수 의사로 적극적으로 뇌물을 제공했다고 판단했다”며 “이 부회장이 직무와 관련한 이익을 얻기 위해 뇌물을 공여했다고 판시함으로써 이 사건 범행이 대통령 직무와 관련된 이익을 얻기 위해 능동적으로 뇌물을 제공한 사건임을 인정했다”고 말했다.
								</div>	
							</div>	
						</div>
					</div>
					<div class="ip_qa_content">
						<div class="ip_qa_content_q" id="ip_q_2">
							<span class="ip_content_q" style="margin-left: 33px;line-height: 89px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준이 어떻게 되나요?</span>
						</div>
						<div class="ip_qa_content_a" id="ip_a_2" style="display: none">
							<div class="ip_qa_content_a_q">
								<span class="ip_content_q" style="margin-left: 33px;line-height: 89px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준이 어떻게 되나요?</span>
							</div>
							<div class="ip_qa_content_a_line">
							</div>
							<div class="ip_qa_content_a_a">
								<div>
									<span class="ip_content_a" style="margin-left: 33px;line-height: 89px;">A.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준을 알려드립니다</span>
								</div>
								<div class="ip_qa_content_a_text">
									특검은 “대법원 전원합의체는 이 부회장이 직무와 관련한 이익을 얻기 위해 매수 의사로 적극적으로 뇌물을 제공했다고 판단했다”며 “이 부회장이 직무와 관련한 이익을 얻기 위해 뇌물을 공여했다고 판시함으로써 이 사건 범행이 대통령 직무와 관련된 이익을 얻기 위해 능동적으로 뇌물을 제공한 사건임을 인정했다”고 말했다.
								</div>	
							</div>
						</div>
					</div>
					<div class="ip_qa_content">
						<div class="ip_qa_content_q" id="ip_q_3">
							<span class="ip_content_q" style="margin-left: 33px;line-height: 89px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준이 어떻게 되나요?</span>
						</div>
						<div class="ip_qa_content_a" id="ip_a_3" style="display: none">
							<div class="ip_qa_content_a_q">
								<span class="ip_content_q" style="margin-left: 33px;line-height: 89px;">Q.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준이 어떻게 되나요?</span>
							</div>
							<div class="ip_qa_content_a_line">
							</div>
							<div class="ip_qa_content_a_a">
								<div>
									<span class="ip_content_a" style="margin-left: 33px;line-height: 89px;">A.</span><span class="ip_conrent_q_f" style="margin-left: 17px;">예술인의 기준을 알려드립니다</span>
								</div>
								<div class="ip_qa_content_a_text">
									특검은 “대법원 전원합의체는 이 부회장이 직무와 관련한 이익을 얻기 위해 매수 의사로 적극적으로 뇌물을 제공했다고 판단했다”며 “이 부회장이 직무와 관련한 이익을 얻기 위해 뇌물을 공여했다고 판시함으로써 이 사건 범행이 대통령 직무와 관련된 이익을 얻기 위해 능동적으로 뇌물을 제공한 사건임을 인정했다”고 말했다.
								</div>	
							</div>
						</div>
					</div>		
				</div>
			</div>
		</div>
	</div>
</body>
</html>

