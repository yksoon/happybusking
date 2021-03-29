// 전자서명 새로 등록
function es_set_sign(image, business_no, sign_employer) {
    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/e_signature/set_e_signature.jsp',
        //data : data,
        data: {
            image: image,
            business_no: business_no,
            sign_employer: sign_employer
        },
        dataType: "xml",
        async: false,
        timeout: 30000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find("ROOT");
            var DATA = $(ROOT).find('DATA');
            if (DATA.length == 0) {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                return;
            }
            alert('저장 되었습니다.');
            signaturePad.clear();
        }, // end success
        error: function (xhr, message, errorThrown) {
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        }
    });
}

// 전자서명 수정
function es_mod_sign(image, business_no) {
    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/e_signature/mod_e_signature.jsp',
        //data : data,
        data: {
            image: image,
            business_no: business_no,
        },
        dataType: "xml",
        async: false,
        timeout: 30000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find("ROOT");
            var DATA = $(ROOT).find('DATA');
            if (DATA.length == 0) {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                return;
            }
            alert('저장 되었습니다.');
            signaturePad.clear();
        }, // end success
        error: function (xhr, message, errorThrown) {
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        }
    });
}

function go_esign_owner() {
    var chk = $(".btad_btn_container span").text()
    var findString = "서명 요청";

    if (chk.indexOf(findString) != -1) {
        $('#custom_btad_popup').load('/app_root/jsp/custom_select_box/custom_busking_time_apply_detail.jsp', function () {
            $("html, body").css({ "overflow": "hidden", "height": "100%" });

            $('#custom_btad_popup').show();

            $('#header').hide();
            $('#footer').hide();
        });
    } else {
        // console.log($(".btad_btn_container span").text());
        loadPage('e_signature/e_signature.jsp');
    }


    // console.log($(".btad_btn_container span").text());
    // loadPage('e_signature/e_signature.jsp');
}

function close_btad_popup() {
    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#custom_btad_popup').unbind('touchmove');

    $('#custom_btad_popup').hide();

    $('#header').show();
    $('#footer').show();
}