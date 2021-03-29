var contract_img_1;
// var contract_img_2;
// var contract_img_3;
// var contract_img_4;
// var contract_pdf_1;
var contract_pdf_1 = new FormData();

$(document).on('ready', function () {
    var contract_img = [];
    var perform_no = sessionStorage.getItem('es_con_perform_no');

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/e_signature/get_e_contract_form.jsp',
        data: {
            perform_no: perform_no
        },
        async: false,
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 30000,
        beforeSend: function () {
            // $.mobile.loading('show', { text: '계약서 작성중', textVisible: true, theme: 'a', html: "" });
            $("html, body").css({ "overflow": "hidden", "height": "100%" });
            showLoadingBar()
        },
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            async function qweqwe() {

                for (var t = 0; t < DATA.length; t++) {
                    var CONTRACT_NO = DATA[t].getElementsByTagName("CONTRACT_NO")[0].innerHTML;
                    var CONTRACT_EMPLOYER = DATA[t].getElementsByTagName("CONTRACT_EMPLOYER")[0].innerHTML;
                    var CONTRACT_ARTIST = DATA[t].getElementsByTagName("CONTRACT_ARTIST")[0].innerHTML;
                    var BUSINESS_WORKNAME = DATA[t].getElementsByTagName("BUSINESS_WORKNAME")[0].innerHTML;
                    var BUSKINGDATE = DATA[t].getElementsByTagName("BUSKINGDATE")[0].innerHTML;
                    var ADDRESS = DATA[t].getElementsByTagName("ADDRESS")[0].innerHTML;
                    var STARTINGTIME = DATA[t].getElementsByTagName("STARTINGTIME")[0].innerHTML;
                    var FINISHINGTIME = DATA[t].getElementsByTagName("FINISHINGTIME")[0].innerHTML;
                    var CONTRACT_PRICE = DATA[t].getElementsByTagName("CONTRACT_PRICE")[0].innerHTML;
                    var ART_BANK_NAME = DATA[t].getElementsByTagName("ART_BANK_NAME")[0].innerHTML;
                    var ART_BANK_NUMBER = DATA[t].getElementsByTagName("ART_BANK_NUMBER")[0].innerHTML;
                    var ART_BANK_USER = DATA[t].getElementsByTagName("ART_BANK_USER")[0].innerHTML;
                    var CONTRACT_DATE = DATA[t].getElementsByTagName("CONTRACT_DATE")[0].innerHTML;
                    var CONTRACT_RESIDENT_REG_NUM = DATA[t].getElementsByTagName("CONTRACT_RESIDENT_REG_NUM")[0].innerHTML;
                    var CONTRACT_ARTIST_ADDR = DATA[t].getElementsByTagName("CONTRACT_ARTIST_ADDR")[0].innerHTML;
                    var EMP_SIGN = DATA[t].getElementsByTagName("EMP_SIGN")[0].innerHTML;
                    var ARTIST_SIGN = DATA[t].getElementsByTagName("ARTIST_SIGN")[0].innerHTML;
                    var PERFORM_MIN = DATA[t].getElementsByTagName("PERFORM_MIN")[0].innerHTML;

                    $('#contract_no').val(CONTRACT_NO);
                    ////////////////////////form 1
                    $('#form_1_ownerName').val(CONTRACT_EMPLOYER);
                    $('#form_1_artistName').val(CONTRACT_ARTIST);
                    $('#form_1_performName').val(BUSINESS_WORKNAME + " 공연");

                    var busking_date = BUSKINGDATE.split('-');
                    var busking_date_year = busking_date[0];
                    var busking_date_month = busking_date[1];
                    var busking_date_day = busking_date[2];
                    $('#form_1_performStartYear').val(busking_date_year);
                    $('#form_1_performStartMonth').val(busking_date_month);
                    $('#form_1_performStartDay').val(busking_date_day);
                    $('#form_1_performEndYear').val(busking_date_year);
                    $('#form_1_performEndMonth').val(busking_date_month);
                    $('#form_1_performEndDay').val(busking_date_day);

                    $('#form_1_performAdress').val(ADDRESS);

                    var perform_starting_time = STARTINGTIME.split(':');
                    var perform_starting_time_hour = perform_starting_time[0];
                    var perform_starting_time_min = perform_starting_time[1];
                    $('#form_1_performStartHour').val(perform_starting_time_hour);
                    $('#form_1_performStartMin').val(perform_starting_time_min);

                    var perform_finishing_time = FINISHINGTIME.split(':');
                    var perform_finishing_time_hour = perform_finishing_time[0];
                    var perform_finishing_time_min = perform_finishing_time[1];
                    $('#form_1_performEndHour').val(perform_finishing_time_hour);
                    $('#form_1_performEndMin').val(perform_finishing_time_min);

                    $('#form_1_perform_Min').val(PERFORM_MIN);

                    // $('#form_1_contractStartYear').val(busking_date_year);
                    // $('#form_1_contractStartMonth').val(busking_date_month);
                    // $('#form_1_contractStartDay').val(busking_date_day);
                    // $('#form_1_contractEndYear').val(busking_date_year);
                    // $('#form_1_contractEndMonth').val(busking_date_month);
                    // $('#form_1_contractEndDay').val(busking_date_day);

                    var contract_price = CONTRACT_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
                    $('#form_1_personalPrice').val(contract_price);

                    $('#form_1_bankName').val(ART_BANK_NAME);
                    $('#form_1_bankNumber').val(ART_BANK_NUMBER);
                    $('#form_1_bankArtistName').val(ART_BANK_USER);
                    ////////////////////////form 1 END

                    ////////////////////////form 4
                    var contract_date = CONTRACT_DATE.split('-');
                    var contract_date_year = contract_date[0];
                    var contract_date_month = contract_date[1];
                    var contract_date_day = contract_date[2];
                    $('#form_4_contractDateYear').val(contract_date_year);
                    $('#form_4_contractDateMonth').val(contract_date_month);
                    $('#form_4_contractDateDay').val(contract_date_day);

                    $('#form_4_ownerName').val(CONTRACT_EMPLOYER);
                    $('#form_4_storeName').val(BUSINESS_WORKNAME);
                    $('#form_4_storeAdress').text(ADDRESS);

                    $('#form_4_artistName').val(CONTRACT_ARTIST);

                    var artist_birth = CONTRACT_RESIDENT_REG_NUM.split('-');
                    artist_birth = artist_birth[0]
                    var artist_birth_sec = CONTRACT_RESIDENT_REG_NUM.split('-');
                    artist_birth_sec = artist_birth_sec[1].substr(0, 1)

                    //console.log(artist_birth_sec, typeof (artist_birth_sec));
                    var artist_birth_year = "";
                    if (artist_birth_sec === '1' || artist_birth_sec === '2') {
                        artist_birth_year = '19' + artist_birth.substr(0, 2);
                        //console.log("1900년대생");
                    }
                    else if (artist_birth_sec === '3' || artist_birth_sec === '4') {
                        artist_birth_year = '20' + artist_birth.substr(0, 2);
                        //console.log("2000년대생");
                    }
                    //console.log(artist_birth_year);
                    var artist_birth_month = artist_birth.substr(2, 2);
                    if (artist_birth_month.substr(0, 1) == '0') {
                        artist_birth_month = artist_birth_month.substr(1, 1);
                    }
                    var artist_birth_day = artist_birth.substr(4, 2);
                    if (artist_birth_day.substr(0, 1) == '0') {
                        artist_birth_day = artist_birth_day.substr(1, 1);
                    }
                    var artist_birth_2 = artist_birth_year + "년 " + artist_birth_month + "월 " + artist_birth_day + "일";
                    $('#form_4_artistBirth').val(artist_birth_2);

                    $('#form_4_artistAdress').text(CONTRACT_ARTIST_ADDR);

                    $('#es_con_owner_sign').attr('src', EMP_SIGN);
                    $('#es_con_artist_sign').attr('src', ARTIST_SIGN);
                    //console.log(CONTRACT_NO2);
                    //console.log(CONTRACT_EMPLOYER2);
                    //console.log(CONTRACT_ARTIST2);
                    //console.log(t);
                    await es_con_screenshot_canvas();

                    // console.log($('#test_1').attr('src'));
                }
                $("html, body").css({ "overflow": "auto", "height": "auto" });
                hideLoadingBar();


                $.ajax({
                    type: "POST",//url: "JSON/test.json",
                    cache: false,
                    url: '/service/push_perform_contract/art_complete_contract.jsp',
                    //data : data,
                    data: {
                        perform_no: perform_no
                    },
                    async: false,
                    dataType: "xml",
                    timeout: 30000,
                    success: function (data) {
                        // console.log("여기까지 옴");
                    }
                })

                location.replace("e_sign_complete_owner.jsp");
            }

            qweqwe();



            // $(DATA).each(function (i) {



            // 	//console.log("i" + i);
            // 	//delay(i);

            // 	$('#ttttttt').text(i);

            // 	//console.log($(this));

            // 	var CONTRACT_NO = $(this).find("CONTRACT_NO").text();

            // 	//console.log(CONTRACT_NO);

            // 	var CONTRACT_EMPLOYER = $(this).find("CONTRACT_EMPLOYER").text();
            // 	var CONTRACT_ARTIST = $(this).find("CONTRACT_ARTIST").text();
            // 	var BUSINESS_WORKNAME = $(this).find("BUSINESS_WORKNAME").text();
            // 	var BUSKINGDATE = $(this).find("BUSKINGDATE").text();
            // 	var ADDRESS = $(this).find("ADDRESS").text();
            // 	var STARTINGTIME = $(this).find("STARTINGTIME").text();
            // 	var FINISHINGTIME = $(this).find("FINISHINGTIME").text();
            // 	var CONTRACT_PRICE = $(this).find("CONTRACT_PRICE").text();
            // 	var ART_BANK_NAME = $(this).find("ART_BANK_NAME").text();
            // 	var ART_BANK_NUMBER = $(this).find("ART_BANK_NUMBER").text();
            // 	var ART_BANK_USER = $(this).find("ART_BANK_USER").text();
            // 	var CONTRACT_DATE = $(this).find("CONTRACT_DATE").text();
            // 	var CONTRACT_RESIDENT_REG_NUM = $(this).find("CONTRACT_RESIDENT_REG_NUM").text();
            // 	var CONTRACT_ARTIST_ADDR = $(this).find("CONTRACT_ARTIST_ADDR").text();
            // 	var EMP_SIGN = $(this).find("EMP_SIGN").text();
            // 	var ARTIST_SIGN = $(this).find("ARTIST_SIGN").text();
            // 	$('#contract_no').val(CONTRACT_NO);
            // 	////////////////////////form 1
            // 	$('#form_1_ownerName').val(CONTRACT_EMPLOYER);
            // 	//$('#form_1_artistName').val(CONTRACT_ARTIST);
            // 	$('#form_1_performName').val(BUSINESS_WORKNAME + " 공연");

            // 	var busking_date = BUSKINGDATE.split('-');
            // 	var busking_date_year = busking_date[0];
            // 	var busking_date_month = busking_date[1];
            // 	var busking_date_day = busking_date[2];
            // 	$('#form_1_performStartYear').val(busking_date_year);
            // 	$('#form_1_performStartMonth').val(busking_date_month);
            // 	$('#form_1_performStartDay').val(busking_date_day);
            // 	$('#form_1_performEndYear').val(busking_date_year);
            // 	$('#form_1_performEndMonth').val(busking_date_month);
            // 	$('#form_1_performEndDay').val(busking_date_day);

            // 	$('#form_1_performAdress').val(ADDRESS);

            // 	var perform_starting_time = STARTINGTIME.split(':');
            // 	var perform_starting_time_hour = perform_starting_time[0];
            // 	var perform_starting_time_min = perform_starting_time[1];
            // 	$('#form_1_performStartHour').val(perform_starting_time_hour);
            // 	$('#form_1_performStartMin').val(perform_starting_time_min);

            // 	var perform_finishing_time = FINISHINGTIME.split(':');
            // 	var perform_finishing_time_hour = perform_finishing_time[0];
            // 	var perform_finishing_time_min = perform_finishing_time[1];
            // 	$('#form_1_performEndHour').val(perform_finishing_time_hour);
            // 	$('#form_1_performEndMin').val(perform_finishing_time_min);

            // 	$('#form_1_contractStartYear').val(busking_date_year);
            // 	$('#form_1_contractStartMonth').val(busking_date_month);
            // 	$('#form_1_contractStartDay').val(busking_date_day);
            // 	$('#form_1_contractEndYear').val(busking_date_year);
            // 	$('#form_1_contractEndMonth').val(busking_date_month);
            // 	$('#form_1_contractEndDay').val(busking_date_day);

            // 	var contract_price = CONTRACT_PRICE.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가 
            // 	$('#form_1_personalPrice').val(contract_price);

            // 	$('#form_1_bankName').val(ART_BANK_NAME);
            // 	$('#form_1_bankNumber').val(ART_BANK_NUMBER);
            // 	$('#form_1_bankArtistName').val(ART_BANK_USER);
            // 	////////////////////////form 1 END

            // 	////////////////////////form 4
            // 	var contract_date = CONTRACT_DATE.split('-');
            // 	var contract_date_year = contract_date[0];
            // 	var contract_date_month = contract_date[1];
            // 	var contract_date_day = contract_date[2];
            // 	$('#form_4_contractDateYear').val(contract_date_year);
            // 	$('#form_4_contractDateMonth').val(contract_date_month);
            // 	$('#form_4_contractDateDay').val(contract_date_day);

            // 	$('#form_4_ownerName').val(CONTRACT_EMPLOYER);
            // 	$('#form_4_storeName').val(BUSINESS_WORKNAME);
            // 	$('#form_4_storeAdress').text(ADDRESS);

            // 	$('#form_4_artistName').val(CONTRACT_ARTIST);

            // 	var artist_birth = CONTRACT_RESIDENT_REG_NUM.split('-');
            // 	artist_birth = artist_birth[0]
            // 	var artist_birth_sec = CONTRACT_RESIDENT_REG_NUM.split('-');
            // 	artist_birth_sec = artist_birth_sec[1].substr(0, 1)

            // 	//console.log(artist_birth_sec, typeof (artist_birth_sec));
            // 	var artist_birth_year = "";
            // 	if (artist_birth_sec === '1' || artist_birth_sec === '2') {
            // 		artist_birth_year = '19' + artist_birth.substr(0, 2);
            // 		//console.log("1900년대생");
            // 	}
            // 	else if (artist_birth_sec === '3' || artist_birth_sec === '4') {
            // 		artist_birth_year = '20' + artist_birth.substr(0, 2);
            // 		//console.log("2000년대생");
            // 	}
            // 	//console.log(artist_birth_year);
            // 	var artist_birth_month = artist_birth.substr(2, 2);
            // 	if (artist_birth_month.substr(0, 1) == '0') {
            // 		artist_birth_month = artist_birth_month.substr(1, 1);
            // 	}
            // 	var artist_birth_day = artist_birth.substr(4, 2);
            // 	if (artist_birth_day.substr(0, 1) == '0') {
            // 		artist_birth_day = artist_birth_day.substr(1, 1);
            // 	}
            // 	var artist_birth_2 = artist_birth_year + "년 " + artist_birth_month + "월 " + artist_birth_day + "일";
            // 	$('#form_4_artistBirth').val(artist_birth_2);

            // 	$('#form_4_artistAdress').text(CONTRACT_ARTIST_ADDR);

            // 	$('#es_con_owner_sign').attr('src', EMP_SIGN);
            // 	$('#es_con_artist_sign').attr('src', ARTIST_SIGN);

            // 	//await es_con_screenshot_canvas(i);
            // 	//await es_con_screenshot_canvas();

            // 	//console.log($('#form_1_artistName').val());
            // 	//console.log(i + "번 완료");



            // })

            //async function test() {
            //	for(var z=0;z<2;z++){
            //			await es_con_screenshot_canvas();
            //	}
            //}




            //es_con_screenshot_canvas();
            //.promise().then(function () {
            //console.log("완");
            // es_con_screenshot_canvas();
            // location.href = "e_sign_complete_owner.jsp";
            //});
        },
        complete: function () {
            // $.mobile.loading('hide', { text: '계약서 작성중', textVisible: true, theme: 'a', html: "" });
            // location.href = "e_sign_complete_owner.jsp";
        }
    });




    /*
    function delay(item) {
          return new Promise(function(resolve, reject){
            setTimeout(function(){
              console.log(item);
              resolve();
            },1000)
          })
    }
    function qwe(i){
        for(var z=0;z<3;z++){
            console.log(z);
        }
    }
    */
});



async function es_con_screenshot_canvas() {
    // var contract_img_1;

    //return new Promise((resolve,reject)=>{
    //	setTimeout(function(){
    await html2canvas($('#es_con_form_1')[0], {
        scale: 2.5,
    }).then(function (canvas) {
        var myImage = canvas.toDataURL('image/png');

        $('#test_1').attr('src', myImage);
        console.log("1111111111");
        contract_img_1 = myImage;



        return html2canvas($('#es_con_form_1')[0], {
        });
    }).then(function (canvas) {
        var myImage = canvas.toDataURL('image/png');
        var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
        var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
        var imgHeight = canvas.height * imgWidth / canvas.width;
        var heightLeft = imgHeight;
        var margin = 10; // 출력 페이지 여백설정
        var doc = new jsPDF('p', 'mm');
        var position = 0;

        doc.addImage(myImage, 'PNG', margin, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;

        // var blob = doc.output();

        // var contract_pdf_1 = new FormData();
        // contract_pdf_1.append('pdf', blob);

        // doc.save('file-name.pdf');
    }).then(function () {
        set_contract(contract_img_1);
        // set_contract_pdf(contract_pdf_1);
        //console.log("완료완료");
        // downloadURI(contract_img_1, "저장이미지이름.png");
    });

    //		resolve();
    //	},1000)
    //});

}

// async function es_con_screenshot_canvas() {
//     // var contract_img_1;
//     // var contract_img_2;
//     // var contract_img_3;
//     // var contract_img_4;
//     //return new Promise((resolve,reject)=>{
//     //	setTimeout(function(){
//     await html2canvas($('#es_con_form_1')[0], {
//         scale: 2.5,
//     }).then(function (canvas) {
//         var myImage = canvas.toDataURL('image/png');
//         $('#test_1').attr('src', myImage);
//         console.log("1111111111");
//         contract_img_1 = myImage;

//         return html2canvas($('#es_con_form_2')[0], {
//             scale: 2.5,
//         });
//     }).then(function (canvas) {
//         var myImage = canvas.toDataURL('image/png');
//         $('#test_2').attr('src', myImage);
//         console.log("222222222");
//         contract_img_2 = myImage;

//         return html2canvas($('#es_con_form_3')[0], {
//             scale: 2.5,
//         });
//     }).then(function (canvas) {
//         var myImage = canvas.toDataURL('image/png');
//         $('#test_3').attr('src', myImage);
//         console.log("333333333");
//         contract_img_3 = myImage;

//         return html2canvas($('#es_con_form_4')[0], {
//             scale: 2.5,
//         });
//     }).then(function (canvas) {
//         var myImage = canvas.toDataURL('image/png');
//         $('#test_4').attr('src', myImage);
//         console.log("444444444");
//         contract_img_4 = myImage;
//     }).then(function () {
//         set_contract(contract_img_1, contract_img_2, contract_img_3, contract_img_4)
//         //console.log("완료완료");
//         // downloadURI(contract_img_1, "저장이미지이름.png");
//         // downloadURI(contract_img_2, "저장이미지이름.png");
//         // downloadURI(contract_img_3, "저장이미지이름.png");
//         // downloadURI(contract_img_4, "저장이미지이름.png");
//     });

//     //		resolve();
//     //	},1000)
//     //});

// }









// // 테스트 DB에서 잘 뽑아오는지......
// $(document).on('click', '#es_con_save', function () {
//     // PrintDiv($('#es_con_form_1'));
//     // for (i = 1; i <= 4; i++) {
//     //     PrintDiv($('#es_con_form_' + i), i);
//     // }
//     $.ajax({
//         type: "GET",
//         cache: false,
//         url: '/service/e_signature/get_e_contract_form_final.jsp',
//         data: {
//             // perform_no: perform_no,
//             // user_no: user_no
//         },
//         contentType: "application/xml; charset=utf-8",
//         dataType: "xml",
//         timeout: 30000,
//         success: function (data) {
//             var ROOT = $(data).find('ROOT');
//             var DATA = $(ROOT).find('DATA');

//             $(DATA).each(function (i) {
//                 var CONTRACT_1 = $(this).find("CONTRACT_1").text();
//                 var CONTRACT_2 = $(this).find("CONTRACT_2").text();
//                 var CONTRACT_3 = $(this).find("CONTRACT_3").text();
//                 var CONTRACT_4 = $(this).find("CONTRACT_4").text();

//                 $('#test_11').attr('src', CONTRACT_1);
//                 $('#test_22').attr('src', CONTRACT_4);

//             })
//         }

//     })
// });

function PrintDiv(div, i) {
    var target = div[0];

    html2canvas(target, {
        scale: 2.5,
    }).then(function (canvas) {
        var myImage = canvas.toDataURL('image/png');
        //console.log(div);
        // console.log(myImage);
        // downloadURI(myImage, "저장이미지이름.png");
        $('#test_' + i).attr('src', myImage);
    });
    // var contract_img_1 = $('#test_1').attr('src');
    // var contract_img_2 = $('#test_2').attr('src');
    // var contract_img_3 = $('#test_3').attr('src');
    // var contract_img_4 = $('#test_4').attr('src');

    // console.log(contract_img_1);
}

function downloadURI(uri, name) {
    var link = document.createElement("a")
    link.download = name;
    link.href = uri;
    document.body.appendChild(link);
    link.click();
}

// DB에 계약서 등록되는 함수
function set_contract(img_1) {
    var contract_no = $('#contract_no').val();
    var contract_img_1 = img_1;
    var perform_no = sessionStorage.getItem('es_con_perform_no');

    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/e_signature/set_e_contract_form.jsp',
        async: false,
        data: {
            contract_no: contract_no,
            contract_img_1: contract_img_1,
            perform_no, perform_no
        },
        dataType: "xml",
        timeout: 30000,
        beforeSend: function () {
            // $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find("ROOT");
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                // var msg = $(this).find("MESSAGE").text();

                // alert(msg);
            });
            // 

        }, // end success
        error: function (xhr, message, errorThrown) {
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
            // alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            // loadPage('e_signature/e_sign_complete_owner.jsp');
        }
    });
}

function set_contract_pdf(pdf_1) {
    var contract_no = $('#contract_no').val();
    var contract_pdf_1 = pdf_1;

    $.ajax({
        // type: "POST",//url: "JSON/test.json",
        method: 'POST',
        cache: false,
        url: '/service/e_signature/upload_contract_pdf.jsp',
        async: false,
        data: contract_pdf_1,
        //dataType: "json",
        timeout: 30000,
        processData: false,
        contentType: false,
        beforeSend: function () {
            // $.mobile.loading('show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
        },
        success: function (i) {



        }, // end success
        error: function (xhr, message, errorThrown) {
            console.log(xhr);
            console.log(message);
            console.log(errorThrown);
            // alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            // $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            // loadPage('e_signature/e_sign_complete_owner.jsp');
        }
    });
}



// 로딩바
function showLoadingBar() {
    var maskHeight = $(document).height();
    var maskWidth = window.document.body.clientWidth;

    var mask = "<div id='mask' style='position:absolute; z-index:9000; display:none; left:0; top:0;'></div>";
    var loadingImg = '';
    loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>";
    loadingImg += " <img src='/img/e_signature/loading.gif'/>";
    loadingImg += "</div>";

    $('body').append(mask).append(loadingImg);
    $('#mask').css({ 'width': maskWidth, 'height': maskHeight, 'opacity': '0.3' });
    $('#mask').show(); $('#loadingImg').show();
}
function hideLoadingBar() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').remove();
}