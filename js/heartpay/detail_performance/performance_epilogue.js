$(document).ready(function(){
	$('#epilogue_inputArea').hide();
	$('#epilogue_delBtn').hide();
	
	//관람 체크 부분 (검증 코드 들어가야됨)
	$('#chk_epilogue').click(function(){
		infoTxtBox('체크 성공');
		$('#chk_epilogue_box').attr('checked', 'checked');
		$('#epilogue_inputArea').slideDown();
	});
	
	//공연 후기 사진 추가 부분
	$('#epilogue_registerBtn').click(function(){
		getEpiloguePhoto();
	});
	
	$("#epilogue_delBtn").click(function(){
		$('#epilogueImg_area').empty();
		$('#epilogue_delBtn').hide();
		$('#epilogue_registerBtn').show();
		$('#epilogueImg_area').append($('<img id="epilogueImg" src="">'));
	});
});

function getEpiloguePhoto(){
	navigator.camera.getPicture(onPhotoURISuccess, onFail,
			{quality: 50, destinationType: Camera.DestinationType.FILE_URI,
			sourceType: Camera.PictureSourceType.PHOTOLIBRARY});
}

function onPhotoURISuccess(imageURI){
	$('#epilogueImg').attr('src', imageURI);
	$('#epilogue_delBtn').show();
	$('#epilogue_registerBtn').hide();

}

function onFail(message){
	infoTxtBox('실패 : ' + message);
}
