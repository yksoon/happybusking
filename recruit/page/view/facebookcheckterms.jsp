<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/recruit/importhead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/recruit/resource/css/join.css?ver=1.0.1" />
<script type="text/javascript" src="/recruit/resource/js/function/join-func.js?ver=1.0.1" ></script>

</head>
<body  onload="onLoad();">
	<%@include file="/recruit/page/web/w-header.jsp" %>
	<nav class="wrapper">
		<nav class="body">
		<%@include file="/recruit/page/common/header.jsp" %>
		<%@include file="/recruit/page/common/popup.jsp" %>
		<nav class="h-pt join-warpper" style="margin-top: 50px;">
			<div class="terms-container">
				<div class="flex terms-colum">
					<input type="checkbox" id="allchk" data-role="none"/><label class="ft-bold" data-role="none" for="allchk">아래 약관에 모두 동의합니다.</label>
				</div>
				<div class="flex terms-colum">
					<input type="checkbox" id="stchk" name="terms" data-role="none"/><label data-role="none" for="stchk">이용약관 동의(필수)</label>
					<p class="ft-14 under-line ft-gray" onclick="goServiceTerms();">보기</p>
				</div>
				<div class="flex terms-colum">
					<input type="checkbox" id="itchk" name="terms" data-role="none"/><label data-role="none" for="itchk">개인정보 처리 및 취급방침 동의(필수)</label>
					<p class="ft-14 under-line ft-gray" onclick="goPersonalInfoTerms();">보기</p>
				</div>
				<div class="flex terms-colum">
					<input type="checkbox" id="ltchk" name="terms" data-role="none"/><label data-role="none" for="ltchk">위치기반 서비스 이용약관 동의(필수)</label>
					<p class="ft-14 under-line ft-gray" onclick="goLocationTerms();">보기</p>
				</div>
			</div>
			
			<div class="bg-purple ft-white ft-16 ft-bold btn" id="join" onclick="handlerFacebookJoin();">등록 완료</div>
		</nav>
		<%@include file="/recruit/page/common/footer.jsp" %>
		</nav>
		<%@include file="/recruit/page/web/explanation.jsp" %>
	</nav>
	
	<script type="text/javascript">
		function handlerFacebookJoin () {
			var terms = true;
			
			$('input:checkbox[name=terms]').each(function(){
				if($(this).is(':checked') === false){
					terms = false;
				}
			});
			
			if(!terms){
				alert('필수 약관에 모두 동의해주세요.');
				return;
			}
			
			$.ajax({
				type: "POST",
				url: '/service/join/join.jsp',
				data:{
					user_active: 'Y',
					artist_check: 'N',
					busking_oath: 'N',
					user_id: sessionStorage.getItem("fEmail"),
					nickname: sessionStorage.getItem("fName"),
					login_chk: 'F'
				},
				success: function (data) {
					alert('회원가입이 완료되었습니다.');
					goMyPbi();
				},
				error: function(a, b, c) {
					alert('다시 시도해주세요');
					return;
				}
			});
		}
	</script>
</body>
</html>