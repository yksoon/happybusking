$(document).ready(function(){

	$("#performance_alarmDistance").on("pageinit", function(){
		initDistance();	
		//select box 초기화
		$("#addrSearch_alarm").change(function(){
			$('#distance_radius').val("").selectmenu('refresh');
		});
			
	});
/*	var date = $("#alarm_date").val();
	var time = $("#alarm_time").val();
	alert("date =" + date + ","+ "time = " +time);*/
});



//지도 함수(searchBox 모드)
function initDistance(){
	
	var input = document.getElementById('addrSearch_alarm');	
	var searchBox = new google.maps.places.SearchBox(input);
	var select = document.getElementById("distance_radius");
	
	//지도 검색창 change 될 때
	searchBox.addListener('places_changed', function() {

		var map = new google.maps.Map(document.getElementById('alarm_mapArea'));
				
		var infowindow = new google.maps.InfoWindow();
		var markerS = new google.maps.Marker({
			map: map
		});
		
		markerS.addListener('click', function() {
			infowindow.open(map, markerS);
		});
		
		var places = searchBox.getPlaces();
	    if (places.length == 0) {
	      return;
	    }
	    places.forEach(function(place){
			if (place.geometry.viewport) {
				map.fitBounds(place.geometry.viewport);
			} else {
				map.setCenter(place.geometry.location);
				map.setZoom(17);
			}
			
			
			markerS.setPosition(place.geometry.location);
			markerS.setVisible(true);
			infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
					place.formatted_address);
			infowindow.open(map, markerS);		
	    });
		
	 });
	
	//select에 따른 지도 반경 구현 부분
	select.onchange = function(){
		var places = searchBox.getPlaces();
		var radius = select.options[select.selectedIndex].value;		
		var zoom = "";
		
		if(radius == "100"){
			zoom = 17;
		}else if(radius == "500"){
			zoom = 14;
		}else if(radius == "1000"){
			zoom = 13;
		}else if(radius == "3000"){
			zoom = 12;
		}else if(radius == "5000"){
			zoom = 11;
		}
		
		 places.forEach(function(place){
			 	var map = new google.maps.Map(document.getElementById('alarm_mapArea'), {
			 		center : place.geometry.location,
			 		zoom : zoom
			 	});
			 	var marker = new google.maps.Marker({
					map: map
				});
			 	var infowindow = new google.maps.InfoWindow();
			 	
				marker.setPosition(place.geometry.location);
				marker.setVisible(true);
				infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
						"반경 : " + radius + "m");
				infowindow.open(map, marker);	

				new google.maps.Circle({
					strokeColor : "#5CD1E5",
					strokeOpacity : 0.8,
					strokeWeight : 2,
					fillColor : "#FFFFFF",
					fillOpacity : 0.4,
					map : map,
					center : marker.getPosition(),
					radius : radius * 1
				});	

		    });
		 
		
	};
	
	
}




