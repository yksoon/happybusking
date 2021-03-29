<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="./js/jquery/jquery-1.11.3.min.js"></script>
		<script src="https://apis.openapi.sk.com/tmap/jsv2?appKey=dcf263a3-23cd-4de9-9cf6-a13a7e15a813"></script>
		<script>									
			var map;
			// 페이지가 로딩이 된 후 호출하는 함수입니다.
			function initTmap(){
				
				// map 생성
				// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
				 map = new Tmapv2.Map("map_div", {
					center : new Tmapv2.LatLng(37.587502, 126.991706), // 지도 초기 좌표
					width : "100vw", // map의 width 설정
					height : "95vh" // map의 height 설정	
				});
				
				var positions = [
					{
						title: '성균관대학교 대학원',
						lonlat: new Tmapv2.LatLng(37.587444, 126.994379)
					},
					{
						title: '성균관대학교 중앙도서관',
						lonlat: new Tmapv2.LatLng(37.588403, 126.994195)
					},
					{
						title: '성균관대학교 대운동장',
						lonlat: new Tmapv2.LatLng(37.587502, 126.991706)
					},
					{
						title: '성균관대학교 대학원',
						lonlat: new Tmapv2.LatLng(37.587444, 126.994379)
					},
					{
						title: '성균관대학교 대학원',
						lonlat: new Tmapv2.LatLng(37.587444, 126.994379)
					},
					{
						title: '성균관대학교 대학원',
						lonlat: new Tmapv2.LatLng(37.587444, 126.994379)
					}
				];
			};
			
			//경로안내 요청 함수
		    function getRP() {
		      
		        var s_latlng = new Tmapv2.LatLng (37.587502, 126.991706);
		        var e_latlng = new Tmapv2.LatLng (37.587444, 126.994379);
		
		        var optionObj = {
		            reqCoordType:"WGS84GEO", //요청 좌표계 옵셥 설정입니다.
		            resCoordType:"WGS84GEO",  //응답 좌표계 옵셥 설정입니다.
		            trafficInfo:"Y"
		        };
		
		        var params = {
		            onComplete:onComplete,
		            onProgress:onProgress,
		            onError:onError
		        };
		
		        var tData = new Tmapv2.extension.TData();
		
		
		        tData.getRoutePlan(s_latlng, e_latlng, optionObj, params);
		    }
			
			//경로안내
		    function onComplete() {
		        
		        console.log(this._responseData); //xml로 데이터를 받은 정보들을 콘솔창에서 확인할 수 있습니다.
		    
		        var kmlObject = new Tmapv2.extension.KML();
		        var kmlForm = kmlObject.read(this._responseData);
		    
		        kmlObject.drawRoute(map, kmlForm);
		        map.setCenter(new Tmapv2.LatLng(37.587502, 126.991706));
		        map.setZoom(18);
		    }
			
			//데이터 로드중 실행하는 함수입니다.
		   function onProgress(){
		       
		   }
			
		 	//데이터 로드 중 에러가 발생시 실행하는 함수입니다.
		   function onError(){
		       alert("onError");
		   }
		</script>
	</head>
	<body onload="initTmap()">
		<div id="map_div"></div>
		<button onClick="getRP()">경로요청 실행</button>
	</body>
</html>
				

					