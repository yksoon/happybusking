//아티스트  페이지
var tno;
//뒤로가기시 아티스트정보에서 탭 구분을 위함.
var team_info_pageNo = 1;

$(document).on('pageshow', '#team_info', function(){
	//메트로 QR 찍고 들어온 경우
	var surveychk = sessionStorage.getItem('surveychk');
	if(surveychk != null && surveychk != ''){
		$('#metro_popup').load('/app/evalution_popup.jsp');
		$('#metro_popup').show();
	} else {
		//쿠키를 이용한 초기에 아티스트 정보 페이지에서 초기에 무조건 한번은 펼쳐지게끔 하기 위한 기능
		var sh_tinfo_chk = getCookie('tinfo_sh_chk');
		if(sh_tinfo_chk == null || sh_tinfo_chk == "null" || sh_tinfo_chk == ""){
			$('#Go_AiBtn').click();
			$('#icon_show_btn').trigger('click');
			setCookie('tinfo_sh_chk', 'off', 365); /* tinfo_sh_chk=off, 365일 뒤 만료됨 */
		}
		else{
			if(team_info_pageNo == 1){
				$('#Go_AiBtn').click();
			}
			else if(team_info_pageNo == 2){
				$('#Go_PfsBtn').click();
			}
			else if(team_info_pageNo == 3){
				$('#Go_ReviewBtn').click();
			}
			else if(team_info_pageNo == 4){
				$('#Go_MediaBtn').click();
			}
		}
	}
	
	
	$("#main_cont").hide();
	
	var prqs = sessionStorage.getItem('prqstate');
	
	if(prqs == 'Y'){
		$('.dp_footer_btn').show();
		$('#index_menu_list').hide();
	} else {
		$('.dp_footer_btn').hide();
		$('#index_menu_list').show();
	}
	
	
	//협업 QR 찍고 들어온 경우
	var cooperationOK = getCookie('cooperationOK');
	if(cooperationOK == 'Y'){
		qrEventChk(tno);
		setCookie('cooperationOK', 'N');
	}
}); 

$(document).on('pageinit', '#team_info', function() {
	$("#team_info_submenu" ).popup("close");
	$('.ui-popup.ui-body-inherit').css('border-style', 'none');

	var spt_no = sessionStorage.getItem('spt_no');
	if(spt_no != null){
		tno = spt_no;
	}

	//QR 찍었을때만 tno에 QR값 저장
	if($('#artistNo').val() !=''){
		tno = $('#artistNo').val();
	}
	
	tno = sessionStorage.getItem('TNO');
	
	user_no = $('#user_no').val();
	//infoTxtBox(tno);
	//AJAX 로딩 표시
	var url = "/service/team/team_info.jsp";
	reviewCount = 0;
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data: {
			team_no : tno,
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				return;
			}
			
			$("#team_member_part").empty();
			$("#main_cont").html();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CNT = $(this).find("CNT").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var TEAM_INTRO = changeLineBreak($(this).find("TEAM_INTRO").text());
				var TEAM_GENRE = $(this).find("TEAM_GENRE").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				var TINTRO_VIDEO = $(this).find("TINTRO_VIDEO").text();
				var TVIDEO_THUMBNAIL = $(this).find("TVIDEO_THUMBNAIL").text();
				var TINTRO_VIDEO_TITLE = $(this).find("TVIDEO_TITLE").text();
				var TINTRO_VIDEO_CONTENT = $(this).find("TVIDEO_CONTENT").text();
				var I_CHK = $(this).find("I_CHK").text();
				var BELONG = $(this).find('BELONG').text();
				var TM_COUNT = $(this).find('TM_COUNT').text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
						$("#ti_bandImg").css('background', 'url("' + value + '")');
						$("#ti_bandImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'cover'});
						$('#tip_picture_img').attr('src', value);
			     });
				
				if(TINTRO_VIDEO == null || TINTRO_VIDEO == ''){
					var v_img = '/img/common/no_video.svg';
					$('#ti_videoPart').attr('onclick', '');
				}
				else{
					var v_img_list = TINTRO_VIDEO.split('/');
					var v_img = v_img_list[v_img_list.length-1];
					v_img = 'https://img.youtube.com/vi/' + v_img + '/1.jpg';
					$('#ti_videoPart').attr('onclick', 'show_teamInfoVideo("' + TINTRO_VIDEO + '", "' + TINTRO_VIDEO_CONTENT + '");');
				}
				
				if(PF_DATE != ''){
					$('#ti_bandPerform').html(PF_DATE + ' 공연');
				}
				else{
					$('#ti_bandPerform').html('공연예정없음');
				}
				
				$('#ti_bandName').html(TEAM_NAME);
				$('#ti_bandInterestCount').html(CNT);
				$('#ti_bandIntro').html(TEAM_INTRO);
				$("#ti_videoImg").attr('src', v_img);
				$('#ti_videoContent').html(TINTRO_VIDEO_CONTENT);
				$('#ti_bandGenre').html(TEAM_GENRE);
				
				if(BELONG == ''){
					$('.tic_middle_text').hide();
				} else {
					$('#ti_belong').html(BELONG);
					$('tic_middle_text').show();
				}
				
				if(I_CHK != "0"){
					$('#team_interest_icon').attr('src', '/img/v2/ar_like__.svg');
					$('#team_interest_icon').attr('id', 'team_interesting_icon');
				}
				
				$(DATA2).each(function(i) {
					i = i + 1;
					var USER_NO = $(this).find("USER_NO").text();
					var TEAM_NO = $(this).find("TEAM_NO").text();
					var PART = $(this).find("PART").text();
					var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
					var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
					
					//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
					var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#aimg'+i).attr('src', value);
				     });
					
					var part_content = PART + ' | ' + TEAM_NAME
					
					
					var content = '';
					//홀수일 때 리스트 출력
					if(i%2 == 1){
						content = '<div class="ui-block-a ti_member_div" onclick="detailArtist(' + USER_NO + ',' + TEAM_NO + ')">' +
										 	'<div class="ui-grid-a">'+
												'<div class="ui-block-a" style="width: 37%;">'+
												'<img class="ti_member_img" id="aimg'+i+'">' +
												'</div>'+
												'<div class="ui-block-b" style="width: 60%; ">' +
													'<div class="ti_member_name">'+ ARTIST_NAME + '</div>' +
													'<div class="ti_member_part">'+ part_content + '</div>' +
												'</div>' +
											'</div>' +
										'</div>';
					//짝수일 때 리스트 출력
					}else if(i%2 == 0){
						content = '<div class="ui-block-b ti_member_div" onclick="detailArtist(' + USER_NO + ',' + TEAM_NO + ')">' +
										 	'<div class="ui-grid-a">'+
												'<div class="ui-block-a" style="width: 37%;">'+
													'<img class="ti_member_img" id="aimg'+i+'">' +
												'</div>'+
												'<div class="ui-block-b" style="width: 60%; ">' +
												'<div class="ti_member_name">'+ ARTIST_NAME + '</div>' +
													'<div class="ti_member_part">'+ part_content + '</div>' +
												'</div>' +
											'</div>' +
										'</div>';				
					}
					
					$("#team_member_part").append(content);
				});	
				
				if(TM_COUNT == '0'){
					$('#moremovie_btn').addClass('no_moremovie');
					$('#moremovie_btn').attr('onclick', '');
				} else {
					$('#moremovie_btn').removeClass('no_moremovie');
					$('#moremovie_btn').attr('onclick', 'goTeamInfoMediaBtn();');
				}
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
				var h = $('#ti_bandIntro').outerHeight();
				if(h > 114){
					$('#tinfo_showBtn').attr('onclick', 'tinfo_showAll(1)');
					$("#ti_bandIntro").css({'overflow': 'hidden', 'white-space': 'normal', 'height': '4em', 'word-wrap': 'break-word',
						'display': '-webkit-box', '-webkit-line-clamp': '3', '-webkit-box-orient': 'vertical'});						
				}else{
					$('#tinfo_showBtn').attr('onclick', 'tinfo_showAll(0)');
					$("#ti_bandIntro").css({'height': '4em'});	
					//$("#ti_bandIntro").css({'height': '6.3em'});	
				}
				
				sessionStorage.removeItem('spt_no');
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});
	
});

//아티스트  정보 페이지에서 소개 클릭 시
$(document).on("click","#Go_AiBtn",function(){
	getTeamReplyList();
	team_info_pageNo = 1;
	
	var header_html = '<div class="ui-block-a" id="Go_AiBtn">'+
							'<div class="haeder_menu_div_on">'+
								'<span>소개</span>'+
							'</div>'+
						'</div>'+
						'<div class="ui-block-b" id="Go_MediaBtn">'+
							'<div class="haeder_menu_div_base">'+
								'<span>사진/동영상</span>'+
							'</div>'+
						'</div>'+
						'<div class="ui-block-c" id="Go_PfsBtn">'+
							'<div class="haeder_menu_div_base">'+
								'<span>공연일정</span>'+
							'</div>'+
						'</div>'+
						'<div class="ui-block-d" id="Go_ReviewBtn">'+
							'<div class="haeder_menu_div_base">'+
								'<span>공연후기</span>'+
							'</div>'+
						'</div>';
	
	$('.header_menu_container').html(header_html);
	
	
	var artistInfoList = '<div id="ti_intro_title" class="ui-grid-a">'+
							'<div class="ui-block-a">'+
								'<p>소개</p>'+
							'</div>'+
							'<div class="ui-block-b">'+
								'<span id="tinfo_showBtn" onclick="tinfo_showAll();">전체보기</span>'+
							'</div>'+
						'</div>'+
						'<div id="ti_bandIntro">'+		
						'</div>'+
						'<div id="ti_member_title">멤버</div>'+
						'<div id="ti_member_content">'+
							'<div id="team_member_part" class="ui-grid-a">'+
							'</div>'+
						'</div>'+
						'<div id="ti_video_title">동영상</div>'+				
						'<div id="ti_videoPart" class="ui-grid-a">'+
							'<div class="ui-block-a" style="width: 40%;">'+
								'<img id="ti_videoImg" src="">'+
								'<div id="ti_videoImg_div">'+
								'</div>'+		
							'</div>'+
							'<div class="ui-block-b" style="width: 60%;">'+
								'<p id="ti_videoContent"></p>'+
							'</div>'+
						'</div>'+	
						'<div class="moreViewBtn" id="moremovie_btn">동영상 더보기</div>' +
						'</div>';	
	
	$('#team_middle').empty();
	
	$('#team_info_list').html(artistInfoList);
	
	$('.pd_reply_div').show();
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var data = "team_no=" + tno;
	var url = "/service/team/team_info.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data: data,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			var DATA2 = $(ROOT).find('DATA2');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				return;
			}
			
			$("#team_member_part").empty();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CNT = $(this).find("CNT").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var TEAM_INTRO = changeLineBreak($(this).find("TEAM_INTRO").text());
				var TEAM_GENRE = $(this).find("TEAM_GENRE").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				var TINTRO_VIDEO = $(this).find("TINTRO_VIDEO").text();
				var TVIDEO_THUMBNAIL = $(this).find("TVIDEO_THUMBNAIL").text();
				var TINTRO_VIDEO_TITLE = $(this).find("TVIDEO_TITLE").text();
				var TINTRO_VIDEO_CONTENT = changeLineBreak($(this).find("TVIDEO_CONTENT").text());
				var TM_COUNT = $(this).find('TM_COUNT').text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
						$("#ti_bandImg").css('background', 'url("' + value + '")');
						$("#ti_bandImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'cover'});
						$('#tip_picture_img').attr('src', value);
			     });
				
				
				if(TINTRO_VIDEO == null || TINTRO_VIDEO == ''){
					var v_img = '/img/common/no_video.svg';
					$('#ti_videoPart').attr('onclick', '');
				}
				else{
					var v_img_list = TINTRO_VIDEO.split('/');
					var v_img = v_img_list[v_img_list.length-1];
					v_img = 'https://img.youtube.com/vi/' + v_img + '/1.jpg';
					$('#ti_videoPart').attr('onclick', 'show_teamInfoVideo("' + TINTRO_VIDEO + '", "' + TINTRO_VIDEO_CONTENT + '");');
				}
				
				if(PF_DATE != ''){
					$('#ti_bandPerform').html(PF_DATE + ' 공연');
				}
				else{
					$('#ti_bandPerform').html('공연예정없음');
				}
				
				//아티스트 정보 전체보기 초기화
				$("#ti_bandIntro").css({'overflow': '', 'white-space': '', 'height': '', 'word-wrap': '',
					'display': '', '-webkit-line-clamp': '', '-webkit-box-orient': ''});
				
				$('#ti_bandName').html(TEAM_NAME);
				$('#ti_bandInterestCount').html(CNT);
				$('#ti_bandIntro').html(TEAM_INTRO);
				$("#ti_videoImg").attr('src', v_img);
				$('#ti_videoTitle').html(TINTRO_VIDEO_TITLE);
				$('#ti_videoContent').html(TINTRO_VIDEO_CONTENT);
				$('#ti_bandGenre').html(TEAM_GENRE);
				
				if(TM_COUNT == '0'){
					$('#moremovie_btn').addClass('no_moremovie');
					$('#moremovie_btn').attr('onclick', '');
				} else {
					$('#moremovie_btn').removeClass('no_moremovie');
					$('#moremovie_btn').attr('onclick', 'goTeamInfoMediaBtn();');
				}
				
				$(DATA2).each(function(i) {
					i = i + 1;
					var USER_NO = $(this).find("USER_NO").text();
					var TEAM_NO = $(this).find("TEAM_NO").text();
					var PART = $(this).find("PART").text();
					var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
					var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
					
					
					//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
					

					var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#aimg'+i).attr('src', value);
				     });
					
					var part_content = PART + ' | ' + TEAM_NAME

					var content = '';

					//홀수일 때 리스트 출력
					if(i%2 == 1){
						content = '<div class="ui-block-a ti_member_div" onclick="detailArtist(' + USER_NO + ',' + TEAM_NO + ')">' +
										 	'<div class="ui-grid-a">'+
												'<div class="ui-block-a" style="width: 37%;">'+
												'<img class="ti_member_img" id="aimg'+i+'">' +
												'</div>'+
												'<div class="ui-block-b" style="width: 60%; ">' +
													'<div class="ti_member_name">'+ ARTIST_NAME + '</div>' +
													'<div class="ti_member_part">'+ part_content + '</div>' +
												'</div>' +
											'</div>' +
										'</div>';
					//짝수일 때 리스트 출력
					}else if(i%2 == 0){
						content = '<div class="ui-block-b ti_member_div" onclick="detailArtist(' + USER_NO + ',' + TEAM_NO + ')">' +
										 	'<div class="ui-grid-a">'+
												'<div class="ui-block-a" style="width: 37%;">'+
													'<img class="ti_member_img"  id="aimg'+i+'">' +
												'</div>'+
												'<div class="ui-block-b" style="width: 60%;">' +
													'<div class="ti_member_name">'+ ARTIST_NAME + '</div>' +
													'<div class="ti_member_part">'+ part_content + '</div>' +
												'</div>' +
											'</div>' +
										'</div>';		
					}
					
					$("#team_member_part").append(content);
				
				});	
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
				var h = $('#ti_bandIntro').outerHeight();
				if(h > 114){
					$('#tinfo_showBtn').attr('onclick', 'tinfo_showAll(1)');
					$("#ti_bandIntro").css({'overflow': 'hidden', 'white-space': 'normal', 'height': '4em', 'word-wrap': 'break-word',
						'display': '-webkit-box', '-webkit-line-clamp': '3', '-webkit-box-orient': 'vertical'});						
				}else{
					$('#tinfo_showBtn').attr('onclick', 'tinfo_showAll(0)');
					$("#ti_bandIntro").css({'height': '4em'});	
				}		
				

			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		} // end error 
	});	
	$("#main_cont").hide();
});

$(document).on('pageinit', '#team_video_dialog', function(){
	var vSrc = sessionStorage.getItem('video_src');
	var vContent = sessionStorage.getItem('video_content');
	
	$('#dVideo_src').attr('src', vSrc);
	$('#dVideo_content').html(vContent);
});


//동영상 보기 페이지 이동
function show_teamInfoVideo(video_src, video_content){
	loadPage('team/team_video_dialog.jsp');
	sessionStorage.setItem('tvchk', 'yes');
	sessionStorage.setItem('video_src', video_src);
	sessionStorage.setItem('video_content', video_content);
}


//전체보기 버튼 클릭 시
function tinfo_showAll(CHK){
	if(CHK == "1"){
		$("#ti_bandIntro").css({'overflow': '', 'white-space': '', 'height': '', 'word-wrap': '',
			'display': '', '-webkit-line-clamp': '', '-webkit-box-orient': ''});
					
	}
	
}

//아티스트 팀 동영상쪽에서 닫기 버튼 클릭 시
$(document).on('click', '#team_video_dialog .ui-btn', function(){
	history.go(-1); 
});

//관심아티스트 -> 알람 설정하러 가기 버튼 누를 시
$(document).on('click', '#int_alarm_okBtn', function() {
	go_interest_team_list();
});


//팀 상세 페이지로 이동
function go_team_infoPage(team_no) {
	tno = team_no;
	sessionStorage.setItem('TNO', team_no);
	loadPage('team/team_info.jsp');
}


//서브메뉴 보기 // 오른쪽 하단 + 이미지 클릭 시
//아래서 위로 올라가는 애니메이션 
$(document).on('click', '#icon_show_btn', function() {

	$("#team_info_submenu").popup( "option" , "dismissible" , false);
	$( "#team_info_submenu" ).popup( "option", "overlayTheme", "b" );
	$("#team_info_submenu" ).popup( "option", "positionTo", "window" );
	$("#team_info_submenu" ).popup("open");
	
	$('.ui-popup.ui-body-inherit').css('border-style', 'none');
	
	
	var csb = document.getElementById("camera_show_btn");
	var ssb = document.getElementById("support_show_btn");
	var prb = document.getElementById("perfrom_req_btn");
	var acb = document.getElementById("ad_cheers_btn");
	
	var pos1 = 3;
	var pos2 = 3;
	var pos3 = 3;
	var pos4 = 3;
	
	var id1= setInterval(frame1, 5);
	var id2= setInterval(frame2, 5);
	var id3= setInterval(frame3, 5);
	var id4= setInterval(frame4, 5);
	
	function frame1() {
		if(pos1 == 23){
			clearInterval(id1);
		}
		else{
			pos1++;
			prb.style.bottom = pos1 + '%';
		}
	}
	function frame2() {
		if(pos2 == 31){
			clearInterval(id2);
		}
		else{
			pos2++;
			ssb.style.bottom = pos2 + '%';
		}
	}
	function frame3() {
		if(pos3 == 39){
			clearInterval(id3);
		}
		else{
			pos3++;
			csb.style.bottom = pos3 + '%';
		}
	}
	function frame4() {
		if(pos4 == 47){
			clearInterval(id4);
		}
		else{
			pos4++;
			acb.style.bottom = pos4 + '%';
		}
	}
});

$(document).on('click', '#icon_hide_btn', function() {
	$("#team_info_submenu" ).popup("close");
});

$(document).on('click', '#wep_close_btn', function(){
	var conf = confirm('해당 팝업을 닫으시면 당첨이 취소됩니다.\n정말 닫으시겠습니까?');
	if(!conf){
		return;
	}
	$('#event_winning_popup').hide();
});

$(document).on('click', '#ewp_close_btn', function(){
	$('#event_whack_popup').hide();
});

$(document).on('click', '#wep_btn', function(){
	var phone = $('#wepc_phone').val();
	var ip = $('#wepc_ip').val();
	
	if(phone == ''){
		alert('휴대폰 번호를 정확히 입력해주세요.');
		$('#wepc_phone').focus();
		return;
	}
	if(!$('#e_info_checkbox').prop('checked')){
		alert('개인정보 처리 및 취급방침에 동의해주세요.');
		return;
	}
	
	var conf = confirm('한번 등록하면 수정이 불가능합니다.\n휴대폰 번호를 정확이 입력하셨습니까?');
	if(!conf){
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/event/set_phone.jsp',
		data: {
			phone : phone,
			ip: ip,
			tno: tno
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			alert('기프티콘은 당첨일을 기준으로 7일 이내에 등록해주신 휴대폰 번호로 문자 발송해 드릴 예정입니다.\n해당 이벤트에 참여해주셔서 감사합니다.');
			$('#event_winning_popup').hide();
		} 
	});
}); 

//공연 상세 페이지 이미지 클릭시 팝업으로 크게 보여주기 
$(document).on('click', '#tiv_btn', function(){
	//documentScroll = '0px';
	
	//var popupPosition = $(this).attr('id');
	var src = $('#ti_bandImg').css('background-image').split('\"')[1].split('\"')[0];
	$('#team_img_popup').append('<img id="tip_picture_img"/>');
	$('#tip_picture_img').attr('src', src);
	$("#team_img_popup").show();
	//$('#team_img_popup').css('top', documentScroll);
	
	var el = document.querySelector('#tip_picture_img');
	new PinchZoom.default(el, {
		
	});
});


$(document).on('click', '#team_img_popup', function(){
	$('.pinch-zoom-container').remove();
	$("#team_img_popup").hide();
	//var imgSrc = $('#ti_bandImg').css('background-image').split('/');
	//imgSrc = '/upload/team/'+imgSrc[5]+'/'+imgSrc[6];
	//imgSrc = imgSrc.replace(/\"/gi, '');
	//imgSrc = imgSrc.replace(')', '');
	//$("#team_img_popup").html('<img id="tip_picture_img" src="'+imgSrc+'"></img>');
});


//FOOTER CSS
/*$(document).on('pageshow', '#team_info', function() {
	$('.footer_ar_txt').css('color', '#8d5cb1');
	$('.footer_ar_txt').css('font-weight', 'bold');
	$('.footer_ar_img').attr('src', '/img/test/m_artist2.svg');
});

$(document).on('pagehide', '#team_info', function() {
	$('.footer_ar_txt').css('color', '#0c0c0c');
	$('.footer_ar_img').attr('src', '/img/test/m_artist.svg');
});*/