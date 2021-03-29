//공연의뢰 신청 페이지
function go_pfRequest(){
	var login_chk = userLogin_chk();
	if(login_chk == true){
		loadPage('perform_request/perform_request.jsp');
	}else{
		infoTxtBox("로그인하고 이용해주세요");
		loadPage('login/login.jsp');
	}
}

//유저쪽 공연의뢰하기 조회 페이지 이동 함수
function go_user_performRequestList(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	} else {
		loadPage('perform_request/user_perform_requestList.jsp');
	}
		
}


//아티스트쪽 공연의뢰내역 조회 페이지 이동 함수
function go_artist_performRequestList(){
	if(userLogin_chk() == false){
		infoTxtBox('로그인 하시고 해당 서비스를 이용해주세요');
		loadPage('login/login.jsp');
	}else{
		if(!artist_chk()){
			var conf = confirm('관람자 메뉴에 \'아티스트 되기\'를 먼저 등록한 후에 이용가능합니다.\n\'아티스트 되기\'로 이동하시겠습니까?');
			if(!conf){
				return;
			}
			loadPage('artist_become/artist_become.jsp');
		} else {
			loadPage('perform_request/artist_perform_requestList.jsp');
		}
	}
}

function performReqBackBtn(){
	toHome();
}

function go_pfr_search() {
	loadPage('perform_request/perform_request_search.jsp');
}

function getUserPrSearchList(){
	var url = "/service/perform_request/user_perform_requestList.jsp";
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		cache: false,
		url: url,
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (data) {
			var ROOT = $(data).find("ROOT");
			var DATA = $(ROOT).find('DATA');
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				$("#uPRqList_part").empty();
				$("#uPRqList_part").html('<div id="main_cont" class="noViewBtn">내용이 없습니다.</div>');
				return;				
			}
			
			
			$('#uPRqList_part').empty();
			
			$(DATA).each(function(i) {
				//XML 컬럼들 
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var PF_REQUEST_NO = $(this).find("PF_REQUEST_NO").text();
				var PF_REQUEST_GRP_NO = $(this).find("PF_REQUEST_GRP_NO").text();
				var PF_REQUEST_SDATE = $(this).find("PF_REQUEST_SDATE").text();
				var PF_REQUEST_STIME = $(this).find("PF_REQUEST_STIME").text();
				var PF_REQUEST_EDATE = $(this).find("PF_REQUEST_EDATE").text();
				var PF_REQUEST_ETIME = $(this).find("PF_REQUEST_ETIME").text();		
				var PF_REQUEST_DETAIL_ADDR = $(this).find("PF_REQUEST_DETAIL_ADDR").text();
				var PF_REQUEST_REG_DATE = $(this).find("PF_REQUEST_REG_DATE").text();
				var PF_REQUEST_STATE = $(this).find("PF_REQUEST_STATE").text();
				var PF_REQUEST_PRICE = $(this).find("PF_REQUEST_PRICE").text();
				

				var prqShowState1 = "";
				var prqShowState2 = "";
				
				if(PF_REQUEST_STATE == "P"){
					prqShowState1 = '<span class="prqStateW">요청 대기중</span>';
					prqShowState2 = '<span class="prqCancelCss" onclick=userPrqCancel('+ TEAM_NO + "," + PF_REQUEST_NO + ')>요청취소</span>';
				}else if(PF_REQUEST_STATE == "Y"){
					prqShowState1 = '<span class="prqStateY">의뢰수락</span>';
					prqShowState2 = '<span class="prqNoCancelCss">취소불가</span>';
				}else if(PF_REQUEST_STATE == "N"){
					prqShowState1 = '<span class="prqStateN">의뢰거절</span>';
					prqShowState2 = '<span class="prqNoCancelCss">취소불가</span>';
				}
				
				var date = PF_REQUEST_SDATE + " ~ " + PF_REQUEST_EDATE;
				var time = PF_REQUEST_STIME + " ~ " + PF_REQUEST_ETIME;
				
				PF_REQUEST_PRICE = parseInt(PF_REQUEST_PRICE);
				PF_REQUEST_PRICE = numberWithCommas(PF_REQUEST_PRICE);
				PF_REQUEST_PRICE = PF_REQUEST_PRICE + "원";
				
				var html = 
				'<p class="prqShowIsTeam">' + TEAM_NAME + '<span class="prqShowIsDate">' + PF_REQUEST_REG_DATE + '</span></p>' +
				'<div class="ui-grid-b prqListContentCss" onclick="perform_request_detailList('+ TEAM_NO + "," + PF_REQUEST_NO +',' + "'U'" + ')";>' +
					'<div class="ui-block-a">' +	
						'<p>공연기간</p>' +
						'<p>공연시간</p>' +
						'<p>공연장소</p>' +	
						'<p>금액</p>' +		
						'<div>'+ prqShowState1 +'</div>' +
					'</div>' +
					'<div class="ui-block-b">' +
						'<p>' + date + '</p>' +
						'<p>' + time + '</p>' +
						'<p>' + PF_REQUEST_DETAIL_ADDR + '</p>' +
						'<p class="prqListPriceCss">' + PF_REQUEST_PRICE + '</p>' +
						'<div>' + prqShowState2 + '</div>' +				
					'</div>' +
					'<div class="ui-block-c">' +
						'<img style="width: 40%;" src="/img/common/show_btn.svg">' +
					'</div>' +
				'</div>';
				
				
				$('#uPRqList_part').append(html);
				
		
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });				
			});
			
			
		}, // end success
		error: function (xhr, message, errorThrown) {
			console.log('xhr : ' + xhr);
			console.log('message : ' + message);
			console.log('errorThrown : ' + errorThrown);
			//hideLoading();
		} // end error 
	});	
}

function pr_search_team(tname, tgenre, tarea, tsmoney, temoney, ttype) {
	$('#prq_search_content').empty();
	$.ajax({
		type: "GET",
		url: "/service/perform_request/perform_request_search.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			tname: tname,
			tgenre: tgenre,
			tarea: tarea,
			tsmoney: tsmoney,
			temoney: temoney,
			ttype: ttype
		},
		dataType: "xml",
		success: function (result) {
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");
			
			if(DATA.length == 0){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
				
				$("#main_cont").text("검색 결과가 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				
				$('#prq_sh_request_btn').hide();
				
				return;
			} else {
				$("#main_cont").hide();
				$('#prq_sh_request_btn').show();
			}
			
			$(DATA).each(function(i) {
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var CODE_GENRE = $(this).find("CODE_GENRE").text();
				var TINTRO_IMG = $(this).find('TINTRO_IMG').text();
				
				var new_img = 'upload/images/team/team' + TEAM_NO + "/" + TINTRO_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#img'+TEAM_NO).attr('src', value);
			     });
				
				var prq_search_content = '<div class="ui-grid-a prq_content" id="' + TEAM_NO + '">'+
											'<div class="ui-block-a prq_content_tinfo" id="'+TEAM_NO+'" onclick="go_team_infoPage('+TEAM_NO+')">'+
												'<div class="ui-grid-a">'+
												 	'<div class="ui-block-a prq_content_img">'+
												 		'<img id="img'+TEAM_NO+'">'+
												 	'</div>'+
												 	'<div class="ui-block-b prq_content_subject">'+
													 	'<div class="ui-grid-a">'+
												 			'<div class="ui-block-a prq_content_title">'+
												 				TEAM_NAME+
												 			'</div>'+
												 			'<div class="ui-block-b prq_content_genre">'+
												 				CODE_GENRE+
												 			'</div>'+
													 	'</div>'+
												 	'</div>'+
											 	'</div>'+
											 '</div>'+
										 	'<div class="ui-block-b prq_content_btn">'+
										 		'<input type="checkbox" name="prq_list_chk" id="prq_list_chk_'+TEAM_NO+'" value="'+TEAM_NO+'">'+
										 		'<label for="prq_list_chk_'+TEAM_NO+'" class="prq_list_chk_btn"> </label>'+
										 	'</div>'+
										 '</div>';
			
				$('#prq_search_content').append(prq_search_content);
			}).promise().done(function (){
				$('#prq_sh_request_btn').show();
				var selectindex = sessionStorage.getItem('selectindex');
				if(selectindex != null && selectindex != ''){
					var selectindex_array = selectindex.split(',');
					for(var i = 0; i < selectindex.length; i++){
						$('#prq_list_chk_'+selectindex_array[i]).prop('checked', true);
					}
				}
				$('#prq_search_result_title').show();
				
				var prqScroll = sessionStorage.getItem('prqScroll');
				if(prqScroll == null){
					$(window).scrollTop(0);
				} else {
					$('html,body').animate({scrollTop: prqScroll}, 'fast');
				}
			});
			
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
}
