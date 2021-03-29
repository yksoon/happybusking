function go_esign_artist() {
    var remain_price = $('.btad_remain_price').text();

    if (remain_price != '0 원') {
        alert('잔여 공연비가 남아있습니다. 금액을 올바르게 입력 하세요.');
        return false;
    } else {
        loadPage('e_signature/e_signature_artist.jsp');
    }
}

// 주민번호 자리 최대값 제한
// function numberMaxLength(e) {
//     if (e.value.length > e.maxLength) {
//         e.value = e.value.slice(0, e.maxLength);
//     }
//     if (e.value.length < e.minLength) {
//         e.value = e.value.slice(0, e.minLength);
//     }
// }

function maxLengthCheck(object) {
    if (object.value.length > object.maxLength) {
        object.value = object.value.slice(0, object.maxLength);
    }
}

// 주소검색
function esa_open_execDaumPostcode(ID) {
    $("input, textarea").blur();
    console.log(ID);
    var element_layer = document.getElementById(ID);
    var page = $('.ui-page').attr('id');
    var basic_txt = "";
    setTimeout(function () {
        basic_txt = $('#esa_post_no').val();
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

                $('#esa_post_no').val(fullAddr);
                // $('#postcode').val(data.zonecode);

                // var nowpage = $('.ui-page').attr('id');
                // if (nowpage == 'perform_reg' || nowpage == 'buskingzone_reg' || nowpage == 'perform_request' || nowpage == 'pbi_write' || nowpage == 'test_kakaomap') {
                //     searchKakaoMap(addr);
                // }

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