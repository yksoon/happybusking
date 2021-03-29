//현재 위치 GPS 가져오기
function get_getlocation() {
	 function onSuccess(position) {
        /*var element = document.getElementById('geolocation');*/
        
        /*element.innerHTML = 'Latitude: '           + position.coords.latitude              + '<br />' +
                            'Longitude: '          + position.coords.longitude             + '<br />' +
                            'Altitude: '           + position.coords.altitude              + '<br />' +
                            'Accuracy: '           + position.coords.accuracy              + '<br />' +
                            'Altitude Accuracy: '  + position.coords.altitudeAccuracy      + '<br />' +
                            'Heading: '            + position.coords.heading               + '<br />' +
                            'Speed: '              + position.coords.speed                 + '<br />' +
                            'Timestamp: '          + position.timestamp                    + '<br />';*/
    }

    // onError Callback receives a PositionError object
    //
    function onError(error) {
        infoTxtBox('code: '    + error.code    + '\n' +
              'message: ' + error.message + '\n');
    }

	navigator.geolocation.getCurrentPosition(onSuccess, onError);
}