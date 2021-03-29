function go_videoUpload() {
	var login_chk = userLogin_chk();
	
	if(login_chk == true){
		var resultState = WificheckNetwork();
		
		if(resultState == false){
			var conf = confirm('WIFI 연결 상태가 아닙니다.\그래도 동영상 업로드를 진행하시겠습니까?');
			
			if(!conf) return;
			else loadPage('user/video_upload.jsp');
		}
		else{
			loadPage('user/video_upload.jsp');
		}	
	}else{
		infoTxtBox("로그인하고 이용해주세요");
		loadPage('login/login.jsp');
	}	

}

//wifi 상태 체크
function WificheckNetwork() {
    var networkState = navigator.network.connection.type;
    
    var stateResult = true;
    if(navigator.network.connection.type != Connection.WIFI){
    	
    	stateResult = false;
    	
    }
    
    return stateResult;
}


$(document).on('pageinit', '#video_upload', function() {
	$('#vu_content').textinput("option", "autogrow", false);
	
	$('#url').hide();

	var height = window.innerHeight - 35;
	$('#video_upload_terms').css('height', height+'px');
});




//업로드 할 파일 클릭 시
$(document).on('click', '#upload_img_default, #upload_videoPlay', function() {
	$('#video_uploadFile').click();
});

$(document).on('click', '#video_uploadFile', function(){
	alert('[주의]\n"WiFi 를 이용한 업로드가 아닌경우 요금이 부과될수 있습니다."');
});


$(document).on('change', '#video_uploadFile', function() {
	/*var ext = $(this).val().split('.').pop().toLowerCase(); //확장자
	if($.inArray(ext, ['mp4', 'webm', 'ogg', 'mov']) == -1) {
		$('#video_uploadFile').val(""); //파일 초기화
		//$('#menuImg').attr('src', "");//이미지 경로 초기화
		$('#video_upload_part').html('<div id="upload_img_default" class="upload_img"></div>');
		
		infoTxtBox('동영상 파일이 아닙니다! (mp4, webm, ogg, mov로 끝나는 확장자만 업로드 가능)');
	}else{
		
	  $('#video_upload_part').html('<video id="upload_videoPlay" width="100%" height="180" muted autoplay></video>');	
	  
	  var videoPreview = document.getElementById('upload_videoPlay');
	  var selectVideo = document.getElementById('video_uploadFile').files[0];
	  var selectVideoSize = document.getElementById('video_uploadFile').files[0].size;
	  
	  var maxVideoSize = 837812224;
	  
	  if(selectVideoSize > maxVideoSize){
		  infoTxtBox('동영상 파일의 사이즈는 800M를 초과할 수 없습니다.');
		  $('#video_uploadFile').val("");
		  $('#video_upload_part').html('<div id="upload_img_default" class="upload_img"></div>');
		  return;
	  }
	  
	  videoPreview.setAttribute('src', URL.createObjectURL(selectVideo));
	  
	  setTimeout(function() {videoPreview.pause();}, 2000);
	}*/
	  
	const tno = sessionStorage.getItem('TNO');
	
	const path = 'video/team/team'+tno;
	
	uploadFile('video_uploadFile', 'url', path, function(fname){
	});
});

$(document).on('click', '#video_upload_btn', function() {
	var no = createRandomNum();
	var tno = sessionStorage.getItem('TNO');
	var url = changeQuotes($('#url').val());
	var title = changeQuotes($('#vu_place').val());
	var content = changeQuotes($('#vu_content').val());
	
	
	if(url == ''){
		alert('동영상 파일을 선택해주세요.');
		return;
	} else if(title == ''){
		alert('공연 장소를 입력해주세요.');
		$('#vu_place').focus();
		return;
	} else if(content == ''){
		alert('내용을 입력해주세요.');
		$('#v_content').focus();
		return;
	} else if(!$('#videoUpload_checkbox').prop('checked')){
		alert('동영상 업로드 약관에 동의해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/user/video_ftp_upload.jsp',
		data: {
			no: no,
			tno: tno,
			url: url,
			title: title,
			content: content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			alert('업로드가 완료되었습니다.');
			history.go(-1);
		}
	});
});

$(document).on('click', '#vu_btn', function() {
	clearInterval(percent_move);
	toHome();
});

$(document).on('click', '#myCancle', function() {
	confirmBox("동영상 업로드를 취소하시겠습니까?", moveStop);
	
});

var percent_move;	//게이지 증가 Interval
var percent_ing;	//게이지 퍼센트
var status_cnt;		//진행중 ... 을 위한 카운트

//퍼센트 게이지 증가
var move = function() {
	$("#video_upload_ing").popup( "option" , "dismissible" , false);
	$("#video_upload_ing" ).popup( "option", "overlayTheme", "b" );
	$("#video_upload_ing" ).popup( "option", "positionTo", "window" );
	
	$("#video_upload_ing" ).popup("open");
	
	  var elem = document.getElementById("myBar");   
	  percent_ing = 1;
	  status_cnt = 1;
	  percent_move = setInterval(frame, 10);
	  function frame() {
	    if (percent_ing >= 100) {
    		$('#vu_status').html('업로드 완료!!!');
    		$('#myPercent').html('100%');
    		elem.style.width = '100%'; 
    		$('#myCancle').hide();
    		$('#vu_btn').show();
	    	clearInterval(percent_move);
	    } else { 
	      elem.style.width = percent_ing + '%'; 
	      $('#myPercent').html(percent_ing+'%');
	      
	      //진행중 ... 표시
	      if(status_cnt == 100){
	    	  $('#vu_status').html('업로드 진행중.');
	      }
	      else if(status_cnt == 200){
	    	  $('#vu_status').html('업로드 진행중..');
	      }
	      else if(status_cnt == 300){
	    	  $('#vu_status').html('업로드 진행중...');
	    	  status_cnt = 1;
	      }
	      status_cnt++;
	    }
	  }
}

//업로드 중지
var moveStop = function() {
	var elem = document.getElementById("myBar");   
	var width = 1;
	elem.style.width = width + '%'; 
	$('#myPercent').html(width+'%');
	
	$("#video_upload_ing" ).popup("close");
	clearInterval(percent_move);
	
	vu_xhr.abort();
}

//업로드 진행 팝업창 띄우기
var upload_ing = function() {
	$("#video_upload_ing").popup( "option" , "dismissible" , false);
	$("#video_upload_ing" ).popup( "option", "overlayTheme", "b" );
	$("#video_upload_ing" ).popup( "option", "positionTo", "window" );
	
	$("#video_upload_ing" ).popup("open");
};

//업로드 완료 팝업창 띄우기
var upload_comp = function() {
	$("#video_upload_comp").popup( "option" , "dismissible" , false);
	$("#video_upload_comp").popup( "option", "overlayTheme", "b" );
	$("#video_upload_comp").popup( "option", "positionTo", "window" );
	$("#video_upload_comp").popup("open");
};

var video_fileUrl;

//갤러리(동영상)
var uploadPhoto = function(){
    var options = {
        quality          : 75,
        destinationType  : Camera.DestinationType.FILE_URI,
        sourceType       : Camera.PictureSourceType.SAVEDPHOTOALBUM,
        allowEdit        : true,
        targetWidth      : 300,
        targetHeight     : 300,
        popoverOptions   : CameraPopoverOptions,
        saveToPhotoAlbum : false,
        mediaType		 : 1
    };
    navigator.camera.getPicture(function(imageURI) {
    	video_fileUrl = imageURI;
    	
    }, function(err) {
 
    }, options);
};


//동영상 업로드 약관 관련
$(document).on('click', '#videoUpload_checkbox_btn', function() {
	$('#videoUpload_checkbox').trigger('click');
});

$(document).on('click', '#videoUpload_checkboxView', function() {
	$("#video_upload_terms").popup( "option" , "dismissible" , false);
	$("#video_upload_terms" ).popup( "option", "overlayTheme", "b" );
	$("#video_upload_terms" ).popup( "option", "positionTo", "window" );
	$('#video_upload_terms').popup('open');
});

$(document).on('click', '#video_upload_terms_close', function() {
	$('#video_upload_terms').popup('close');
});