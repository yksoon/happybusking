var record_count = 0;		//내가 본 공연 목록 더보기를 위한 카운트
var user_pfno_temp;
var user_pftno_temp;
function writeReview(seq, seq2, RECORD_CHK) {
	if(RECORD_CHK == 1){
		infoTxtBox('후기는 한번만 작성 가능합니다.');
		return;
	}
	user_pfno_temp = seq;
	user_pftno_temp = seq2;
	loadPage('user_performance_record/user_write_review.jsp');
}

$(document).on('pageinit', '#user_write_review', function() {
	$('#pf_no').val(user_pfno_temp);
	$('#team_no').val(user_pftno_temp);
	$('#rcontent').textinput("option", "autogrow", false);
	
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: '/service/detail_performance/detail_performance.jsp',
		data: {
			pf_no : user_pfno_temp
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT2 = $(data).find("ROOT2");
			var DATA = $(ROOT2).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				infoTxtBox('error');
				return;
			}
			
			$(DATA).each(function(i) {
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var PF_INTRO = $(this).find('PF_INTRO').text();
				
				$('#team_pf_name').empty();
				$('#team_pf_name').append(TEAM_NAME + '[' + PF_INTRO + ']');
			});
		}
	});
});

function user_performance_record() {
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('user_performance_record/user_performance_record.jsp');
	}
}

// 내가 본 공연들 어펜드.... 테이블 새로 만들어야함
$(document).on('pageinit', '#user_performance_record', function(){
	ganreCount = 1;
	var url = '/service/user/user_review_record.jsp';
	var user_no = $('#record_user_no').val();
	$.ajax({
		type: "GET",
		cache: false,
		url: url,
		data: {
			start: record_count,
			user_no: user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find("DATA");
			
			if(DATA.length == 0){
				$("#main_cont").text("내용이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if(DATA.length == 5){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "recordRoad()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			$('#user_record_content').empty();
			
			$(DATA).each(function(i) {
				var PF_NO = $(this).find("PF_NO").text();
				var PF_IMG = $(this).find("PF_IMG").text();
				var PF_INTRO = $(this).find("PF_INTRO").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var PF_TIME = $(this).find("PF_TIME").text();
				var CODE_AREA = $(this).find("CODE_AREA").text();
				var PF_PLACE = $(this).find("PF_PLACE").text();
				var PF_LATLNG = $(this).find("PF_LATLNG").text();
				var PF_ADDR = $(this).find("PF_ADDR").text();
				var PF_DETAIL_CONTENT = $(this).find("PF_DETAIL_CONTENT").text();
				var WEEK = $(this).find("WEEK").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				//var p_img = '/upload/team/team'+ TEAM_NO + '/' + PF_IMG;
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#mpimg'+PF_NO).attr('src', value);
			     });
				
				var PF_DATE_WEEK_TIME = PF_DATE + '&#40;' + WEEK + '&#41;' + '&nbsp;' + PF_TIME;
				
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var RECORD_CHK = $(this).find("RECORD_CHK").text();
				
				var r_chk = '';
				if(RECORD_CHK == 'Y'){
					//리뷰 작성 했으면
					r_chk = '<p id="perform_write">작성</p>';
					RECORD_CHK = 1;
				}
				else{
					//리뷰 작성 안했으면
					r_chk = '<p id="perform_noWirte">미작성</p>';
					RECORD_CHK = 0
				}
				
				var user_record_content = '<div class="ui-grid-b ur_content_body" onclick = "writeReview('+PF_NO+','+TEAM_NO+','+RECORD_CHK+');">'+
						'<div class="ui-block-a" style="width: 35%; height: 100%;">'+
							'<img id="mpimg'+PF_NO+'">'+
						'</div>'+
					'<div class="ui-block-b" style="width: 60%; padding-left: 15px;">'+
						'<div class="ui-grid-c" style="line-height: 1.5;">'+
							'<div class="ui-block-a ur_content_top">'+
								r_chk+
								TEAM_NAME+'_'+CODE_AREA+
							'</div>'+
							'<div class="ui-block-b" style="width:100%; font-size: 13px;">'+
								PF_DATE_WEEK_TIME+
							'</div>'+
							'<div class="ui-block-c" style="width:100%; font-size: 13px;">'+
								PF_PLACE+
							'</div>'+				
							'<div class="ui-block-d ur_content_bottom" id="genre_div'+ganreCount+'">'+
							'</div>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-c user_record_button">'+
						'<img src="/img/common/show_btn.png">'+
					'</div>'+
				'</div>';	
				
				$('#user_record_content').append(user_record_content);
				
				var genre_arr = CODE_GENRE.split(",");
				var genre_div ='';
				
				var genre_arr_length = genre_arr.length;
				if(genre_arr_length > 2){
					genre_arr_length = 2
				}
				
				for(var i=0; i < genre_arr_length; i++){
					if(i == 0){
						genre_div = '<p class="user_content_genre_1">'+ genre_arr[i] +'</p>';
					}
					else{
						genre_div = '<p class="user_content_genre_2">'+ genre_arr[i] +'</p>';
					}
					$('#genre_div'+ganreCount).append(genre_div);
				}
				ganreCount++;
			});
		},error: function(xhr, message, errorThrown) {
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		}
	});
});


$(document).on('pageinit', '#user_write_review', function(){
    $('.ui-select').css('display', 'none');
	$(".ui-input-text").css("height", "100%");
});

$(document).on('click', '#uwr_img_cont', function() {
	$('#uwr_img_cont').empty();
	$('#img_file').click();
});

function loadFile(event) {
	if($("#img_file").val() != ""){
		var ext = $('#img_file').val().split('.').pop().toLowerCase();
		      if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {

			 infoTxtBox('이미지 파일만 업로드 할 수 있습니다.');

			 return;

		      }
	}
	
	$("#uwr_img_cont").html('<img id = "output" style = "width:100%;height:100%;display:inline-block;margin:0px auto;" onclick = "change_pic();">');
	
	var output = document.getElementById('output');
	output.src = URL.createObjectURL(event.target.files[0]);
	
};


//공통
function change_pic() {
	$("#uwr_img_cont").html('<input id = "img_file" name = "img_file" type = "file" style = "width:100%;height:100%;display:block;margin:0px auto;opacity:0;" accept="image/*" onchange = "loadFile(event);">');
};


function sendreview() {
	var team_no = $('#team_no').val();
	var pf_no = $('#pf_no').val();
	
	var rimage = '';
	
	var rating = $('#rrating').val();
	var rtitle = changeQuotes($('#rtitle').val());
	var rcontent = changeQuotes($('#rcontent').val());
	
	if(rtitle == ''){
		alert('제목을 입력해주세요');
		return;
	} else if(rcontent == ''){
		alert('후기를 입력해주세요.');
		return;
	}
	
	if($('#img_file').val() != ''){
		rimage = $('#img_file')[0].files[0].name;
	}
	
	$.ajaxSettings.traditional = true;
	var formData = new FormData();
	
	formData.append('team_no', team_no);
	formData.append('pf_no', pf_no);
	formData.append('rimage', rimage);
	formData.append('rating', rating);
	formData.append('rtitle', rtitle);
	formData.append('rcontent', rcontent);
	
	if(rcontent != ''){
		formData.append('rimg', $('#img_file')[0].files[0]);
	}
	
	$.ajax({
		type: "POST",//url: "JSON/test.json",
		cache: false,
		url: '/service/user_review_upload/user_review_upload.jsp',
		data : formData,
		processData: false,
		contentType: false,
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var RESULT = $(this).find('RESULT').text();
				var MSG = $(this).find('MSG').text();
				
				if(RESULT == 'true' || RESULT == 'TRUE'){
					alert(MSG);
					user_performance_record();
				} else {
					alert(MSG);
					return;
				}
			});
		}
	});
}

//내가 본 공연 더보기
function recordRoad() {
	record_count += 5;
	$.mobile.loading( 'hide', { text: 'loading', textVisible: false, theme: 'z', html: "" });
	
	var url = '/service/user/user_review_record.jsp';
	var user_no = $('#record_user_no').val();
	$.ajax({
		type: "GET",
		cache: false,
		url: url,
		data: {
			start: record_count,
			user_no: user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function(data){
			if(record_count == 0) {
				$("#user_record_content").html("");
			}
			
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find("DATA");
			
			if(DATA.length == 5){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "recordRoad()");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").show();
			} else {
				$("#main_cont").hide();
			}
			
			$('#user_record_content').empty();
			
			$(DATA).each(function(i) {
				var PF_NO = $(this).find("PF_NO").text();
				var PF_IMG = $(this).find("PF_IMG").text();
				var PF_INTRO = $(this).find("PF_INTRO").text();
				var PF_DATE = $(this).find("PF_DATE").text();
				var PF_TIME = $(this).find("PF_TIME").text();
				var CODE_AREA = $(this).find("CODE_AREA").text();
				var PF_PLACE = $(this).find("PF_PLACE").text();
				var PF_LATLNG = $(this).find("PF_LATLNG").text();
				var PF_ADDR = $(this).find("PF_ADDR").text();
				var PF_DETAIL_CONTENT = $(this).find("PF_DETAIL_CONTENT").text();
				var WEEK = $(this).find("WEEK").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#mpimg'+PF_NO).attr('src', value);
			     });
				
				
				var PF_DATE_WEEK_TIME = PF_DATE + '&#40;' + WEEK + '&#41;' + '&nbsp;' + PF_TIME;
				
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var RECORD_CHK = $(this).find("RECORD_CHK").text();
				
				var r_chk = '';
				if(RECORD_CHK == 'Y'){
					//리뷰 작성 했으면
					r_chk = '<p id="perform_write">작성</p>';
					RECORD_CHK = 1;
				}
				else{
					//리뷰 작성 안했으면
					r_chk = '<p id="perform_noWirte">미작성</p>';
					RECORD_CHK = 0
				}
				
				var user_record_content = '<div class="ui-grid-b ur_content_body" onclick = "writeReview('+PF_NO+','+TEAM_NO+','+RECORD_CHK+');">'+
						'<div class="ui-block-a" style="width: 35%; height: 100%;">'+
							'<img id="mpimg'+PF_NO+'">'+
						'</div>'+
					'<div class="ui-block-b" style="width: 60%; padding-left: 15px;">'+
						'<div class="ui-grid-c" style="line-height: 1.5;">'+
							'<div class="ui-block-a ur_content_top">'+
								r_chk+
								TEAM_NAME+'_'+CODE_AREA+
							'</div>'+
							'<div class="ui-block-b" style="width:100%; font-size: 13px;">'+
								PF_DATE_WEEK_TIME+
							'</div>'+
							'<div class="ui-block-c" style="width:100%; font-size: 13px;">'+
								PF_PLACE+
							'</div>'+				
							'<div class="ui-block-d ur_content_bottom" id="genre_div'+ganreCount+'">'+
							'</div>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-c user_record_button">'+
						'<img src="/img/common/show_btn.png">'+
					'</div>'+
				'</div>';	
				
				$('#user_record_content').append(user_record_content);
				
				var genre_arr = CODE_GENRE.split(",");
				var genre_div ='';
				
				var genre_arr_length = genre_arr.length;
				if(genre_arr_length > 2){
					genre_arr_length = 2
				}
				
				for(var i=0; i < genre_arr_length; i++){
					if(i == 0){
						genre_div = '<p class="user_content_genre_1">'+ genre_arr[i] +'</p>';
					}
					else{
						genre_div = '<p class="user_content_genre_2">'+ genre_arr[i] +'</p>';
					}
					$('#genre_div'+ganreCount).append(genre_div);
				}
				ganreCount++;
			});
		},error: function(xhr, message, errorThrown) {
			infoTxtBox(xhr);
			infoTxtBox(message);
			infoTxtBox(errorThrown);
		}
	});
}

$(document).on('click', '#img_cont', function() {
	$('#img_file').click();
});