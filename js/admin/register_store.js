//상업공간등록 등록완료 클릭시
$(document).on('click', '#registration_btn', function(){
	if($("#business_worknameD").val() == ""){
        alert("아이디를 입력해주세요");
        $("#business_worknameD").focus();
        return false;
	  }
	  if($("#business_workname").val() == ""){
        alert("상호명을 입력해주세요");
        $("#business_workname").focus();
        return false;
	  }
	  if($("#business_representive").val() == ""){
        alert("대표자명을 입력해주세요");
        $("#business_representive").focus();
        return false;
	  }
	  if($("#business_no").val() == ""){
        alert("사업자 번호를 입력해주세요");
        $("#business_no").focus();
        return false;
	  }
	  if($("#address").val() == ""){
        alert("주소를 입력해주세요");
        return false;
	  }
	  if($("#address_detail").val() == ""){
        alert("상세주소를 입력해주세요");
        $("#address_detail").focus();
        return false;
	  }
	  if($("#business_phone").val() == ""){
        alert("연락처를 입력해주세요");
        $("#business_phone").focus();
        return false;
	  }
	  if($("#zone_info").val() == ""){
        alert("공간을 입력해주세요");
        $("#zone_info").focus();
        return false;
	  }
	  if($("#operationhour").val() == ""){
        alert("영업시간을 입력해주세요");
        $("#operationhour").focus();
        return false;
	  }
	  if($("#equipment").val() == ""){
        alert("음향장비를 입력해주세요");
        $("#equipment").focus();
        return false;
	  }
	  if($("#buskingzone_detailaddr").val() == ""){
        alert("장르를 입력해주세요");
        $("#buskingzone_detailaddr").focus();
        return false;
	  }
	  if(!$("tm_agree").val().prop('checked')){
        infoTxtBox("약관에 동의해주세요");
        return false;
	  }

});