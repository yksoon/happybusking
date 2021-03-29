// $(document).on('pageinit', '#test_kakaomap', function () {
//     $('#test_kakaomap_content').textinput("option", "autogrow", false);
// });

// 페이지 이동
function go_test_kakaomap() {
    loadPage('test_1214/test_kakaomap.jsp');
}

// 페이지 처음 로드시 지도 뿌려줌
$(document).on('pageshow', '#test_kakaomap', function () {
    test_getKakaoMap('37.6547557', '127.0605938');
});

// 카카오 지도 불러오기
function test_getKakaoMap(x, y) {
    $('#map').empty();

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(x, y), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    //지도를 클릭한 위치에 표출할 마커
    var marker = new kakao.maps.Marker({
        // 초기에는 지도 중심부에 마커 생성
        position: map.getCenter()
    });
    marker.setMap(map);

    // 지도 클릭 이벤트 
    kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
        mapClickEvent(mouseEvent, marker);
    });
}

// 주소검색
function test_open_execDaumPostcode(ID) {
    $("input, textarea").blur();
    console.log(ID);
    var element_layer = document.getElementById(ID);
    var page = $('.ui-page').attr('id');
    var basic_txt = "";
    setTimeout(function () {
        basic_txt = $('#address').val();
        new daum.Postcode({
            oncomplete: function (data) {
                var addr = data.address;
                var fullAddr = data.address;
                var extraAddr = '';
                if (data.addressType === 'R') {
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }
                //data.zonecode

                $('#address').val(fullAddr);
                $('#postcode').val(data.zonecode);

                var nowpage = $('.ui-page').attr('id');
                if (nowpage == 'perform_reg' || nowpage == 'buskingzone_reg' || nowpage == 'perform_request' || nowpage == 'pbi_write' || nowpage == 'test_kakaomap') {
                    searchKakaoMap(addr);
                }

                element_layer.style.display = 'none';
            },
            width: '100%',
            height: '100%',
            maxSuggestItems: 5,
        }).embed(element_layer, {
            q: basic_txt
        });
        element_layer.style.display = 'block';
        test_initLayerPosition(ID);
    }, 500);
}

// 주소검색 팝업 레이어
function test_initLayerPosition(ID) {
    var element_layer = document.getElementById(ID);
    var width = 300;
    var height = 400;
    var borderWidth = 5;
    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px';
    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px';
}

// 길찾기
$(document).on('click', '.test_getdirection_btn', function () {

    // var place = document.getElementById('#address');
    // var latlng = document.getElementById('#latlng');

    var place = $('#address').val();
    var latlng = $('#latlng').val();

    console.log(place);
    console.log(latlng);

    var x = latlng.split(',')[1];
    var y = latlng.split(',')[0];
    load_search2(place, x, y);
});

// 길찾기 -> 카카오맵 이동
function load_search2(place, x, y) {
    console.log(place);
    //var url = 'http://map.daum.net/link/to/' + place + ',' + y +','+ x + '&new';
    //window.open = cordova.InAppBrowser.open;

    // url 생성을 위한 장소명 가공
    place = place.replace(/ /g, '');
    place = place.replace(',', '')
    var url = 'https://map.kakao.com/link/to/' + place + ',' + x + ',' + y;

    console.log(url);
    console.log(navigator.userAgent);
    console.log(navigator.userAgent.match(/iPhone|iPod|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i));
    //window.open(url, '_blank', 'location=yes,usewkwebview=yes');
    //var ref = cordova.InAppBrowser.open(encodeURI(url), '_blank', 'location=yes');
    // var ref = cordova.InAppBrowser.open(url, '_system', 'location=yes');
    // ref;

    // 웹 브라우저(크롬) 접속시
    if (navigator.userAgent.match(/iPhone|iPod|iPad|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null ||
        navigator.userAgent.match(/LG|SAMSUNG|Samsung/) != null) {
        window.open(url);
    } else {    // 앱(웹뷰)으로 접속시
        var ref = cordova.InAppBrowser.open(url, '_system', 'location=yes');
        ref;
    }
}