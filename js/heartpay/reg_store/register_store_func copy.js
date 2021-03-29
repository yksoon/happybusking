////////////////////////////////////////// 상업공간등록 관련된 js///////////////////////////////////////////////

// 넘어가야 할 페이지 영역
function go_reg_store() {
    loadPage('reg_store/promotion.jsp');
}
function go_form_reg_store() {
    if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		// if(artist_chk()){
		// 	infoTxtBox('이미 아티스트입니다.');
		// 	return;
		// }
        
        // 로그인 시 상업공간 등록 들어갈 수 있도록 함
        loadPage('reg_store/register_store.jsp');
	}

}
function go_complete_store() {
    loadPage('reg_store/complete_reg_store.jsp');
}
function go_reg_busking_time() {
    loadPage('busking_time/busking_time_reg.jsp');
}

//상업공간 등록하기
$(document).on('click', '.button_registration', function() {
    // jsp 내 필드값 불러오기
    // input
	var business_workname = $('#business_workname').val();
	var business_representive = $('#business_representive').val();
	var business_no = $('#business_no').val();
	var address = $('#address').val() + $('#address_detail').val();
	var business_phone = $('#business_phone').val();
    var operationhour = $('#operationhour').val();
    var equipment = $('#equipment').val();
    var zone_info = $('#zone_info').val();
    
    // hashtag(배열)
    // var hashtag = $('#hashtag').val();
    
    // img(business_다중 사진)
    // var business_license = $('#business_license').attr('src');
    // var space_picture = $('#space_picture').attr('src');
    // var stage_picture = $('#stagee_picture').attr('src');
    // var imgsrc = $('#menu').attr('src');
	
	if(business_workname == ''){
		alert('상호명을 입력해주세요.');
		$('#business_workname').focus();
		return;
	}else if(business_representive == ''){
		alert('대표자명을 입력해주세요.');
		$('#business_representive').focus();
		return;
	}else if(business_no == ''){
		alert('사업자번호를 입력해주세요.');
		$('#artist_intro').focus();
		return;
	}else if(address == ''){
		alert('주소를 입력해주세요.');
		$('#address').focus();
		return;
	} else if(business_phone == ''){
		alert('연락처를 입력해주세요.');
		$('#business_phone').focus();
		return;
	} else if(operationhour == ''){
		alert('영업시간을 등록해주세요.');
		$('#operationhour').focus();
		return;
	}else if(equipment == ''){
		alert('지원장비를 입력해주세요.');
		$('#equipment').focus();
		return;
	}else if(zone_info == ''){
		alert('공간 소개를 입력해주세요.');
		$('#zone_info').focus();
		return;
	}
	
	if(!$('#tm_agree').prop('checked')){
		infoTxtBox('약관에 동의해주세요.');
		return;
	}
    
    
	// $.ajax({
	// 	type: "GET",
	// 	cache: false,
	// 	url: '/service/reg_store/register_store.jsp',
	// 	data: {
	// 		artist_name: artist_name
	// 	},
	// 	contentType: "application/xml; charset=utf-8",
	// 	dataType: "xml",
	// 	async: false,
	// 	timeout: 30000,
	// 	success : function(data){
	// 		var ROOT = $(data).find('ROOT');
	// 		var DATA = $(ROOT).find('DATA');
			
	// 		if(DATA.length != 0){
	// 			alert('중복된 개인 활동명입니다. 다시 입력해주세요.');
	// 			$('#artist_name').val('');
	// 			$('#artist_name').focus();
	// 			return;
	// 		} else {
	// 			//AJAX 로딩 표시
	// 			$.ajax({
	// 				type: "POST",//url: "JSON/test.json",
	// 				cache: false,
	// 				url: '/service/artist_become/artist_become.jsp',
	// 				//data : data,
	// 				data : {
	// 					artist_img: artist_img,
	// 					artist_name: artist_name,
	// 					artist_intro: artist_intro,
	// 					artist_phone: artist_phone,
	// 					artist_sns: artist_sns,
	// 					artist_use_tool: artist_use_tool
	// 				},
	// 				dataType: "xml",
	// 				async: false,
	// 				timeout: 30000,
	// 				beforeSend: function(){
	// 					$.mobile.loading( 'show', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
	// 				},
	// 				success: function (data) {
	// 					var ROOT = $(data).find("ROOT");
	// 					var DATA = $(ROOT).find('DATA');
	// 					if(DATA.length == 0){
	// 						$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
	// 						return;
	// 					}
	// 				}, // end success
	// 				error: function (xhr, message, errorThrown) {
	// 					alert('잠시후 다시 시도해주세요.');
	// 					return;
	// 					//hideLoading();
	// 				}, // end error
	// 				complete: function(){
	// 					$.mobile.loading( 'hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
	// 					sessionStorage.setItem('aname', $('#artist_name').val())
	// 					sessionStorage.setItem('acontent', $('#artist_intro').val());
	// 					setAimgCallback2(imgsrc);
	// 					go_team_create();
	// 				}
	// 			});
	// 		}
	// 	}
	// });
});

////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 홍보 페이지 사진 영역 js
$(document).on('pageinit', '#busking_promotion', function () {

    var bdc_main_img_html = '<li>' + '<div class="bdc_image_div">' +
        '<img src="/img/reg_store/promotion_slide1.png" alt="Los Angeles" style="width:295px; max-width: none; height:350px;">' +
        '</div>' + '</li>';

    $('#bdc_pfsc_ing_ul').append(bdc_main_img_html);
    $('#bdc_img_selecter').append('<li class="bdc_img_active" id="bdc_img_selecter_1">●</li>');


    var bz_sub_img_html = '';
    var bz_sub_img_selecter = '';

    bz_sub_img_html = '<li>' + '<div class="bdc_image_div">' +
    '<img src="/img/reg_store/promotion_slide2.png" alt="Los Angeles" style="width:295px; max-width: none; height:350px;">' +
    '</div>' + '</li>';

    $('#bdc_pfsc_ing_ul').append(bz_sub_img_html);

    const cnt = $('#bdc_img_selecter').find('li').length;

    bz_sub_img_selecter = '<li id="bdc_img_selecter_' + (cnt+1) + '">●</li>';
    $('#bdc_img_selecter').append(bz_sub_img_selecter);

    var bdc_carousel;
    bdc_carousel = $("#bdc_pfsc_ing_ul");
    bdc_carousel.itemslide(
        {
            left_sided: true,
            disable_clicktoslide: true
        }
    );

    bdc_carousel.on('changePos', function (e) {
        var ai = bdc_carousel.getActiveIndex() + 1;

        $('#bdc_img_selecter').find('li').removeClass('bdc_img_active');
        $('#bdc_img_selecter_' + ai).addClass('bdc_img_active');
    });

});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 해시태그 관련 js

// 배열 선언
var arrayHashTag = [];

// 해시태그 생성 기능
function add_hashtag() {
    // 해시태그 local 선언
    var area_hashtag = document.getElementById("area_hashtag");

    // input 값 호출 및 배열 삽입
    var hashTag = "#" + document.getElementById("hashtag").value;
    arrayHashTag.push(hashTag);

    // js를 이용한 div 생성
    area_hashtag.innerHTML = "";
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            area_hashtag.innerHTML += "<div class='hashtag_individual'>" + arrayHashTag[i];
            area_hashtag.innerHTML += "<div class='hashtag_close' onclick='delete_hashtag(" + i + ")'><img class='icon_exit_b' src='/img/reg_store/exit_2.svg' /></div>";
            area_hashtag.innerHTML += "</div>";
        }
    }

    // hashTag 내 value 확인(console.log())
    console.log("hastTag 전체 : " + arrayHashTag);
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            console.log("arrayHashTag[" + i + "] : " + arrayHashTag[i]);
        }
    }

    // input 값 리셋
    document.getElementById("hashtag").value = "";
}

// 해시태그 삭제 기능
function delete_hashtag(i) {
    delete arrayHashTag[i];
    arrayHashTag[i] = "";

    // 해시태그 리셋후 다시 출력
    area_hashtag.innerHTML = "";
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            area_hashtag.innerHTML += "<div class='hashtag_individual'>" + arrayHashTag[i];
            area_hashtag.innerHTML += "<div class='hashtag_close' onclick='delete_hashtag(" + i + ")'><img class='icon_exit_b' src='/img/reg_store/exit_2.svg' /></div>";
            area_hashtag.innerHTML += "</div>";

        }
    }

    // hashTag 내 value 확인(console.log())
    console.log("삭제된 array : " + arrayHashTag);
    for (var i = 0; i < arrayHashTag.length; i++) {
        if (arrayHashTag[i] == "") {
            continue;
        } else {
            console.log("arrayHashTag[" + i + "] : " + arrayHashTag[i]);
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 완료 페이지 js(총 11페이지)
// 필요한 부분 가져가서 사용하면 됩니다.

// 완료 페이지 관리 영역
function go_complete_page() {
    loadPage('reg_store/manage_complete_page.jsp');
}

// 사업주(business) 영역
// 공간 등록 완료
function go_complete_reg_store() {
    loadPage('reg_store/complete_reg_store.jsp');
}
// 등록 완료
function go_complete_reg_busking_time() {
    loadPage('reg_store/complete_reg_busking_time.jsp');
}
// 공연 승인 완료
function go_complete_accept_busking() {
    loadPage('reg_store/complete_accept_busking.jsp');
}
// 공연 거절 완료
function go_complete_reject_busking() {
    loadPage('reg_store/complete_reject_busking.jsp');
}
// 계약서 서명 완료
function go_complete_sign_contract_business() {
    loadPage('reg_store/complete_sign_contract_business.jsp');
}
// 수정 완료
function go_complete_modify_busking_zone() {
    loadPage('reg_store/complete_modify_busking_zone.jsp');
}
// 삭제 완료
function go_complete_delete_busking_zone() {
    loadPage('reg_store/complete_delete_busking_zone.jsp');
}

// 아티스트(artist) 영역
// 쿠폰 복사 완료
function go_complete_copy_coupon() {
    loadPage('reg_store/complete_copy_coupon.jsp');
}
// 공연 신청 완료
function go_complete_apply_busking() {
    loadPage('reg_store/complete_apply_busking.jsp');
}
// 신청 취소 완료
function go_complete_cancel_busking() {
    loadPage('reg_store/complete_cancel_busking.jsp');
}
// 계약서 서명완료
function go_complete_sign_contract_artist() {
    loadPage('reg_store/complete_sign_contract_artist.jsp');
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////// 테스트를 위해 임시로 넣어둔 부분(사진 추가/리사이징/저장(파이어베이스(구글)))  ////////////////////

function go_image_working() {
    loadPage('test_1214/test_image_resizing.jsp');
}

//아티스트 되기 페이지
$(document).on('pageinit', '#test_artist_become', function () {
    /*var busker_oath = getCookie('busker_oath');
    var bocChk = sessionStorage.getItem('bocChk');
    if(busker_oath != 'Y'){
        if(bocChk != 'Y'){
            goBuskingOath();
        } else {
            alert('\'아티스트 되기\'등록 후 반드시 팀·솔로 등록을 해주세요!');
        }
    } else {
        alert('\'아티스트 되기\'등록 후 반드시 팀·솔로 등록을 해주세요!');
    }*/

    $('#test_artist_img').parents('.ui-corner-all').css('display', 'none');
});

$(document).on('click', '#test_artist_become_img', function () {
    $('#test_artist_img').click();
    console.log('sdsdsd')
});

$(document).on('change', '#test_artist_img', function () {
    if ($(this).val() === '') return;
    readURL(this, 2, 1);
});

//아티스트 등록하기
$(document).on('click', '.test_register_picture_btn', function () {

    var uploading_img = $('#img_name').val();
    var imgsrc = $('#img_preview').attr('src');

    //AJAX 로딩 표시
    $.ajax({
        type: "POST",//url: "JSON/test.json",
        cache: false,
        url: '/service/test_1214/test_image_resizing.jsp',
        //data : data,
        data: {
            uploading_img: uploading_img
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
            alert('사진이 등록되었습니다.');

        }, // end success
        error: function (xhr, message, errorThrown) {
            alert('잠시후 다시 시도해주세요.');
            return;
            //hideLoading();
        }, // end error
        complete: function () {
            $.mobile.loading('hide', { text: '등록중입니다.', textVisible: true, theme: 'b', html: "" });
            sessionStorage.setItem('aname', $('#artist_name').val())
            sessionStorage.setItem('acontent', $('#artist_intro').val());
            setAimgCallback2(imgsrc);

            // go_team_create();
        }
    });

});

// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//이미지 리사이징
// var test_cropper;

// const test_readURL = (input, w, h) => {

//     test_cropper = '';
//     $('#test_resize-image-container').show();
//     test_showImageLoading('사진을 불러오는중입니다.<br>잠시만 기다려주세요.<br>파일의 크기가 크면 오래 걸릴 수 있습니다.');
//     if (input.files && input.files[0]) {

//         let reader = new FileReader();

//         reader.onload = function (e) {
//             $('#test_ric-img').attr('src', e.target.result);

//             const image = document.getElementById('test_ric-img');

//             if (test_cropper === undefined || test_cropper === 'undefined' || test_cropper === '') {
//                 test_cropper = new Cropper(image, {
//                     autoCrop: true,  //true 로 설정
//                     aspectRatio: w / h,
//                     ready() {
//                         $('#test_loading-container').hide();
//                         // console.log(test_cropper);
//                     },
//                     crop(event) {
//                         /*console.log(event.detail.x);
//                         console.log(event.detail.y);
//                         console.log(event.detail.width);
//                         console.log(event.detail.height);
//                         console.log(event.detail.rotate);
//                         console.log(event.detail.scaleX);
//                         console.log(event.detail.scaleY);*/
//                     },
//                 });
//             }
//             test_cropper.replace(e.target.result);
//         }
//         reader.readAsDataURL(input.files[0]);
//     }
// }

// const test_resizeSave = (path) => {
//     // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`.
//     // The default value for the second parameter of `toBlob` is 'image/png', change it if necessary.
//     test_showImageLoading('사진을 저장중입니다.<br>잠시만 기다려주세요.');
//     test_cropper.getCroppedCanvas().toBlob((blob) => {
//         const filename = createRandomNum() + '.jpeg';

//         // Pass the image file name as the third parameter if necessary.
//         uploadResizeFile(blob, path, filename, function (f) {
//             var new_img = '/upload/' + path + '/' + f;

//             var imgSrc = getImagePromise(new_img).then(value => {
//                 $('#test_img_preview').attr('src', value);
//                 $('#test_img_name').val(filename);
//                 $('#test_resize-image-container').hide();
//                 test_cropper = '';
//             });
//         });

//         //$('#uploading').show();
//         // Use `jQuery.ajax` method for example
//         /*$.ajax('./image_save.jsp', {
//           method: 'POST',
//           data: formData,
//           processData: false,
//           contentType: false,
//           success: function() {
//           },
//           error: function() {
//               console.log('Upload error');
//           },
//           complete: function(){
//               setTimeout(function(){
//                   $('#uploading').hide();
//                   $('#result').attr('src', '/upload/'+filename);
//               }, 3000);
//           }
//         });*/
//     }, 'image/jpeg');
// }

// const test_showImageLoading = (msg) => {
//     $('#test_loading-message').html(msg);
//     $('#test_loading-container').show();
// }

// $(document).on('click', '#test_ric-cancel', function () {
//     $('#test_resize-image-container').hide();
//     test_cropper = '';
// })


// $(document).on('click', '#test_ric-save', function () {
//     const nowpage = $('div[data-role=page]').attr('id');

//     let no = '';
//     let path = '';

//     if (nowpage === 'test_artist_become') {
//         path = 'test';
//     } else {
//         alert('잘못된 접근입니다.\n다시 시도해주세요.');
//         return;
//     }

//     test_resizeSave(path);
// });
