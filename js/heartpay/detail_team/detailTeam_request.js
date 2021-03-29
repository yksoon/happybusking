$(document).ready(function(){
	initAutocomplete();		
	
	$('#btn_delphoto').hide();
	$('#btn_delpromote').hide();
	
	//공연 메인 사진쪽
	$("#btn_getphoto").click(function(){
		getArtistPhoto();
	});
	
	$("#btn_delphoto").click(function(){
		$('#perform_display').empty();
		$('#btn_delphoto').hide();
		$('#btn_getphoto').show();
		$('#perform_display').append($('<img id="performImg" style="width:100%; height:auto;" src="" />'));
	});
	
	//공연 홍보 사진쪽
	$("#btn_promote").click(function(){
		getPromotePhoto();
	});
	
	$("#btn_delpromote").click(function(){
		$('#perform_promote').empty();
		$('#btn_delpromote').hide();
		$('#btn_promote').show();
		$('#perform_promote').append($('<img id="promoteImg" style="width:100%; height:auto;" src="" />'));
	});
	
	//지도 제거
	$('#delete_map').click(function(){
		$('#mapArea').empty();
		$('#addrSearch').val("").focus();
		initAutocomplete();
	});
	
	$("#addrSearch").keyup(function(){
		
	});
	
	//지도
/*	$("#btnAddressSearch").click(function(){
		getMapAddress();
	});*/

	
});



function getArtistPhoto(){
	navigator.camera.getPicture(onPhotoURISuccess, onFail,
			{quality: 50, destinationType: Camera.DestinationType.FILE_URI,
			sourceType: Camera.PictureSourceType.PHOTOLIBRARY});
}

function onPhotoURISuccess(imageURI){
	$('#performImg').attr('src', imageURI);
	$('#btn_delphoto').show();
	$('#btn_getphoto').hide();

}

function getPromotePhoto(){
	navigator.camera.getPicture(onPhotoPromoteSuccess, onFail,
			{quality: 50, destinationType: Camera.DestinationType.FILE_URI,
			sourceType: Camera.PictureSourceType.PHOTOLIBRARY});	
}

function onPhotoPromoteSuccess(imageURI){
	$('#promoteImg').attr('src', imageURI);
	$('#btn_delpromote').show();
	$('#btn_promote').hide();	
}

function onFail(message){
	infoTxtBox('실패 : ' + message);
}

//지도 함수(오토컴플릿 모도)
function initMap(){
	var map = new google.maps.Map(document.getElementById('mapArea'));
	var input = document.getElementById('addrSearch');
	
	var autocomplete = new google.maps.places.Autocomplete(input);
	
	var infowindow = new google.maps.InfoWindow();
	var marker = new google.maps.Marker({
		map: map
	});
	marker.addListener('click', function() {
		infowindow.open(map, marker);
	});
	
	autocomplete.addListener('place_changed', function() {
		infowindow.close();
		var place = autocomplete.getPlace();
		if (!place.geometry) {
			return;
		}
		
		if (place.geometry.viewport) {
			map.fitBounds(place.geometry.viewport);
		} else {
			map.setCenter(place.geometry.location);
			map.setZoom(17);
		}
		
		marker.setPosition(place.geometry.location);
		marker.setVisible(true);
		
		infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
				place.formatted_address);
		infowindow.open(map, marker);
		
	});
}

//지도 함수(searchBox 모드)
function initAutocomplete(){
	
	var map = new google.maps.Map(document.getElementById('mapArea'));
	var input = document.getElementById('addrSearch');	
	
	var searchBox = new google.maps.places.SearchBox(input);
	
	var infowindow = new google.maps.InfoWindow();
	var marker = new google.maps.Marker({
		map: map
	});
	marker.addListener('click', function() {
		infowindow.open(map, marker);
	});
	
	searchBox.addListener('places_changed', function() {
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
			marker.setPosition(place.geometry.location);
			marker.setVisible(true);
			infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
					place.formatted_address);
			infowindow.open(map, marker);		
	    });
		
	 });
	
}