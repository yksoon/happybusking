//마우스 휠 인식
var slideIndex = 1;
var nowpage = 0;
var nowpageTmp = 0;
var totalpage = 6;	//전체 페이지수 - 1
var hcicviewcount = 0;	//사업자정보 보이는경우 1, 안보이는경우 0

/*function htmlScroll(){
	$('html, body').on('mousewheel DOMMouseScroll', function(e){
		var trans = '';
		var E = e.originalEvent;
		delta = 0;
		if(E.detail){
			delta = E.detail * -40;
		} else {
			delta = E.wheelDelta;
		}
		
		var height = $('body').css('height').split('px')[0];
		var hcicheight = $('#hpage_hcic').css('height').split('px')[0];
		
		if(delta < 0){
			//마우스 휠 다운
			if(nowpage == totalpage){
				$('#hpage_hcic').fadeIn('fast');
				hcicviewcount = 1;
				return;
			}
			nowpage += 1;
		} else{
			//마우스 휠 업
			if(nowpage == totalpage){
				if(hcicviewcount == 1){
					$('#hpage_hcic').fadeOut('fast');
					hcicviewcount = 0;
					nowpage = totalpage + 1;
					return;
				}
			}
			
			if(nowpage == 0){
				return;
			}
			nowpage -= 1;
		}
		nowpageTmp = nowpage;
		
		height = height * nowpage;
		height = '-' + height + 'px';
		
		trans = 'translate3d(0px, '+height+', 0px)';
		
		$('.hpage_body_container').css('transform', trans);
		
		$('.hpage_footer').find('img').attr('src', '/img/homepage/img/'+(nowpage+1)+'_scroll.png');
		
		$('.hps_menu_title').removeClass('hps_menu_select_title');
		$('#hps_menu_'+nowpage).addClass('hps_menu_select_title');
		
		$('html, body').off('mousewheel DOMMouseScroll');
		setTimeout(function(){
			htmlScroll();
		}, 700);
	});
}


$('html, body').on('mousewheel DOMMouseScroll', function(e){
	htmlScroll();
});


//네이게이션 버튼 클릭시 페이지 이동
$(document).on('click', '.hps_menu_title', function(){
	$('.hps_menu_title').removeClass('hps_menu_select_title');
	$(this).addClass('hps_menu_select_title');

	var height = $('body').css('height').split('px')[0];
	nowpage = $(this).attr('id').split('_');
	nowpage = (nowpage[nowpage.length - 1]*1);
	
	if(nowpage == 5){
		nowpage = nowpageTmp;
		$('.hpage_event_popup').show();
		return;
	}
	
	nowpageTmp = nowpage;
	
	height = height * nowpage;
	height = '-' + height + 'px';
	
	trans = 'translate3d(0px, '+height+', 0px)';
	$('.hpage_body_container').css('transform', trans);
	$('.hpage_footer').find('img').attr('src', '/img/homepage/img/'+(nowpage+1)+'_scroll.png');
});*/

// $(document).ready(function(){
// 	var height = $('body').css('height').split('px')[0];
	
// 	$('.hpage_body').css('height', height);

// 	height = height * nowpage;
// 	height = '-' + height + 'px';
	
	
	//var requestStr2 = request.getParameter("team_no");
	
	//console.log(requestStr2);
	
	// if(requestStr == '1' || requestStr == 1){
	// 	$('#hps_menu_6').click();
	// }
	
	/*if(requestStr2 != null && requestStr2 != ''){
		var url = 'https://www.happybusking.com/app/appresult.jsp?team_no='+requestStr2;
		location.href = url;
	}*/
// });

// $(window).resize(function(){
// 	var height = $('body').css('height').split('px')[0];
	
// 	$('.hpage_body').css('height', height);

// 	height = height * nowpage;
// 	height = '-' + height + 'px';
	
// 	/*var trans = 'translate3d(0px, '+height+', 0px)';
// 	$('.hpage_body_container').css('transform', trans);*/
// });

// $(document).on('click', '.hps_menu_title', function(){
// 	$('.hps_menu_title').removeClass('hps_menu_select_title');
// 	$(this).addClass('hps_menu_select_title');
	
// 	var clickpage = $(this).attr('id').split('_')[2];
// 	var height = 0;
// 	var scroll;
	
// 	if(clickpage == '5'){
// 		$('.hpage_busker_oath_popup').show();
// 	} else if(clickpage == '6'){
// 		$('.hpage_event_popup').show();
// 	} else {
// 		if(clickpage == 0){
// 			height = 0;
// 		}
// 		for(var i = 1; i <= clickpage; i++){
// 			var thisHeight = $('#hpage'+i).css('height');
// 			thisHeight = thisHeight.split('px')[0];
			
// 			height = height + (thisHeight * 1);
// 		}
// 		$('html').scrollTop(height);
// 	}
// });

// document.addEventListener('scroll', function(e){
// 	sidemenuChange();
// });



// function sidemenuChange(){
// 	var height = window.scrollY;
	
// 	var hpage1 = ($('#hpage1').css('height').split('px')[0]) * 1;
// 	var hpage2 = hpage1 + ($('#hpage2').css('height').split('px')[0]) * 1;
// 	var hpage3 = hpage2 + ($('#hpage3').css('height').split('px')[0]) * 1;
// 	var hpage4 = hpage3 + ($('#hpage4').css('height').split('px')[0]) * 1;
// 	var hpage5 = hpage4 + ($('#hpage5').css('height').split('px')[0]) * 1;
	
// 	$('.hps_menu_title').removeClass('hps_menu_select_title');
// 	if(height < hpage1){
// 		$('#hps_menu_0').addClass('hps_menu_select_title');
// 	} else if(hpage1 <= height && height < hpage2){
// 		$('#hps_menu_1').addClass('hps_menu_select_title');
// 	} else if(hpage2 <= height && height < hpage3){
// 		$('#hps_menu_2').addClass('hps_menu_select_title');
// 	} else if(hpage3 <= height && height < hpage4){
// 		$('#hps_menu_3').addClass('hps_menu_select_title');
// 	} else {
// 		$('#hps_menu_4').addClass('hps_menu_select_title');
// 	}
// }

$(document).on('click', '#ip_artist_main', function(){
	if( $(this).attr('class') == 'ip_header_t_base'){
		$('#ip_artist_qa').removeClass('ip_header_t_on');
		$(this).removeClass('ip_header_t_base');
		$('#ip_artist_qa').addClass('ip_header_t_base');
		$(this).addClass('ip_header_t_on');
		$('.ip_container_content_a').show();
		$('.ip_container_content_b').hide();
	}
	else{
		return;
	}
	
});
$(document).on('click', '#ip_artist_qa', function(){
	if( $(this).attr('class') == 'ip_header_t_base'){
		$('#ip_artist_main').removeClass('ip_header_t_on');
		$(this).removeClass('ip_header_t_base');
		$('#ip_artist_main').addClass('ip_header_t_base');
		$(this).addClass('ip_header_t_on');
		$('.ip_container_content_a').hide();
		$('.ip_container_content_b').show()
	}
	else{
		return;
	}	
});

$(document).on('click', '.ip_qa_content_q', function(){
	if( $(this).attr('id') == 'ip_q_1'){
		$(this).hide();
		$('#ip_a_1').show();
	}
	else if( $(this).attr('id') == 'ip_q_2'){
		$(this).hide();
		$('#ip_a_2').show();
	}	
	else if( $(this).attr('id') == 'ip_q_3'){
		$(this).hide();
		$('#ip_a_3').show();
	}			
});	

$(document).on('click', '.ip_qa_content_a', function(){
	if( $(this).attr('id') == 'ip_a_1'){
		$(this).hide();
		$('#ip_q_1').show();
	}	
	else if( $(this).attr('id') == 'ip_a_2'){
		$(this).hide();
		$('#ip_q_2').show();
	}	
	else if( $(this).attr('id') == 'ip_a_3'){
		$(this).hide();
		$('#ip_q_3').show();
	}	
});	
$(document).on('click', '.ip_content_ct2_content_box_b_r_a', function(){
    slideIndex = 1;
	//documentScroll = '0px';
    // var _width = '830';
    // var _height = '678';
    // var _left = Math.ceil(( window.screen.width - _width )/2);
    // var _top = Math.ceil(( window.screen.width - _height )/2); 
   
	//var popupPosition = $(this).attr('id');
	// var src = $('#stroe_menu_img').attr('src');
	// $('#team_img_popup').append('<img id="tip_picture_img"/>');
	// $('#tip_picture_img').attr('src', src);
    if($(this).attr('id') == 'ip_signature_detail'){
        var popup_but_html = '<div class="slides_no">' +
                            '<div class="dot" onclick="currentSlide(1)"></div>' +
                            '<div class="dot" onclick="currentSlide(2)"></div>' +
                            '<div class="dot" onclick="currentSlide(3)"></div>' +
                            '</div>';
                            // '<div class="prev" onclick="plusSlides(-1)"></div>' +
                            // '<div class="next" onclick="plusSlides(1)"></div>';
                            
        var popup_html = '<div class="ip_signature_popup">' +
                        '<div class="ip_popup_close"></div>' +
						'<div class="prev" onclick="plusSlides(-1)"></div>' +
                        '<div class="next" onclick="plusSlides(1)"></div>'+
                        '<div class="slideshow-container">' +
                        '<div class="mySlides fade">' +
							'<div class="mySlides_left">' +
								'<div class="mySlides_title_s">전자 계약</div>' +
								'<div class="mySlides_title_b">공연 승인 및 계약 진행</div>' +
								'<div class="mySlides_content">상업공간 공연 신청을 하면 공연팀의</div>' +
								'<div class="mySlides_content">기본 계약 정보가 사업주에게 전달됩니다.</div>' +
							'</div>' +
							'<div class="mySlides_right">' +
								'<img class="mySlides_right_img" src="/img/index_promotion/popup_img.@2x.png">'+
							'</div>' +
                        '</div>' +
                        '<div class="mySlides fade">' +
							'<div class="mySlides_left">' +
								'<div class="mySlides_title_s">전자 계약</div>' +
								'<div class="mySlides_title_b">공연 승인 및 계약 진행</div>' +
								'<div class="mySlides_content">상업공간 공연 신청을 하면 공연팀의</div>' +
								'<div class="mySlides_content">기본 계약 정보가 사업주에게 전달됩니다.</div>' +
							'</div>' +
							'<div class="mySlides_right">' +
								'<img class="mySlides_right_img" src="/img/index_promotion/popup_img.@2x.png">'+
							'</div>' +
                        '</div>' +
                        '<div class="mySlides fade">' +
                        '</div>' +
                        '</div>';

        
    }
    else{
        var popup_but_html = '<div class="slides_no">' +
                            '<div class="dot" onclick="currentSlide(1)"></div>' +
                            '<div class="dot" onclick="currentSlide(2)"></div>' +
                            '<div class="dot" onclick="currentSlide(3)"></div>' +
                            '<div class="dot" onclick="currentSlide(4)"></div>' +
                            '</div>';
                            
                            
        var popup_html = '<div class="ip_signature_popup">' +
                        '<div class="ip_popup_close"></div>' +
						'<div class="prev" onclick="plusSlides(-1)"></div>' +
                        '<div class="next" onclick="plusSlides(1)"></div>'+
                        '<div class="slideshow-container">' +
                        '<div class="mySlides fade">테' +
                        '</div>' +
                        '<div class="mySlides fade">스' +
                        '</div>' +
                        '<div class="mySlides fade">트' +
                        '</div>' +
                        '<div class="mySlides fade">테스트' +
                        '</div>' +
                        '</div>';

    }
    $('#ip_ct2_popup').append(popup_but_html);
    $('#ip_ct2_popup').append(popup_html);
    // $('.ip_signature_popup').css({"top":_top});
    // $('.ip_signature_popup').css({"left":_left});
	$("#ip_ct2_popup").show();
    
    showSlides(slideIndex);
	//$('#team_img_popup').css('top', documentScroll);

// 	<div class="slideshow-container">

// <div class="mySlides fade">
//   <div class="numbertext">1 / 3</div>
//   <img src="http://placehold.it/300x100" style="width:100%">
//   <div class="text">Caption Text</div>
// </div>

// <div class="mySlides fade">
//   <div class="numbertext">2 / 3</div>
//   <img src="http://placehold.it/300x100" style="width:100%">
//   <div class="text">Caption Two</div>
// </div>

// <div class="mySlides fade">
//   <div class="numbertext">3 / 3</div>
//   <img src="http://placehold.it/300x100" style="width:100%">
//   <div class="text">Caption Three</div>
// </div>

// <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
// <a class="next" onclick="plusSlides(1)">&#10095;</a>

// </div>
// <br>

// <div style="text-align:center">
//   <span class="dot" onclick="currentSlide(1)"></span> 
//   <span class="dot" onclick="currentSlide(2)"></span> 
//   <span class="dot" onclick="currentSlide(3)"></span> 
// </div>

	// var el = document.querySelector('#tip_picture_img');
	// new PinchZoom.default(el, {
		
	// });
});
$(document).on('click', '.ip_popup_close', function(){
    $("#ip_ct2_popup").empty();
    $("#ip_ct2_popup").hide();
});



function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}

$(document).on('click', '.ip_content_ct_but', function(){
	if( $(this).attr('id') == 'ip_ct_but_a'){
		location.href="http://artinsure.kawf.kr/";
	}	
	else if( $(this).attr('id') == 'ip_ct_but_b'){
		location.href="https://www.kcomwel.or.kr/kcomwel/paym/offi/prxy_syst.jsp";
	}	
	else if( $(this).attr('id') == 'ip_ct_but_c'){
		
	}	
});	