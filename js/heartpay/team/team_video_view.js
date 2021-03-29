
//해당 아티스트 동영상 페이지 이동
function goTeamVideoList(){
	loadPage('team/team_video_view.jsp');
}


$(document).on('pageinit', '#team_video_view', function() {

	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/team/team_video_view.jsp";
	var data = "team_no=" + tno;
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
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				$("#teamVideoView_part").html('<div id="main_cont" class="noViewBtn">내용이 없습니다.</div>');
				
				return;
			}
			
			
			$('#teamVideoView_part').empty();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var NICKNAME = $(this).find("NICKNAME").text();
				var VIDEO_UPLOAD_CONTENT = $(this).find("VIDEO_UPLOAD_CONTENT").text();
				var VIDEO_UPLOAD_URL = $(this).find("VIDEO_UPLOAD_URL").text();
				
				var html = 
					'<div class="videoBundle">' +
						'<iframe width="100%" height="220" src="' + VIDEO_UPLOAD_URL + '" frameborder="0" allowfullscreen>' +
						'</iframe>' +
						'<p class="videoBundleUser">'+ NICKNAME + '</p>' +
						'<p>'+ VIDEO_UPLOAD_CONTENT + '</p>' +
					'</div>';
				
				$('#teamVideoView_part').append(html);

		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });					
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
