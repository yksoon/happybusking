var dai_uno = "";
var dai_tno = "";

function detailArtist(UNO, TNO){
	dai_uno = UNO
	dai_tno = TNO
	loadPage('detail_artist/detail_artist.jsp');
}



$(document).on("pageinit","#detail_artist",function(){

	//infoTxtBox(tno);
	
	var DAI_UNO = dai_uno;
	var DAI_TNO = dai_tno;
	
	
	//AJAX 로딩 표시
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	var url = "/service/detail_artist/detail_artist.jsp";
	var data = "uno=" + DAI_UNO +"&tno="+DAI_TNO;
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
				
				return;
			}
			

			$(DATA).each(function(i) {
				//XML 컬럼들 
				var USER_NO = $(this).find("USER_NO").text();
				//var AGE = $(this).find("AGE").text();
				//var GENDER = $(this).find("GENDER").text();
				var ARTIST_NAME = $(this).find("ARTIST_NAME").text();
				var ARTIST_INTRO = changeLineBreak($(this).find("ARTIST_INTRO").text());
				var ARTIST_IMG = $(this).find("ARTIST_IMG").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				var USE_TOOL = $(this).find("USE_TOOL").text();
				var ARTIST_SNS = $(this).find("ARTIST_SNS").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var PART = $(this).find("PART").text();
				var CNT = $(this).find("CNT").text();
				
				//var a_img = '/upload/artist/artist'+ USER_NO +'/'+ARTIST_IMG;
				
				var new_img = 'upload/images/artist/artist' + USER_NO + "/" + ARTIST_IMG;
			     var imgSrc = getImagePromise(new_img).then(value => {
			    	 $('#detail_artistImg').css('background', 'url("' + value + '")');
			    	 $("#detail_artistImg").css({'background-repeat': 'no-repeat', 'background-position': 'center', 'background-size': 'contain' , 'background-color': 'black'});
			     });
				
				/*if(GENDER == 'M'){
					GENDER = '남자';
				}else if(GENDER == 'F'){
					GENDER = '여자';
				}*/

				var url = '';
				
				if(ARTIST_SNS != null || ARTIST_SNS != ''){
					var artistSNSArray = ARTIST_SNS.split('&happybusking&');
					
					for(var i = 0; i < artistSNSArray.length; i++){
						var urlTest1 = artistSNSArray[i].split('://')[0];
						var urlTest2 = artistSNSArray[i].split('.')[0];
						if(urlTest1 == 'https' || urlTest1 == 'http' || urlTest2 == 'www' || urlTest2 == 'blog'){
							url += '<a href="' + artistSNSArray[i] + '" target="_blank">' + artistSNSArray[i] + '</a><br>';
						} else {
							url += '<span>' + artistSNSArray[i] + '</span><br>';
						}
						
					}
					
				}
				
				$('#detail_artistName').html(ARTIST_NAME);
				$('#da_part').html(PART);
				$('#da_team').html(TEAM_NAME);
				$('#dai_bandInterestCount').html(CNT);
				$('#dai_tname').html(TEAM_NAME);
				//$('#dai_gender').html(GENDER);
				//$('#dai_age').html(AGE);
				$('#dai_genre').html(CODE_GENRE);	
				$('#dai_tool').html(USE_TOOL);
				$('#dai_site').html(url);
				$('#da_intro').html(ARTIST_INTRO);	
				
					
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });		
				var h = $('#da_intro').outerHeight();
				if(h > 114){
					$('#dainfo_showBtn').attr('onclick', 'dainfo_showAll(1)');
					$("#da_intro").css({'overflow': 'hidden', 'white-space': 'normal', 'height': '6em', 'word-wrap': 'break-word',
						'display': '-webkit-box', '-webkit-line-clamp': '4', '-webkit-box-orient': 'vertical'});							
				}else{
					$('#dainfo_showBtn').attr('onclick', 'dainfo_showAll(0)');
					$("#da_intro").css({'height': '6em'});																	
				}					

			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error 
	});			
	
});


//아티스트 세부정보 전체보기 버튼 클릭 시
function dainfo_showAll(CHK){
	if(CHK == "1"){
		$("#da_intro").css({'overflow': '', 'white-space': '', 'height': '', 'word-wrap': '',
			'display': '', '-webkit-line-clamp': '', '-webkit-box-orient': ''});
					
	}

}

$(document).on('click', '#dai_site a' ,function(e){
	e.preventDefault(); 
	var url = $(this).attr("href");
	
	var urlTmp = url.split('://')[0];
	if(urlTmp != 'http' && urlTmp != 'https'){
		url = 'http://' + url;
	}
	
	window.open(url, "_blank");  
});

