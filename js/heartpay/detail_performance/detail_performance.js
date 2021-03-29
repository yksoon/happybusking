var menu_content = '';
var content = '';
var count;	//별점 카운트
$(document).on('pageshow', '#detail_perform', function() {
	var prqs = sessionStorage.getItem('prqstate');
	
	if(prqs == 'Y'){
		$('.dp_footer_btn').show();
		$('#index_menu_list').hide();
	} else {
		$('.dp_footer_btn').hide();
		$('#index_menu_list').show();
	}
	
	$('#Go_PerInfoBtn').trigger('click');
	$("#main_cont").hide();
	
	var el = document.querySelector('#dfivp_image');
	new PinchZoom.default(el, {
		
	});
});


//공연 정보 -> 상세정보 버튼
$(document).on('click', '#Go_PerInfoBtn', function() {
	var user_no = $('#user_no').val();
	$('.pd_reply_div').show();
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: "/service/detail_performance/detail_performance.jsp",
		data: {
			pf_no : pf_no_temp,
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		
		success: function (data) {			
			$('#detail_perform_menu').empty();
			
			var menu_content = '<div class="ui-grid-b header_menu_container">'+
									'<div id="Go_PerInfoBtn" class="ui-block-a">'+
										'<div class="haeder_menu_div_on">'+
											'<span class="header_menu_text_on">상세정보</span>'+
										'</div>'+
									'</div>'+
									'<div id="Go_AddrInfoBtn" class="ui-block-b">'+
										'<div class="haeder_menu_div_base">'+
											'<span class="header_menu_text_base">교통안내</span>'+
										'</div>'+
									'</div>'+
									'<div id="Go_PerReviewBtn" class="ui-block-c">'+
										'<div class="haeder_menu_div_base">'+
											'<span class="header_menu_text_base">공연후기</span>'+
										'</div>'+
									'</div>'+	
								'</div>';
				
			$('#detail_perform_menu').append(menu_content);
				
			var ROOT = $(data).find("ROOT2");
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				infoTxtBox(pf_no_temp);
			}
			//$('#detail_perform_tab').empty();
			
			$(DATA).each(function(i) {
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var PF_INTRO = $(this).find("PF_INTRO").text();
				var PF_IMG = $(this).find("PF_IMG").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var PF_TIME = $(this).find("PF_TIME").text();
				var CODE_AREA = $(this).find("CODE_AREA").text();
				var PF_DETAIL_CONTENT = $(this).find("PF_DETAIL_CONTENT").text();	
				PF_DETAIL_CONTENT = changeLineBreak(PF_DETAIL_CONTENT);
				var PF_LATLNG = $(this).find("PF_LATLNG").text();
				var PF_ADDR = $(this).find("PF_ADDR").text();
				var PF_PLACE = $(this).find("PF_PLACE").text();
				var WEEK = $(this).find("WEEK").text();
				var I_CHK = $(this).find("I_CHK").text();
				var PF_CANCLE = $(this).find('PF_CANCLE').text();
				var PF_CANCLE_MSG = $(this).find('PF_CANCLE_MSG').text();
				
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				var p_img = '/upload/team/team'+ TEAM_NO + '/' + PF_IMG;
				
				var new_img2 = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
                
			     var imgSrc = getImagePromise(new_img2).then(value => {
					$("#pfimg").attr('src', value);
			     });
				
				var CODE_AREA = '&#60;'+ CODE_AREA + '&#62;';
				var PF_DATE_WEEK_TIME = PF_DATE + '&#40;' + WEEK + '&#41;' + '&nbsp;' + PF_TIME;
				
				team_no_temp = TEAM_NO;
				tno = team_no_temp;
				
				var CNT = $(this).find("CNT").text();
				var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				var TEAM_GENRE = $(this).find("TEAM_GENRE").text();
				var PF_DATE_CHK = $(this).find("PF_DATE_CHK").text();
				
				var BELONG = $(this).find('BELONG').text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$("#ti_bandImg").css('background', 'url("' + value + '")');
					$("#ti_bandImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'cover'});
			     });
				
				tno = TEAM_NO;
				
				$('#ti_bandName').html(TEAM_NAME + '<img class="pf-more" src="/img/v2/more.png"/>' );
				$('#ti_bandInterestCount').html(CNT);
				$('#ti_bandIntro').html(TEAM_INTRO);
				$('#ti_bandGenre').html(TEAM_GENRE);
				$('#ti_bandName').attr('onclick', 'go_team_infoPage('+TEAM_NO+')');
				$('#ti_bandGenre').attr('onclick', 'go_team_infoPage('+TEAM_NO+')');
				$('#ti_bandPerform').attr('onclick', 'go_team_infoPage('+TEAM_NO+')');
				
				$(".detail_perform_artist").html(TEAM_NAME);
				
				if(BELONG == ''){
					$('.tic_middle_text').hide();
				} else {
					$('#ti_belong').html(BELONG);
					$('tic_middle_text').show();
				}
				
				if(I_CHK != "0"){
					$('#df_team_interest_icon').attr('src', '/img/v2/ar_like__.svg');
					$('#df_team_interest_icon').attr('id', 'df_team_interesting_icon');
				}
				
				if(PF_DATE_CHK == '' || PF_DATE_CHK =='null' || PF_DATE_CHK == 'NULL'){
					$('#ti_bandPerform').html('공연예정없음');
				}
				else{
					$('#ti_bandPerform').html(PF_DATE_CHK+'공연');
				}
				
				$('#detail_perform_middle').empty();
				
				var middle_content = '<div class="ui-grid-a dp_middle_container">' + 
										'<div class="ui-block-a dp_mc_left">' + 
											'<p>공연소개</p>' + 
										'</div>' +
										'<div class="ui-block-b dp_mc_right">' +
											'<span id="tinfo_showBtn">전체보기</span>' +
										'</div>' +
									'</div>';
				
				var html = middle_content;
				
				$('#detail_perform_middle').append(html);
				
				$('#detail_perform_tab').empty();
				
				var content = '<div id="detail_perform_content">'+ PF_DETAIL_CONTENT + '</div>' +
								'<div class="ui-grid-a dfc_header_container">' +
									'<div class="ui-block-a dfc_hc_left">' +
										'<p>기본정보</p>' +
									'</div>' +
									'<div class="ui-block-b dfc_hc_right" id="perform_alarm_btn">' +
									'</div>' +
								'</div>' +
								'<div class="ui-grid-a dfc_info_container" id="detail_perform_intro">' +
									'<div class="ui-block-a dfc_ic_image">' +
										'<img id="pfimg">' +
									'</div>' +
									'<div class="ui-block-b dfc_ic_content_container">' +
											'<p id="detail_perform_title">'+
												PF_INTRO +
											'</p>'+
											'<div class="ui-grid-a dfc_ic_cc_text_container">'+
												'<div class="ui-block-a dfc_ic_cc_tc_title">장소</div>'+
												'<div class="ui-block-b dfc_ic_cc_tc_content">' + PF_PLACE +'</div>'+
												'<div class="ui-block-a dfc_ic_cc_tc_title">시간</div>'+
												'<div class="ui-block-b dfc_ic_cc_tc_content">' + PF_DATE_WEEK_TIME +'</div>'+
												'<div class="ui-block-a dfc_ic_cc_tc_title">출연</div>'+
												'<div class="ui-block-b dfc_ic_cc_tc_content">'+TEAM_NAME+'</div>'+
												'<div class="ui-block-a dfc_ic_cc_tc_title">장르</div>'+
												'<div class="ui-block-b dfc_ic_cc_tc_content">'+CODE_GENRE+'</div>'+
											'</div>'+
										'</div>'+
									'</div>';
				
				html = content;
				
				$('#detail_perform_tab').append(html);
				
				//취소된 공연인 경우 내용 바꿈
				if(PF_CANCLE == 1){
					$('#detail_perform_tab').empty();
					PF_CANCLE_MSG = changeLineBreak(PF_CANCLE_MSG);
					
					var cancle_msg = '<dlv id="dp_msg_header">&#91;<a>공연 취소</a> 알림&#93; </div>' + 
										'<div id="dp_msg_body">' + PF_CANCLE_MSG + '</div>';

					$('#detail_perform_tab').html(cancle_msg);
					
					$('#detail_perform_menu').hide();
					$('#detail_perform').css('padding-top', '45px');
				}
				
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });	
				$('#tinfo_showBtn').attr('onclick', 'detail_content_showAll(1)');
			});
		},
	
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});	
	$("#main_cont").hide();
	
	load_pf_reply();
});


//공연 정보 - 교통안내 버튼
$(document).on('click', '#Go_AddrInfoBtn', function() {
	$('.pd_reply_div').hide();
	$('#detail_perform_menu').empty();
	
	var menu_content = '<div class="ui-grid-b header_menu_container">'+
							'<div id="Go_PerInfoBtn" class="ui-block-a">'+
								'<div class="haeder_menu_div_base">'+
									'<span>상세정보</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_AddrInfoBtn" class="ui-block-b">'+
								'<div class="haeder_menu_div_on">'+
									'<span>교통안내</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_PerReviewBtn" class="ui-block-c">'+
								'<div class="haeder_menu_div_base">'+
									'<span>공연후기</span>'+
								'</div>'+
							'</div>'+	
						'</div>';
	
	var html = menu_content;
	
	$('#detail_perform_menu').append(html);
	
	$('#detail_perform_middle').empty();
	
	var middle_content = '<div class="ui-grid-a dp_middle_container">' + 
								'<div class="ui-block-a dp_mc_left">' + 
									'<p>교통안내</p>' + 
								'</div>' +
								'<div class="ui-block-b dp_mc_right">' +
									'<span></span>' +
								'</div>' +
							'</div>';
	
	html = middle_content;
		
	$('#detail_perform_middle').append(html);
		
	$('#detail_perform_tab').empty();
	
	var url = '/service/detail_performance/detail_performance.jsp';
	var data = 'pf_no=' + pf_no_temp;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data : data,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT2');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i) {
				var PF_ADDR = $(this).find("PF_ADDR").text();
				var PF_PLACE = $(this).find("PF_PLACE").text();
				var PF_PLACE_TYPE = $(this).find("PF_PLACE_TYPE").text();
				var PF_TRAFFIC = $(this).find("PF_TRAFFIC").text();
				var PF_LATLNG = $(this).find("PF_LATLNG").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				team_no_temp = TEAM_NO;
				
				var CNT = $(this).find("CNT").text();
				var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$("#ti_bandImg").css('background', 'url("' + value + '")');
					$("#ti_bandImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'cover'});
			     });
				
				tno = TEAM_NO;
				
				var X = PF_LATLNG.split(',')[0];
				var Y = PF_LATLNG.split(',')[1];
				
				$('#ti_bandName').html(TEAM_NAME);
				$('#ti_bandName').attr('onclick', 'go_team_infoPage('+TEAM_NO+')');
				$('#ti_bandInterestCount').html(CNT);
				$('#ti_bandIntro').html(TEAM_INTRO);
				$('#ti_genre').html(CODE_GENRE);
				
				$(".detail_perform_artist").html(TEAM_NAME);
				
				content = '<div class="dp_traffic_container">'+
							'<div id="map">'+
							'</div>'+
							'<div class="ui-grid-d dp_tc_content_box">'+
								'<div class="ui-block-a" style="width: 100%;">'+
									'<div class="ui-grid-a dp_tc_cb_text_container">'+
										'<div class="ui-block-a dp_tc_cb_text_title">주소</div>'+
										'<div class="ui-block-b dp_tc_cb_text_content">'+ PF_ADDR +'</div>'+
									'</div>'+
								'</div>'+
								'<div class="ui-block-b" style="width: 100%;">'+
									'<div class="ui-grid-a dp_tc_cb_text_container">'+
										'<div class="ui-block-a dp_tc_cb_text_title">장소</div>'+
										'<div class="ui-block-b dp_tc_cb_text_content">'+PF_PLACE+'</div>'+
									'</div>'+
								'</div>'+
								'<div class="ui-block-c" style="width: 100%;">'+
									'<div class="ui-grid-a dp_tc_cb_text_container">'+
										'<div class="ui-block-a dp_tc_cb_text_title">상세 설명</div>'+
										'<div class="ui-block-b dp_tc_cb_text_content">'+PF_PLACE_TYPE+'</div>'+
									'</div>'+
								'</div>'+
								'<div class="ui-block-d" style="width: 100%;">'+
									'<div class="ui-grid-a dp_tc_cb_text_container">'+
										'<div class="ui-block-a dp_tc_cb_text_title">교통편</div>'+
										'<div class="ui-block-b dp_tc_cb_text_content">'+PF_TRAFFIC+'</div>'+
									'</div>'+
								'</div>'+
								'<div class="ui-block-e dp_tc_cb_btn">'+
								'<div class="ui-grid-a" id="pf_loadsearch">'+
									'<div class="ui-block-a dp_tc_cb_btn_image">'+
										'<img src="/img/common/location.svg">'+
									'</div>'+
									'<div class="ui-block-b dp_tc_cb_btn_text">길찾기</div>'+
								'</div>'+
							'</div>'+
							'</div>'+
						'</div>';
				
				html = content;
				
				$('#detail_perform_tab').append(html);

				getKakaoMap(Y, X);
				
				PF_PLACE = PF_PLACE.replace(/(\sS)/g, '');
				$('#pf_loadsearch').attr('onclick', 'load_search("'+PF_PLACE.split(',')[0]+'", '+X+', '+Y+')');
			});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});
	$("#main_cont").hide();
});

//공연 정보 -> 공연후기 버튼
$(document).on('click', '#Go_PerReviewBtn', function() {
	count = 1;	//별점을 위한 카운트 초기화
	reviewCount = 0;
	$('#detail_perform_menu').empty();
	$('.pd_reply_div').hide();
	
	var menu_content = '<div class="ui-grid-b header_menu_container">'+
							'<div id="Go_PerInfoBtn" class="ui-block-a">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">상세정보</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_AddrInfoBtn" class="ui-block-b">'+
								'<div class="haeder_menu_div_base">'+
									'<span class="header_menu_text_base">교통안내</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_PerReviewBtn" class="ui-block-c">'+
								'<div class="haeder_menu_div_on">'+
									'<span class="header_menu_text_on">공연후기</span>'+
								'</div>'+
							'</div>'+	
						'</div>';
	
	var html = menu_content;
	
	$('#detail_perform_menu').append(html);
	
	$('#detail_perform_middle').empty();
	
	var middle_content = '<div class="ui-grid-a dp_middle_container">' +
								'<div class="ui-block-a dp_mc_left">' +
									'<p>공연후기</p>' +
								'</div>' +
								'<div class="ui-block-b dp_mc_right">' +
									'<span id="sortname" onclick="detail_perfomr_review_sort();">최신순</span>' +
								'</div>' +
							'</div>';
	
	html = middle_content;
		
	$('#detail_perform_middle').append(html);
	
	$('#detail_perform_tab').empty();
	
	var url = "/service/detail_performance/detail_performance_review.jsp";
	//var data = "pf_no="+pf_no_temp;
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		data:{
			start:reviewCount,
			pf_no:pf_no_temp,
			sort:sortValue
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(reviewCount == 0) {
				$("#detail_perform_tab").html("");
			}
			
			if(DATA.length == 0){
				$("#main_cont").text("공연 후기는 신뢰성을 높이기 위하여 공연장에 비치된 QR코드를 스캔해야만 후기를 작성할 수 있습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if(DATA.length >= 5){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", 'detail_perfomr_reviewload('+pf_no_temp+', sortValue);');
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$(DATA).each(function(i) {
				var EPILOGUE_NO = $(this).find("EPILOGUE_NO").text();
				var PF_NO = $(this).find("PF_NO").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var USER_NO = $(this).find("USER_NO").text();
				var EPILOGUE_IMG = $(this).find("EPILOGUE_IMG").text();
				var EPILOGUE_TITLE = $(this).find("EPILOGUE_TITLE").text();
				var EPILOGUE_CONTENT = $(this).find("EPILOGUE_CONTENT").text();
				var RATY_STAR = $(this).find("RATY_STAR").text();
				var EPILOGUE_DATE = $(this).find("EPILOGUE_DATE").text();
				var EPILOGUE_DEL = $(this).find("EPILOGUE_DEL").text();
				var CODE_DECLARE = $(this).find("CODE_DECLARE").text();
				var NICKNAME = $(this).find("NICKNAME").text();
				
				//var d_img = '/upload/team/team' + TEAM_NO + '/' + EPILOGUE_IMG;
				
				var new_img2 = 'upload/images/team/team' + TEAM_NO + "/" + EPILOGUE_IMG;
                
			     var imgSrc = getImagePromise(new_img2).then(value => {
			    	 $('#eimg'+i).attr('src', value);
			     });
				
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				team_no_temp = TEAM_NO;
				
				var CNT = $(this).find("CNT").text();
				var TEAM_INTRO = $(this).find("TEAM_INTRO").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				
				//var t_img = '/upload/team/team'+ TEAM_NO +'/'+TINTRO_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$("#ti_bandImg").css('background', 'url("' + value + '")');
					$("#ti_bandImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'cover'});
			     });
				
				tno = TEAM_NO;
				
				$('#ti_bandName').html(TEAM_NAME);
				$('#ti_bandName').attr('onclick', 'go_team_infoPage('+TEAM_NO+')');
				$('#ti_bandInterestCount').html(CNT);
				$('#ti_bandIntro').html(TEAM_INTRO);
				$('#ti_genre').html(CODE_GENRE);
				
				$(".detail_perform_artist").html(TEAM_NAME);
				
				content ='<div class="ui-grid-b dp_review_list" onclick="detail_review('+EPILOGUE_NO+');">'+
							'<div class="ui-block-a dp_rl_image">'+
								'<img id="eimg'+i+'">'+
							'</div>'+
							'<div class="ui-block-b" style="width: 60%;">'+
								'<div class="ui-grid-c dp_rl_conetnt_container">'+
									'<div class="ui-block-a dp_rl_cc_title">' + EPILOGUE_TITLE +'</div>'+
									'<div class="ui-block-b dp_rl_cc_ratydiv">'+
										'<div class="ui-grid-a">'+
											'<div class="ui-block-a dp_rl_cc_raty"><p id="tp' + count +'"></p></div>'+
											'<div class="ui-block-b dp_rl_cc_rcount">'+ RATY_STAR +'</div>'+
										'</div>'+
									'</div>'+
									'<div class="ui-block-c dp_rl_cc_content">' + EPILOGUE_CONTENT + '</div>'+
									'<div class="ui-block-d dp_rl_cc_text_container">'+
										'<p class="dp_rl_cc_tc_nickname">'+NICKNAME+'</p>'+
										'<p class="dp_rl_cc_tc_date">'+ EPILOGUE_DATE +'</p>'+
									'</div>'+
								'</div>'+
							'</div>'+
							'<div class="ui-block-c dp_rl_cc_btn">'+
								'<img src="/img/common/show_btn.png">'+
							'</div>'+
						'</div>';
				
				html = content;
				
				$('#detail_perform_tab').append(html);
					
				$(function() {
					$('#tp'+count).raty({
						score : RATY_STAR,
						readOnly : true
					});
				});
				count ++;
			});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});	
});

//공연 상세 페이지 이미지 클릭시 팝업으로 크게 보여주기 
$(document).on('click', '.dfc_ic_image', function(){
	documentScroll = '0px';

	var imgSrc = $(this).find('img').attr('src');
	$('#dfivp_image').removeAttr('src');
	$('#dfivp_image').attr('src', imgSrc);
	
	var popupPosition = $(this).attr('id');
	$("#df_image_view_popup").popup("option" , "dismissible" , false);
	$("#df_image_view_popup").popup("option", "overlayTheme", "b" );
	$("#df_image_view_popup").popup("open");
	$('#df_image_view_popup').css('top', documentScroll);
});

$(document).on('click', '#dfivp_image', function(){
	$("#df_image_view_popup").popup("close");
});


//FOOTER CSS
/*$(document).on('pageshow', '#detail_perform', function() {
	$('.footer_pfsc_txt').css('color', '#8d5cb1');
	$('.footer_pfsc_txt').css('font-weight', 'bold');
	$('.footer_pfsc_img').attr('src', '/img/test/m_schedule2.svg');
});

$(document).on('pagehide', '#detail_perform', function() {
	$('.footer_pfsc_txt').css('color', '#0c0c0c');
	$('.footer_pfsc_img').attr('src', '/img/test/m_schedule.svg');
});*/


//공연상세 댓글 등록버튼 클릭시
$(document).on('click', '#pd_re_insertbtn', function(){
	var login_chk = userLogin_chk();
	if(login_chk == false){
		alert('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	var pf_no = pf_no_temp;
	var pf_reply_content = changeQuotes($('#pf_reply_content').val());
	
	if(pf_reply_content == ''){
		$('#pf_reply_content').val();
		alert('댓글을 입력해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/detail_performance/detail_performance_replyinsert.jsp',
		data : {
			pf_no : pf_no,
			pf_reply_content : pf_reply_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000
	});

	$('#pf_reply_content').val('');
	$('#Go_PerInfoBtn').trigger('click');
});

//공연상세 댓글 답글달기 클릭시
$(document).on('click', '.pd_re_info_rebtn', function() {
	$(this).parents('.pd_re_container').children('.pd_re_re_body').show();
});


//공연상세 댓글 답글 닫기버튼 클릭시
$(document).on('click', '#pd_rere_closebtn', function(){
	$(this).parents('.pd_re_re_body').hide();
});

//공연상세 댓글 답글 등록버튼 클릭시
$(document).on('click', '#pd_re_re_input_btn', function(){
	var login_chk = userLogin_chk();
	if(login_chk == false){
		alert('로그인 후 댓글입력이 가능합니다.');
		return;
	}
	
	var parent_no = $(this).parents('.pd_re_container').attr('id');
	var pf_no = pf_no_temp;
	var pf_rereply_content = changeQuotes($('#pd_re_reply_content_' + parent_no).val());
	
	if(pf_rereply_content == ''){
		$('#pd_re_reply_content_' + parent_no).focus();
		infoTxtBox('답글을 입력해주세요.');
		return;
	}
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/detail_performance/detail_performance_rereplyinsert.jsp',
		data : {
			parent_no : parent_no,
			pf_no : pf_no,
			pf_rereply_content : pf_rereply_content
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000
	});

	$('#pd_re_reply_content_' + parent_no).val('');
	$('#Go_PerInfoBtn').trigger('click');
});

//공연상세 댓글 삭제버튼 클릭시
$(document).on('click', '.pd_re_del_btn', function(){
	var conf = confirm('댓글을 삭제하시겠습니까 ?');
	if(!conf){
		return;
	}
	
	var reply_no = $(this).parents('.pd_re_container').attr('id');
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/detail_performance/detail_performance_replydelete.jsp',
		data : {
			reply_no : reply_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000
	});

	$('#Go_PerInfoBtn').trigger('click');
});

//공연상세 댓글 새로고침 클릭시
$(document).on('click', '#pd_reply_reflash', function(){
	$('#Go_PerInfoBtn').trigger('click');
});