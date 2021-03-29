$(document).ready(function(){
	$("#pf_btnDelVideo").hide();	
	
	$("#pf_btnVideo").click(function(){
		getVideo();
	});
	
	$("#pf_btnDelVideo").click(function(){
		$('#video_area').empty();
		$('#pf_btnVideo').show();
		$('#pf_btnDelVideo').hide();
		$('#video_area').append('<video src="" width="100%" height="250" preload="auto" style="border: 1px solid silver;" id="pfv"></video>')
	});
});

function getVideo(){
	navigator.camera.getPicture(onVideoURISuccess, onFailVideo,
			{quality: 50, destinationType: Camera.DestinationType.FILE_URI,
			sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
			mediaType: Camera.MediaType.VIDEO});
}

function onVideoURISuccess(videoURI){
	$('#pfv').attr('src', videoURI);
	$('#pf_btnDelVideo').show();
	$('#pf_btnVideo').hide();
	/*alert(videoURI);*/

}

function onFailVideo(message){
	infoTxtBox('실패 : ' + message);
}

