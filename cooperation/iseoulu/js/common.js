var scrollTime = 150;
var scrollTimer = null;

$(document).ready(function(){
	$(window).on('scroll', _.throttle(function(){
		indexScrollEvent();
	}, 300));
	
	//패널 스와이프시
	$('.panel_wapper').swipe({
		swipe: function(event, direction){
			switch(direction){
				case 'right':
					hidePanel();
					break;
			}
		},
		maxTimeThreshold:1000,
        threshold:50,
        triggerOnTouchEnd:false,
        excludedElements:'.pwh_homepage_btn, .pwc_span, .pwc2_p'
	});
});

//패널오픈 버튼 클릭시
$(document).on('click', '.hw_panel_btn', function(){
	$('body').css('overflow-y', 'hidden');
	$('html').css('overflow-y', 'hidden');
	$('.panel').show();
	$('.panel_wapper').animate({
		right: '0'
	}, 200);
});

//패널 닫기버튼 또는 백그라운드 클릭시
$(document).on('click', '.panel_background, .pw_close_btn', function(){
	hidePanel();
});

//패널 메뉴 아이템 클릭시
$(document).on('click', '.pwc_span', function(){
	var nowPage = window.location.href;
	nowPage = nowPage.split('/');
	nowPage = nowPage[nowPage.length - 1];
	
	nowPage = nowPage.split('?');
	if(nowPage.length > 1){
		nowPage = nowPage[0];
	}
	
	console.log(nowPage);
	
	var str = $(this).attr('id');
	var moveScroll = 0;
	
	hidePanel();
	
	if(nowPage == 'partners.jsp' || nowPage == 'plist.jsp' || nowPage == 'pdetail.jsp'){
		location.href = '/cooperation/iseoulu/index.jsp';
	} else {
		if(str == 'pwc_0'){
			location.href='/cooperation/iseoulu/index.jsp';
		} else if(str == 'pwc_1'){
			moveScroll = 250;
		} else if(str == 'pwc_2'){
			location.href='/cooperation/iseoulu/view/partners.jsp';
		} else if(str == 'pwc_3'){
			location.href='/cooperation/iseoulu/view/product/plist.jsp';
		} else if(str == 'pwc_4'){
			moveScroll = 1300;
		} else if(str == 'pwc_5'){
			moveScroll = 1700;
		} else if(str == 'pwc_6'){
			moveScroll = 2000;
		}
		
		$(window).scrollTop(moveScroll);
	}
});

//url 주소로 파라미터 값 받기
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function hidePanel(){
	$('body').css('overflow-y', 'auto');
	$('html').css('overflow-y', 'auto');
	$('.panel_wapper').animate({
		right: '-345px'
	}, 200, function(){
		$('.panel').hide();
	});
}

function indexScrollEvent(){
	var indexScroll = $(window).scrollTop();
	
	if(indexScroll > 0){
		$('.header_wapper').parents('header').addClass('white_background');
		$('.header_wapper').find('.hw_back_btn').attr('src', '/cooperation/iseoulu/img/icon/back_2.svg');
		$('.header_wapper').find('.hw_cart_btn').attr('src', '/cooperation/iseoulu/img/icon/cart_2.svg');
		$('.header_wapper').find('.hw_panel_btn').attr('src', '/cooperation/iseoulu/img/icon/menu_2.svg');
	} else if(indexScroll == 0) {
		$('.header_wapper').parents('header').removeClass('white_background');
		$('.header_wapper').find('.hw_back_btn').attr('src', '/cooperation/iseoulu/img/icon/back.svg');
		$('.header_wapper').find('.hw_cart_btn').attr('src', '/cooperation/iseoulu/img/icon/cart.svg');
		$('.header_wapper').find('.hw_panel_btn').attr('src', '/cooperation/iseoulu/img/icon/menu.svg');
	}
}

function goHome(){
	location.href='/cooperation/iseoulu/';
}

function makeMap(x, y, id){
	var container = document.getElementById(id),
    options = {
         center: new kakao.maps.LatLng(x, y),
         level: 2
    };
	var map = new kakao.maps.Map(container, options);
	
	var markerPosition  = new kakao.maps.LatLng(x, y); 
	
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	marker.setMap(map);
}