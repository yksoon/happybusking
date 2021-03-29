$(document).ready(function(){
	var request = new Request();
	var requestStr = request.getParameter("team_no");
	
	//parameter
	//cooperation : 협업기관
	//pno : 공연장소번호 (perform-place)
	//schk : qr스캔해서 들어왔는지 ? (y)
	
	
	if(requestStr == null || requestStr == ''){
		$('#apprp_team_name').text('해피버스킹');
		return;
	} else {
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			cache: false,
			url: '/service/team/team_info.jsp',
			data: {
				team_no : requestStr
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success: function (data) {
				var ROOT = $(data).find("ROOT");
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var TEAM_NAME = $(this).find('TEAM_NAME').text();
					
					$('#apprp_team_name').text(TEAM_NAME);
				});
			}
		});
	}
});

$(document).on('click', '#apprp_google_btn', function(){
	window.open('https://play.google.com/store/apps/details?id=com.happybusking', '_self');
});

$(document).on('click', '#apprp_apple_btn', function(){
	window.open('https://itunes.apple.com/kr/app/해피버스킹/id1436945374?mt=8', '_self');
});

//Request를 function으로 생성 (GET 방식만 가능)
function Request(){
	var requestParam = "";
	
	//getParameter 펑션
	this.getParameter = function(param){
		//연재 주소를 decoding
		var url = unescape(location.href);
		
		//파라미터만 자르고, 다시 &구분자를 잘라서 배열에 넣음
		var paramArr = (url.substring(url.indexOf("?")+1, url.length)).split("&");
		
		for(var i = 0; i < paramArr.length; i++){
			var temp = paramArr[i].split("=");//파라미터 변수명을 담음
			
			if(temp[0].toUpperCase() == param.toUpperCase()){
				//변수명과 일치할 경우 데이터 삽입
				requestParam = paramArr[i].split("=")[1];
				break;
			}
		}
		return requestParam;
	}
}