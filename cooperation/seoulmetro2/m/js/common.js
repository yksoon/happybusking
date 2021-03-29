const getParameterByName = (name) => {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

const getTeamInfo = (tno) => {
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/team/team_info.jsp',
		data: {
			team_no : tno
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
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var TEAM_INTRO =$(this).find("TEAM_INTRO").text();
				var TINTRO_IMG = $(this).find("TINTRO_IMG").text();
				
				$('#now_team_name').text(TEAM_NAME);
				$('#now_team_info').text(TEAM_INTRO);
				
				var new_img = 'upload/images/team/team' + tno + "/" + TINTRO_IMG;
                
			    var imgSrc = getImagePromise(new_img).then(value => {
			    	$('#now_team_image').attr('src', value);
			    });
			});
		}
	});
}

const handlerPanelClose = () => {
	const s = $(window).scrollTop();
	if(s === 0) {
		$('.header').removeClass('header-white');
		$('.logo').attr('src', './img/v2/logo1.png');
		$('.menu').attr('src', './img/v2/menu.png');
	} else {
		$('.header').addClass('header-white');
		$('.logo').attr('src', './img/v2/logo2.png');
		$('.menu').attr('src', './img/v2/menu2.png');
	}
	
	$('.menu').show();
	$('.close').hide();
	$('#panel').slideUp('fast');
}

const goRanding = (url) => {
	location.href = url;
}