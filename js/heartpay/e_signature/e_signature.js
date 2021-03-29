var signaturePad;
var business_no;
$(document).on('pageinit', '#e_signature', function () {
    var user_no = $('#user_no').val();
    console.log(user_no);

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/e_signature/get_business.jsp',
        data: {
            user_no: user_no
        },
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var BUSINESS_NO = $(this).find("BUSINESS_NO").text();
                var BUSINESS_REPRESENTIVE = $(this).find("BUSINESS_REPRESENTIVE").text();

                business_no = BUSINESS_NO;
                var business_no_1 = BUSINESS_NO.split('-')[0];
                var business_no_2 = BUSINESS_NO.split('-')[1];
                var business_no_3 = BUSINESS_NO.split('-')[2];

                $('#es_business_no_1').val(business_no_1);
                $('#es_business_no_2').val(business_no_2);
                $('#es_business_no_3').val(business_no_3);

                $('#es_owner_name_input').val(BUSINESS_REPRESENTIVE);

            }).promise().done(function () {
                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                $.ajax({
                    type: "GET",
                    cache: false,
                    url: '/service/e_signature/get_e_signature.jsp',
                    data: {
                        business_no: business_no
                    },
                    contentType: "application/xml; charset=utf-8",
                    dataType: "xml",
                    timeout: 30000,
                    success: function (data) {
                        console.log("abc");
                        var ROOT = $(data).find('ROOT');
                        var DATA = $(ROOT).find('DATA');

                        $(DATA).each(function (i) {
                            var SIGN = $(this).find("SIGN").text();
                            var cnt = $(this).find("cnt").text();
                            console.log('abcd');

                            if (cnt != 0) {
                                $('.es_sign_wrapper').empty();

                                var img =
                                    '<img id="es_sign_img" class="es_sign_img" src="' + SIGN + '"></img>';

                                $('.es_sign_wrapper').append(img);
                            } else {
                                var canvas = $("#esa_signature-pad")[0];
                                signaturePad = new SignaturePad(canvas, {
                                    backgroundColor: 'rgb(246, 246, 248)'
                                });

                                function resizeCanvas() {
                                    var ratio = Math.max(window.devicePixelRatio || 1, 1);

                                    canvas.width = canvas.offsetWidth * ratio;
                                    canvas.height = canvas.offsetHeight * ratio;
                                    canvas.getContext("2d").scale(ratio, ratio);

                                    signaturePad.clear();
                                }

                                window.onresize = resizeCanvas;
                                resizeCanvas();
                            }
                        }).promise().done(function () {
                            $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                        });
                    },//end success
                    error: function (xhr, message, errorThrown) {
                        //hideLoading();
                        console.log(xhr);
                        console.log(message);
                        console.log(errorThrown);
                    } // end error
                });
            });
        },//end success
        error: function (xhr, message, errorThrown) {
            //hideLoading();
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
        } // end error
    });
});

// 새로고침 버튼을 눌렀을 시
$(document).on('click', '#es_refresh', function () {
    var status = $('.es_sign_wrapper').children('img').length;

    if (status) {
        $('.es_sign_wrapper').empty();
        var canv =
            '<canvas id="es_signature-pad" class="es_signature-pad"></canvas>';
        $('.es_sign_wrapper').append(canv);

        // var canvas = document.getElementById('es_signature-pad');
        var canvas = $("#es_signature-pad")[0];
        signaturePad = new SignaturePad(canvas, {

        });

        // Adjust canvas coordinate space taking into account pixel ratio,
        // to make it look crisp on mobile devices.
        // This also causes canvas to be cleared.
        function resizeCanvas() {
            // When zoomed out to less than 100%, for some very strange reason,
            // some browsers report devicePixelRatio as less than 1
            // and only part of the canvas is cleared then.
            var ratio = Math.max(window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext("2d").scale(ratio, ratio);
            // signaturePad.clear(); // otherwise isEmpty() might return incorrect value
        }

        $(window).on("resize", function () {
            resizeCanvas();
        });
        resizeCanvas();
        // window.onresize = resizeCanvas;
        // resizeCanvas();          
    } else {
        signaturePad.clear();
    }

});

// 고용보험 사무위탁 동의 체크박스
$(document).on('change', '#es_delegation_chk', function () {
    // if (!$("input:checkbox[id='es_delegation_chk']").is(":checked")) {
    //     console.log("checked");
    // }
})


// 서명완료 버튼
$(document).on('click', '#es_footer', function () {
    var user_no = $('#user_no').val();
    var perform_no = sessionStorage.getItem('es_perform_no');
    var emp_sign;
    if (!$("input:checkbox[id='es_delegation_chk']").is(":checked")) {
        alert("'고용 보험 사무 위탁 위임' 동의 해주세요");
        return false;
    }
    var status = $('.es_sign_wrapper').children('img').length;
    if (status) {
        // alert("다음페이지 ㄱㄱㄱ");
        // console.log(perform_no);
        emp_sign = $('.es_sign_wrapper').children('img').attr("src");

        $.ajax({
            type: "POST",//url: "JSON/test.json",
            cache: false,
            url: '/service/e_contract/set_e_contract_owner.jsp',
            //data : data,
            data: {
                emp_sign: emp_sign,
                perform_no: perform_no,
                user_no: user_no
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
                // alert('저장 되었습니다.');

            }, // end success
            error: function (xhr, message, errorThrown) {
                alert('잠시후 다시 시도해주세요.');
                return;
                //hideLoading();
            }, // end error
            complete: function () {
                $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                location.replace("e_sign_contract_form.jsp");
            }
        });

    } else {
        if (signaturePad.isEmpty()) {
            return alert("서명을 해주세요.");
        } else {
            var data = signaturePad.toDataURL('image/png');
            // console.log(typeof (data));
            emp_sign = data;

            if (emp_sign == "data:,") {
                return alert("서명을 해주세요.");
            } else {
                console.log(business_no);
                var sign_employer = $('#es_owner_name_input').val();
                console.log(sign_employer);
                console.log(emp_sign);

                if (status) {
                    // alert("다음페이지로 ㄱㄱㄱㄱ")

                    $.ajax({
                        type: "POST",//url: "JSON/test.json",
                        cache: false,
                        url: '/service/e_contract/set_e_contract_owner.jsp',
                        //data : data,
                        data: {
                            emp_sign: emp_sign,
                            perform_no: perform_no,
                            user_no: user_no
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
                            // alert('저장 되었습니다.');


                        }, // end success
                        error: function (xhr, message, errorThrown) {
                            alert('잠시후 다시 시도해주세요.');
                            return;
                            //hideLoading();
                        }, // end error
                        complete: function () {
                            $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                            location.replace("e_sign_contract_form.jsp");
                        }
                    });

                } else {
                    $.ajax({
                        type: "GET",
                        cache: false,
                        url: '/service/e_signature/get_e_signature.jsp',
                        data: {
                            business_no: business_no
                        },
                        contentType: "application/xml; charset=utf-8",
                        dataType: "xml",
                        timeout: 30000,
                        success: function (data) {
                            console.log("abc");
                            var ROOT = $(data).find('ROOT');
                            var DATA = $(ROOT).find('DATA');

                            $(DATA).each(function (i) {
                                var SIGN = $(this).find("SIGN").text();
                                var cnt = $(this).find("cnt").text();
                                console.log('abcd');

                                var data = signaturePad.toDataURL('image/png');
                                // console.log(typeof (data));
                                var image = data;
                                if (cnt != 0) {
                                    es_mod_sign(image, business_no);
                                } else {
                                    es_set_sign(image, business_no, sign_employer);
                                }
                            }).promise().done(function () {
                                $.mobile.loading('hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
                            });
                        },//end success
                        error: function (xhr, message, errorThrown) {
                            //hideLoading();
                            console.log(xhr);
                            console.log(message);
                            console.log(errorThrown);
                        }, // end error
                        complete: function () {
                            $.ajax({
                                type: "POST",//url: "JSON/test.json",
                                cache: false,
                                url: '/service/e_contract/set_e_contract_owner.jsp',
                                //data : data,
                                data: {
                                    emp_sign: emp_sign,
                                    perform_no: perform_no,
                                    user_no: user_no
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
                                    // alert('저장 되었습니다.');


                                }, // end success
                                error: function (xhr, message, errorThrown) {
                                    alert('잠시후 다시 시도해주세요.');
                                    return;
                                    //hideLoading();
                                }, // end error
                                complete: function () {
                                    $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
                                    location.replace("e_sign_contract_form.jsp");
                                }
                            });
                        }
                    });
                }
            }
        }
    }

});


$(document).on('click', '#esco_confirm_list_btn', function () {
    loadPage('busking_time_contract/busking_time_contract_list.jsp');
})



