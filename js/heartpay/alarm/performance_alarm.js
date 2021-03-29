var pf_no_temp;
var team_no_temp;
var alarm_val = true;

$(document).on("pagecreate","#performance_alarm",function() {	
	$('#Go_TimeAlarm').trigger('click');
});

//시간설정 탭
$(document).on('click', '#Go_TimeAlarm', function() {
	$('#p_alarm_header').empty();
	var p_alarm_header = '<div class="ui-grid-a header_menu_container">'+
							'<div id="Go_TimeAlarm" class="ui-block-a">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">시간설정</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_DistanceAlarm" class="ui-block-b">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">거리설정</span>'+
								'</div>'+
							'</div>'+	  				  		
						'</div>';
	
	
	$('#p_alarm_header').append(p_alarm_header);
	
	$('#p_alarm_content').empty();
	var p_alarm_content='<div  style="width: 100%; border-top: 1px solid #eae8ea; border-bottom: 1px solid #eae8ea;">'+
	'<div class="ui-grid-a" style=" background-color: #fff; padding:15px; margin-top: 15px; padding-top:18px; padding-bottom:18px;">'+
	'<div class="ui-block-a" style="width: 81%; text-align: left;">'+
		'<div class="ui-grid-a">'+
			'<div class="ui-block-a" style="width: 100%;">'+
				'<div class="ui-grid-a">'+
					'<div class="ui-block-a" style="font-size: 15px; width: 11%; padding-top: 5px;">오후</div>'+
					'<div class="ui-block-b" style="font-size: 30px; font-weight: bold; letter-spacing: -2px; width: 85%;">05:20</div>'+
				'</div>'+
			'</div>'+
			'<div class="ui-block-b" style="width: 100%;">'+
				'<div class="ui-grid-a">'+
					'<div class="ui-block-a" style="width: 35%; font-size: 14px; color: #a7a7a7;">2018.07.12(금)</div>'+
					'<div class="ui-block-b" style="width: 60%; font-size: 14px; color: #737373; font-weight: bold;">정흠밴드</div>'+
				'</div>'+
			'</div>'+
		'</div>'+
	'</div>'+
	'<div class="ui-block-b" style="width: 19%; margin-top:13px;">'+
		'<div id="flipswitch"></div>' +
	'</div>'+
	'</div>'+
	'</div>';
	
	var html = p_alarm_content;

	$('#p_alarm_content').append(html);
	
	$('#flipswitch').flipswitch({
		width: 65,
		values : {
			left : "OFF",
			right : "ON"
		}
	});
	
});

//거리설정 탭
$(document).on('click', '#Go_DistanceAlarm', function() {
	$('#p_alarm_header').empty();
	var p_alarm_header = '<div class="ui-grid-a header_menu_container">'+
							'<div id="Go_TimeAlarm" class="ui-block-a">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">시간설정</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_DistanceAlarm" class="ui-block-b">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">거리설정</span>'+
								'</div>'+
							'</div>'+	  				  		
						'</div>';
	
	var url = '/service/alarm/performance_alarm.jsp';
	var data = 'user_no=' + $("input[class='user_no'").val();
	
	$('#p_alarm_content').empty();
	
	var p_alarm_content='<div  style="width: 100%; border-top: 1px solid #eae8ea; border-bottom: 1px solid #eae8ea;">'+
	'<div class="ui-grid-a" style=" background-color: #fff; padding:15px; margin-top: 15px; padding-top:18px; padding-bottom:18px;">'+
	'<div class="ui-block-a" style="width: 81%; text-align: left;">'+
		'<div class="ui-grid-a">'+
			'<div class="ui-block-a" style="width: 100%;">'+
				'<div class="ui-grid-a">'+
					'<div class="ui-block-a" style="font-size: 15px; width: 11%; padding-top: 5px;">반경</div>'+
					'<div class="ui-block-b" style="font-size: 30px; font-weight: bold; letter-spacing: -2px; width: 85%;">1Km</div>'+
				'</div>'+
			'</div>'+
			'<div class="ui-block-b" style="width: 100%;">'+
				'<div class="ui-grid-a">'+
					'<div class="ui-block-a" style="width: 35%; font-size: 14px; color: #a7a7a7;">2018.07.12(금)</div>'+
					'<div class="ui-block-b" style="width: 60%; font-size: 14px; color: #737373; font-weight: bold;">정흠밴드</div>'+
				'</div>'+
			'</div>'+
		'</div>'+
	'</div>'+
	'<div class="ui-block-b" style="width: 19%; margin-top:13px;">'+
		'<div id="flipswitch"></div>' +
	'</div>'+
	'</div>'+
	'</div>';
	
	var html = p_alarm_content;

	$('#p_alarm_content').append(html);

	
	var init;
	
	$('#flipswitch').flipswitch({
		width: 65,
		values : {
			left : "OFF",
			right : "ON"
		}
	});	
});

$(document).on("click", "#flipswitch", function() {
	var init = $("#flipswitch").flipswitch("option", "init");
	if(init == "left"){
		$("#flipswitch").flipswitch("option", "init", "right");
	}
	if(init == "right"){
		$("#flipswitch").flipswitch("option", "init", "left");
	}
	alert(init);
});



//초기페이지
function Go_perform_alarm(pf_no, team_no){
	loadPage('alarm/performance_alarm.jsp');
	pf_no_temp = pf_no;
	team_no_temp = team_no;
}

function vibrate(){
	navigator.vibrate(2000);
}

$(document).on('pagebeforeshow', '#perform_alarm', function() {
	document.getElementById("add_alarm").addEventListener("click", vibrate);
});



$(document).on('click', '#add_alarm', function() {
	wrapWindowByMask();
	vibrate();
});

$(document).on('click', '#close_alarm', function() {
	$('#popup_mask').hide();
});