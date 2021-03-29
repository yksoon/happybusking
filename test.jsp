<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%-- <%@include file="/service_include.jsp" %>    --%>    
<!DOCTYPE html">
<html>
<head>
<meta charset="UTF-8">
<meta id="viewport" name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, height=device-height, user-scalable=no, viewport-fit=cover">
<meta name="msapplication-tap-highlight" content="no">
<script type="text/javascript" src="/js/jquery/jquery-1.11.3.min.js" ></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5caef794e0c0d34ae5082d15d8cbdcc9&libraries=services,clusterer"></script>
<title>Insert title here</title>

<style type="text/css">
	body, p{
		padding: 0;
		margin: 0;
	}
	#map{
		width: 100vw;
		height: 350px;
	}
	
	.title{
		width: 80vw;
		margin: 0 auto;
		margin-top: 20px;
	}
	
	.inputbox {
		width: 80vw;
		margin: 0 auto;
		text-align: center;
	}
	.inputbox input{
		width: 100%;
	}
	
	.inputbox_b{
		width: 80vw;
		margin: 0 auto;
		text-align: right;
	}
	
	.inputbox_b input{
		width: 17%;
		text-align: center;
	}
</style>

</head>
<body>
	<div id="map"></div>
	
	<p class="title">
		반경 설정
	</p>
	<div class="inputbox">
		<input type="range" id="radius_num" min="1" max="300" value="1">
	</div>
	<div class="inputbox_b">
		<input type="text" id="radius_text" value="1km">
	</div>
	
	<script type="text/javascript">
		$(document).on('change', '#radius_num', function(){
			var res = $(this).val();
			var str = res + 'km';
			
			$('#radius_text').val(str);
			
			var radius = parseInt(res) * 1000;
			
			changeOption(radius);
		});
	</script>
	
	<script type="text/javascript">
		var lat, lng;
		var circle;
		var map;
		var markers = new Array();
		var infowindows = new Array();
	
		//내 위치중심으로 지도 생성 + 마커 표시
		$(document).ready(function(){
			navigator.geolocation.getCurrentPosition(onSuccess, onError);
		});
		
		function onSuccess(pos){
			lat = pos.coords.latitude;
			lng = pos.coords.longitude;
			
			makeMap();
		}
		
		function onError(error){
			alert('위치를 가져올 수 없습니다.\n위치 제공을 허용 했는지 확인해주세요.');
			lat = 37.519332;
			lng = 126.931450;
			
			makeMap();
			//alert('위치를 가져올 수 없습니다.\n위치 제공을 허용 했는지 확인해주세요.');
		}
		
		function makeMap(){
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(lat, lng),
				level: 6
			};
		
			map = new kakao.maps.Map(container, options);
			
			makeMarker();
			makeCircle(1000);
			getFestivalList(1);
		}
		
		function changeOption(radius){
			removeCircle();
			makeCircle(radius);
			removeInfowindows();
			getFestivalList(radius / 1000);
		}
		
		function makeMarker(){
			var markerPosition = new kakao.maps.LatLng(lat, lng);
			
			var marker = new kakao.maps.Marker({
				position: markerPosition
			});
			
			marker.setMap(map);
		}
		
		function addMarker(sLat, sLng, sInfo){
			var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			var imageSize = new kakao.maps.Size(24, 35); 
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			
			var marker = new kakao.maps.Marker({
					title: sInfo,
					position: new kakao.maps.LatLng(sLat, sLng),
			      	image : markerImage // 마커 이미지 
			});
			marker.setMap(map);
			
			markers.push(marker);			
			
			var iwContent = '<p style="padding:5px; text-align: center; font-size: 14px;">' + sInfo + '</p>';
			var iwPosition = new kakao.maps.LatLng(sLat, sLng);
			
			infowindow = new kakao.maps.InfoWindow({
				position: iwPosition,
				content: iwContent
			});
			
			infowindows.push(infowindow);
			
			infowindow.open(map, marker);
		}
		
		function makeCircle(radius){
			circle = new kakao.maps.Circle({
				center : new kakao.maps.LatLng(lat, lng),
				radius: radius, // 미터 단위의 원의 반지름입니다 
				strokeWeight: 5, // 선의 두께입니다 
				strokeColor: '#75B8FA', // 선의 색깔입니다
				strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle: 'dashed', // 선의 스타일 입니다
				fillColor: '#CFE7FF', // 채우기 색깔입니다
				fillOpacity: 0.7  // 채우기 불투명도 입니다   
			});
			
			circle.setMap(map);
			
			var level;
			
			var km = radius / 1000;
			
			if(km == 1){
				level = 6;
			} else if(km == 2 || km == 3){
				level = 7;
			} else if(km == 4 || km == 5){
				level = 8;
			} else if(km > 6 && km <= 10){
				level = 9;
			} else if(km > 10 && km <= 25){
				level = 10;
			} else if(km > 25 && km <= 50){
				level = 11;
			} else if(km > 50 && km <= 120){
				level = 12;
			} else if(km > 120 && km <= 200){
				level = 13;
			} else {
				level = 14;
			}
			/*switch(radius / 1000){
				case 1:
					level = 6;
					break;
				case 2:
					level = 7;
					break;
				case 3:
					level = 7;
					break;
				case 4:
					level = 8;
					break;
				case 5:
					level = 8;
					break;
				default:
					level = 6;
					break;
			}*/
			
			
			
			map.setLevel(level);
		}
		
		function removeCircle(){
			circle.setMap(null);
		}
		
		function removeMarkers(){
			for(var i = 0; i < markers.length; i++){
				markers[i].setMap(null);
			}
			markers = new Array();
		}
		
		function removeInfowindows(){
			for(var i = 0; i < infowindows.length; i++){
				infowindows[i].close();
			}
			infowindows = new Array();
		}
		
		function getFestivalList(radius){
			removeMarkers();
			
			$.ajax({
				type: "GET",
				cache: false,
				url: '/service/test.jsp',
				data: {
					lat: lat, 
					lng: lng,
					radius: radius
				},
				contentType: "application/xml; charset=utf-8",
				dataType: "xml",
				timeout: 30000,
				success : function(data){
					var ROOT = $(data).find('ROOT');
					var DATA = $(ROOT).find('DATA');
					
					$(DATA).each(function(){
						var sLat = $(this).find('sLat').text();
						var sLng = $(this).find('sLng').text();
						var sInfo = $(this).find('sInfo').text();
						
						addMarker(sLat, sLng, sInfo);
					});
				},
				error: function(a, b, c){
					console.log(a);
					console.log(b);
					console.log(c);
				}
			});
		}
	</script>
</body>
</html>