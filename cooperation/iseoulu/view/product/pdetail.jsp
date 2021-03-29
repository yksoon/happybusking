<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<%@include file="../../importhead.jsp" %>
<link type="text/css" rel="stylesheet" href="<%=commonImportPath %>/iseoulu/css/product.css" />
<script type="text/javascript" src="<%=commonImportPath %>/iseoulu/js/product/pdetail.js" ></script>
<title>I HAPPYBUSKING U</title>
</head>
<body>
	<%@include file="../header.jsp" %>
	<%@include file="../panel.jsp" %>
	<nav class="pdetail white_background">
		<div class="iwmc_item_slide_container pd_image_conatiner">
			<ul class="iwmc_item_slide" id="pdic_image">
				
			</ul>
			<p class="pdic_page_container"><span id="pdic_nowpage"></span>&nbsp;/&nbsp;<span id="pdic_totalpage"></span>
		</div>
		<div class="pd_content_container">
			<!-- <p class="pdcc_coupon_info pb_gra_point">20% 할인 쿠폰 발급</p> -->
			<p class="pdcc_cname" id="pdcc_company_name"></p>
			<p class="pdcc_pname pdcc_pname_text" id="pdcc_product_name"></p>
			<p class="pdcc_eng gray_point" id="pdcc_product_name_en"></p>
			<!-- <p class="pdcc_price">5,800원</p> -->
			<!-- <div class="pdcc_option_div pb_gra_point"><p class="pdcc_option_title">ㆍ옵션선택</p><span class="pdcc_pname_text pb_gra_point">상품 옵션</span></div> -->
			<div class="pdcc_info_line"></div>
			<p class="pdcc_info_title gray_point">ㆍ상품정보</p>
			<div class="pdcc_info_content" id="pdcc_product_info"></div>
			<div class="pdcc_info_line"></div>
			<p class="pdcc_info_title gray_point">ㆍ브랜드이야기</p>
			<div class="pdcc_info_content" id="pdcc_brand_info"></div>
			<div class="pdcc_info_line"></div>
			<p class="pdcc_info_title gray_point">ㆍ기업 소개</p>
			<div class="pdcc_info_content" id="pdcc_company_info"></div>
		</div>
	</nav>
	<%-- <%@include file="../footer.jsp" %> --%>
</body>