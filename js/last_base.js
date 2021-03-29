new daum.Postcode({
    onclose: function (state) {
        if (state === 'FORCE_CLOSE') {
            infoTxtBox('닫기');
        } else if (state === 'COMPLETE_CLOSE') {
            infoTxtBox('검색');
        }
    }
});

//카카오 지도 불러오기
function getKakaoMap(x, y) {
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

//주소 검색 시 지도 설정
function searchKakaoMap(addr) {
    $('#map').empty();

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng('0', '0'), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    //결과 값으로 받은 위치를 마커로 표시
    var marker = new kakao.maps.Marker({
        map: map,
        position: map.getCenter()
    });
    marker.setMap(map);

    var geocoder = new kakao.maps.services.Geocoder();

    //주소료 좌표를 검색
    geocoder.addressSearch(addr, function (result, status) {
        //정상적으로 검색이 완료
        if (status == kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // console.log(coords);
            // alert(coords);

            marker.setPosition(coords);
            //지도의 중심을 결과값으로 받은 위치로 이동
            map.setCenter(coords);

            $('#latlng').val(result[0].x + ',' + result[0].y);
        } else {
            alert('좌표값을 찾을 수 없는 주소입니다.\n해당 메시지가 지속적으로 발생할 경우 해피버스킹에 문의 부탁드립니다.');
            return;
        }
    });

    // 지도 클릭 이벤트 
    kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
        mapClickEvent(mouseEvent, marker);
    });
}

//지도 클릭 이벤트 묶어주기
function mapClickEvent(mouseEvent, marker) {// 클릭시 위도, 경도 값 가져오기.
    var nowpage = $('.ui-page').attr('id');
    if (nowpage == 'detail_perform' || nowpage == 'perform_request_detail') {
        return;
    }


    var latlng = mouseEvent.latLng;

    // 마커 위치를 클릭한 위치로 이동
    marker.setPosition(latlng);

    //페이지별로 좌표값 hidden값으로 넣어줘야함.
    $('#latlng').val(latlng.getLng() + ',' + latlng.getLat());

    //클릭된 장소 주소 불러오기
    //페이지별로 주소값 input에 넣어줘야함.
    searchDetailAddrFromCoords(latlng, function (result, status) {
        if (status == kakao.maps.services.Status.OK) {
            var addr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
            $('#address').val(addr);
        } else {
            alert('선택한 부분의 주소를 불러올 수 없습니다.\n해당 메시지가 지속적으로 발생할 경우 해피버스킹에 문의 부탁드립니다.');
        }
    });
}

// 좌표로 주소값 가져오기
function searchDetailAddrFromCoords(coords, callback) {
    var geocoder = new kakao.maps.services.Geocoder();
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

function closeDaumPostcode(ID) {
    var element_layer = document.getElementById(ID);
    var page = $('.ui-page').attr('id');
    if (page == "supply_item_request") {
        $('#rq_supply_postcode').removeAttr("readonly");
        $('#rq_supply_addr').removeAttr("readonly");
        $('#rq_supply_postcode').val("");
        $('#rq_supply_addr').val("");
    } else if (page == "qrcode_request") {
        $('#qrRequest_postcode').removeAttr("readonly");
        $('#qrRequest_addr').removeAttr("readonly");
        $('#qrRequest_postcode').val("");
        $('#qrRequest_addr').val("");
    } else if (page == "perform_request") {
        $('#perform_rq_addr').removeAttr("readonly");
        $('#qrRequest_addr').removeAttr("readonly");
        $('#perform_rq_postcode').val("");
        $('#perform_rq_addr').val("");
    }
    element_layer.style.display = 'none';
}

function open_execDaumPostcode(ID) {
    $("input, textarea").blur();
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
        initLayerPosition(ID);
    }, 500);
}

function initLayerPosition(ID) {
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