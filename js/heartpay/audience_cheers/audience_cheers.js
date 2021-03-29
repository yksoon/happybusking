function go_audience_cheers() {
	loadPage('audience_cheers/audience_cheers.jsp');
}

var changeImageId = 0;

$(document).on('pageinit', '#audience_cheers', function(){
	var height = $(window).height() - 45;
	$('#audience_cheers').css('padding-top', '44px');
	$('#audience_cheers').css('height', height+'px');
	$('.ch_img').css('height', height+'px');
	
	changeImageId = setInterval(playChangeImage, 1500);
	
	window.addEventListener("devicemotion",processEvent);
});

//클릭시 전체화면
$(document).on('click', '#audience_cheers', function(){
	var showchk = $('#header').css('display');
	var height = $(window).height();
	
	if(showchk == 'none'){
		$('#header').show();
		$('#audience_cheers').css('padding-top', '44px');
		$('#audience_cheers').css('height', height-45+'px');
		$('.ch_img').css('height', height-45+'px');
		$('.ui-slider').show();
	} else {
		$('#header').hide();
		$('#audience_cheers').css('padding-top', '0px');
		$('#audience_cheers').css('height', height+'px');
		$('.ch_img').css('height', height+'px');
		$('.ui-slider').hide();
	}
});

$(document).on('change', '#change_speed_bar', function(){
	var value = $(this).val();
	
	var speed = 1500;
	
	if(value == 1){
		speed = 2500;
	} else if(value == 2){
		speed = 2000;
	} else if(value == 3){
		speed = 1500;
	} else if(value == 4){
		speed = 1000;
	} else {
		speed = 500;
	}
	
	clearInterval(changeImageId);
	changeImageId = setInterval(playChangeImage, speed);
});

$(document).on('pagehide', '#audience_cheers', function(){
	clearInterval(changeImageId);
	window.removeEventListener("devicemotion",processEvent);
	flashAnimationOff();
	audioAnimationOff();
});

var device_shake_x = 0;	//디바이스 흔들기 속도
var device_shake_temp = 0;
var audio_play_status = 2;	// 1: 재생중, 2: 정지
var my_media = null;
var audio_stop_stack = 0;
var audio_volume = 0;

var flash_1 = null;

function processEvent (event) { 
	device_shake_x = Math.round(event.acceleration.x);
	
	//디바이스 흔들기 모션
	if(device_shake_x > 5 || device_shake_x < -5){
		device_shake_temp += 1;
		if(device_shake_temp > 20){
			if(my_media == null){
				audioAnimation();
				flashAnimation();
			}
		}
	} else {
		if(device_shake_temp > 0){
			device_shake_temp -= 1;
		} else {
			device_shake_temp = 0;
		}
	}
		
}

//이미지 깜빡이는 속도 조절
function playChangeImage(){
	var rand = Math.floor(Math.random() * 12) + 1;
	
	$('.ch_img').hide();
	
	setTimeout(function(){
		$('#ch_img_'+rand).show();
	}, 250);
}

//디바이스별 구분 오디오 경로
function getMediaURL(s) {
    if(device.platform.toLowerCase() === "android") return "/android_asset/www" + s;
    return s;
}

//플래시 제어
function flashAnimation() {
	var flash_chk= 0;
	if(flash_1 ==null){
		flash_1 = setInterval(function() {
			if(flash_chk % 2 == 1){
				window.plugins.flashlight.switchOn(
		  		      function() {}, // optional success callback
		  		      function() {}, // optional error callback
		  		      {intensity: 1.0} // optional as well //flash 밝기
			  	);
			}
			else{
				window.plugins.flashlight.switchOff();
			}
			flash_chk ++;
		}, 50);
	}
}

function flashAnimationOff() {
	window.plugins.flashlight.switchOff();
	clearInterval(flash_1);
	flash_1 = null;
}

//오디오 제어
function audioAnimation() {
	if(my_media == null){
		var url = '/sound/clap_sound.mp3';
		url = getMediaURL(url);
		my_media = new Media(url);
		my_media.play();
		
		setTimeout(function(){
			audioAnimationOff();
			flashAnimationOff();
		},4000);
	}
}

function audioAnimationOff() {
	if(my_media != null){
		my_media.stop();
		my_media = null;
	}
}