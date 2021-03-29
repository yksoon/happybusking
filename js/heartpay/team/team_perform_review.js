//아티스트 정보쪽에서 공연후기 페이지 클릭 시
var reviewCount = 0;

var sortValue = "0";

var countstar = 1;
// 스크롤
function sortreviews() {
	if ($("#sortname").text() == "최신순>") {
		$("#sortname").text("별점 순>");
		
		$("#team_info_list").html("");
		
		sortValue = "1";
		
		reviewCount = -5;
		
		
		$("#bottom_barr").text("See More");
		$("#bottom_barr").attr("onclick", "reviewload('1', sortValue);");
		$("#bottom_barr").css("color", "black");
		
		reviewload("1", sortValue);
	} else if ($("#sortname").text() == "별점 순>"){
		$("#sortname").text("최신순>");
		
		$("#team_info_list").html("");
		
		sortValue = "0";
		
		reviewCount = -5;
		
		$("#bottom_barr").text("See More");
		$("#bottom_barr").attr("onclick", "reviewload('1', sortValue);");
		$("#bottom_barr").css("color", "black");
		
		reviewload("1", sortValue);
	}
	
}
$(document).on("click","#Go_ReviewBtn", function(){
	reviewCount = 0;
	team_info_pageNo = 3;

	var header_html = '<div class="ui-block-a" id="Go_AiBtn">'+
						'<div class="haeder_menu_div_base">'+
							'<span>소개</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-b" id="Go_MediaBtn">'+
						'<div class="haeder_menu_div_base">'+
							'<span>사진/동영상</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-c" id="Go_PfsBtn">'+
						'<div class="haeder_menu_div_base">'+
							'<span>공연일정</span>'+
						'</div>'+
					'</div>'+
					'<div class="ui-block-d" id="Go_ReviewBtn">'+
						'<div class="haeder_menu_div_on">'+
							'<span>공연후기</span>'+
						'</div>'+
					'</div>';

	$('.header_menu_container').html(header_html);
						
		var middle_content = 
					'<div class="ui-grid-a" id="ti_intro_title">' +
						'<div class="ui-block-a">' +
							'<p>공연후기</p>' +
						'</div>' +
						'<div class="ui-block-b">' +
							'<span id = "sortname" onclick = "sortreviews();">최신순</span>' +
						'</div>' +
					'</div>';			  	
		
		
		$('#team_middle').html(middle_content);
		
		$('#team_info_list').empty();
		
		$('.pd_reply_div').hide();

		$.ajax({
			type: "GET",
			url: "/service/team/team_perform.jsp",
			contentType: "application/xml; charset=utf-8",
			data:{
				start:reviewCount,
				team_no:tno,
				sort:sortValue
			},
			dataType: "xml",
			success: function (result) {
				var ROOT = $(result).find("ROOT");
				var DATA = $(ROOT).find("DATA");
				
				if(DATA.length == 0){
					$("#main_cont").text("공연 후기는 신뢰성을 높이기 위하여 공연장에 비치된 QR코드를 스캔해야만 후기를 작성할 수 있습니다.");
					$("#main_cont").attr("onclick", "");
					$("#main_cont").removeClass("moreViewBtn");
					$("#main_cont").addClass("noViewBtn");
					$("#main_cont").css('display', 'inline-block');
					return;
				} else {
					$("#main_cont").hide();
				}
				
				countstar = 1;
				$(DATA).each(function(i) {
					var TEAM_NO = $(this).find("TEAM_NO").text();
					var USER_NO = $(this).find("USER_NO").text();
					var E_IMG = $(this).find("EPILOGUE_IMG").text();
					var NICKNAME = $(this).find("NICKNAME").text();
					
					//var e_img = '/upload/user/user'+USER_NO+'/'+E_IMG;
					
					var new_img = 'upload/images/team/team' + USER_NO + "/" + E_IMG;
	                
				     var imgSrc = getImagePromise(new_img).then(value => {
						$('#eimg'+E_IMG).attr('src', value);
				     });
					
					$("#team_info_list").append("<div class='ui-grid-b til_container' onclick = 'detail_review(" + $(this).find("EPILOGUE_NO").text() + ")'>"
							  + "<div class='ui-block-a til_img_div'>" 
							  + "<img id='eimg"+E_IMG+"'>"
							  + "</div>"
							  + "<div class='ui-block-b til_content_container'>"
							  + "<p class='til_cc_title'>"
							  + $(this).find("PF_INTRO").text() 
							  	+ "</p>"
			 					+ "<div class='ui-grid-a'>"
								+	"<div class='ui-block-a til_cc_star_contianer'>"
								+		"<select class='dr_rating' id='tp"+countstar+"' name='dr_rating' autocomplete='off'>"
								+			"<option value='1'>1</option>"
								+			"<option value='2'>2</option>"
								+			"<option value='3'>3</option>"
								+			"<option value='4'>4</option>"
								+			"<option value='5'>5</option>"
								+		"</select>"
								+	"</div>"
			 					+	"<div class='ui-block-b til_cc_star_text'>"
								+		"<p>" + $(this).find("RATY_STAR").text() + "</p>"
								+	"</div>"					
								+ "</div> "
								+ "<p class='til_cc_subject'>" + $(this).find("EPILOGUE_CONTENT").text() + "<p>"
								+ "<p class='til_cc_writeinfo'>"
								+ "<span class='til_cc_nickname'>" + NICKNAME + "</span>"
								+ "<span class='til_cc_date'>" +  $(this).find("EPILOGUE_DATE").text() + "</span><p>"
								+ "</div>"
								+ "<div class='ui-block-c til_cc_btnimg'>"
								+ "<img src='/img/common/show_btn.svg'>"
								+ "</div>"
								+ "</div>");		
					 	

					 	var starscore = $(this).find("RATY_STAR").text();
						
						$('#tp' + countstar).barrating({
					        theme: 'fontawesome-stars',
					        readonly: true,
							showSelectedRating: false,
							showValues: false,
							initialRating: starscore
					    });
					 
						countstar++;
						
				}).promise().done(function () {
					$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });			
				});
				
						
			},
			error: function(a, b, c) {
				console.log(a, b, c);	
			}
			
		});
		
		
	
});

// 초기 로드 외 추가 로드
function reviewload(team_no, sort) {
	
	reviewCount = reviewCount + 5;
	$.mobile.loading( 'hide', { text: 'loading', textVisible: true, theme: 'z', html: "" });
	
	$.ajax({
		type: "GET",
		url: "/service/team/team_perform.jsp",
		contentType: "application/xml; charset=utf-8",
		data:{
			start:reviewCount,
			team_no:tno,
			sort:sort
		},
		dataType: "xml",
		success: function (result) {
			if(reviewCount == 0) {
				$("#perform_sc_content").html("");
			}
			
			var ROOT = $(result).find("ROOT");
			var DATA = $(ROOT).find("DATA");	
			
			if(DATA.length == 0){
				$("#main_cont").text("내용이 없습니다.");
				$("#main_cont").attr("onclick", "");
				$("#main_cont").removeClass("moreViewBtn");
				$("#main_cont").addClass("noViewBtn");
				$("#main_cont").css('display', 'inline-block');
				return;
			} else if(DATA.length >= 5){
				$("#main_cont").text("더보기 >");
				$("#main_cont").attr("onclick", "reviewload(1, sortValue);");
				$("#main_cont").removeClass("noViewBtn");
				$("#main_cont").addClass("moreViewBtn");
				$("#main_cont").css('display', 'inline-block');
			} else {
				$("#main_cont").hide();
			}
			
			
			$(DATA).each(function() {
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var USER_NO = $(this).find("USER_NO").text();
				var E_IMG = $(this).find("EPILOGUE_IMG").text();
				var NICKNAME = $(this).find("NICKNAME").text();
				
				//var e_img = '/upload/user/user'+USER_NO+'/'+E_IMG;
				
				var new_img = 'upload/images/team/team' + USER_NO + "/" + E_IMG;
                
			     var imgSrc = getImagePromise(new_img).then(value => {
					$('#eimg'+E_IMG).attr('src', value);
			     });
				
				$("#team_info_list").append("<div class='ui-grid-b til_container' onclick = 'detail_review(" + $(this).find("EPILOGUE_NO").text() + ")'>"
						  + "<div class='ui-block-a til_img_div'>" 
						  + "<img id='eimg"+E_IMG+"'>"
						  + "</div>"
						  + "<div class='ui-block-b til_content_container'>"
						  + "<p class='til_cc_title'>"
						  + $(this).find("PF_INTRO").text() 
						  	+ "</p>"
		 					+ "<div class='ui-grid-a'>"
							+	"<div class='ui-block-a til_cc_star_contianer'>"
							+		"<select class='dr_rating' id='tp"+countstar+"' name='dr_rating' autocomplete='off'>"
							+			"<option value='1'>1</option>"
							+			"<option value='2'>2</option>"
							+			"<option value='3'>3</option>"
							+			"<option value='4'>4</option>"
							+			"<option value='5'>5</option>"
							+		"</select>"
							+	"</div>"
		 					+	"<div class='ui-block-b til_cc_star_text'>"
							+		"<p>" + $(this).find("RATY_STAR").text() + "</p>"
							+	"</div>"					
							+ "</div> "
							+ "<p class='til_cc_subject'>" + $(this).find("EPILOGUE_CONTENT").text() + "<p>"
							+ "<p class='til_cc_writeinfo'>"
							+ "<span class='til_cc_nickname'>" + NICKNAME + "</span>"
							+ "<span class='til_cc_date'>" +  $(this).find("EPILOGUE_DATE").text() + "</span><p>"
							+ "</div>"
							+ "<div class='ui-block-c til_cc_btnimg'>"
							+ "<img src='/img/common/show_btn.svg'>"
							+ "</div>"
							+ "</div>");		
				 	

				 	var starscore = $(this).find("RATY_STAR").text();
					
					$('#tp' + countstar).barrating({
				        theme: 'fontawesome-stars',
				        readonly: true,
						showSelectedRating: false,
						showValues: false,
						initialRating: starscore
				    });
				 
					countstar++;
					
					
					
			}).promise().done(function () {
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
			});
			
					
		},
		error: function(a, b, c) {
			console.log(a, b, c);	
		}
	});
}

