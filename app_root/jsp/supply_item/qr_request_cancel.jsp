<%@page import="db.dbconn"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/importhaed.jsp" %>

<div data-role="page" id="qrcode_request_cancel_page">
	<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id ="qrcode_request_cancel_sec" data-role="content">
			<form name="frmConfirm"> 
			<input type="hidden" name="PAYMETHOD" id="PAYMETHOD">
			<input type="hidden" name="CPID" id="CPID" value=""><br>
			<input type="hidden" name="DAOUTRX" id="DAOUTRX" value=""><br>
			<div class="common_form_main_title">
				취소 금액
			</div>
			<input type="text" name="AMOUNT" id="AMOUNT"  value="" readonly="readonly"><br>
			<input type="hidden" name="CANCELIP" id="CANCELIP" value="116.126.142.192"><br>
			<div class="common_form_main_title">
				취소 사유 (선택사항)
			</div>
			<input type="text" name="CANCELMEMO" id="CANCELMEMO" value="" placeholder="간단한 취소 사유를 입력해주세요."><br>
			<input name="btnSubmit" id="btnSubmit" type="button" value="취소하기" onclick="fnSubmit()" style="display: none;" data-role="none"><br>
			</form>
		</div>
	<%@include file="/app_root/jsp/footer/footer.jsp" %>
	
	<script type="text/javascript">
	var pf;
	
	function fnSubmit() {
		var fileName;
		var PAYMETHOD = $('#PAYMETHOD').val();
		
		if(PAYMETHOD == 'CARD'){
			fileName = "/service/kiwoompay/kiwoompay_cancel_card.jsp";		
		} else if(PAYMETHOD == 'TMONEY'){
			fileName = "/service/kiwoompay/kiwoompay_cancel_tmoney.jsp";
		} else if(PAYMETHOD == 'BANK'){
			fileName = "/service/kiwoompay/kiwoompay_cancel_bank.jsp";
		} else if(PAYMETHOD == 'MOBILE'){
			fileName = "/service/kiwoompay/kiwoompay_cancel_mobile.jsp";
		} else if(PAYMETHOD == 'HAPPYMONEY' || PAYMETHOD == 'BOOK' || PAYMETHOD == 'CULTURE'){
			fileName = "/service/kiwoompay/kiwoompay_cancel_giftcard.jsp";
		} else {
			alert('취소할 수 없는 결제방식입니다.\n070-7090-7058로 전화주시면 빠른 처리 도와드리겠습니다.');
			return;
		}
		
		pf = document.frmConfirm;
	
		pf.action = fileName;
		pf.method = "post";
		pf.submit();
		
		//화면의 높이와 너비를 구한다.
        var maskHeight = $(document).height(); 
//      var maskWidth = $(document).width();
        var maskWidth = window.document.body.clientWidth;
         
        var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
        var loadingImg = '';
         
        loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>";
        loadingImg += " <img src='/img/common/loading.gif'/>";
        loadingImg += "</div>";  
     
        //화면에 레이어 추가
        $('body')
            .append(mask)
            .append(loadingImg)
           
        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({
                'width' : maskWidth
                , 'height': maskHeight
                , 'opacity' : '0.3'
        }); 
     
        //마스크 표시
        $('#mask').show();   
     
        //로딩중 이미지 표시
        $('#loadingImg').show();
	}
	
	</script>
</div>