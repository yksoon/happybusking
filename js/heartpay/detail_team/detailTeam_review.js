var detail_review_no;
//밀어서 컨텐츠 더보기 구현 해야함

function detail_review (seq) {
	detail_review_no = seq;
	loadPage('detail_review/detail_review.jsp');
}

$(document).on('pageinit', '#detail_review', function() {
	$.ajax({
		type: "GET",
		cache: false,
		url: "/service/detail_review/detail_review.jsp",
		data : {
			'seq' : detail_review_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success: function (result) {
		var contentCount = 0;
		var ROOT = $(result).find("ROOT");
		var DATA = $(ROOT).find('DATA');
			
			
		$(DATA).each(function(i){
			var user_no = $(DATA).find("USER_NO").text();
			var etitle = $(DATA).find("EPILOGUE_TITLE").text();
			var econtent = changeLineBreak($(DATA).find("EPILOGUE_CONTENT").text());
			var edate = $(DATA).find("EPILOGUE_DATE").text();
			var eimg = $(DATA).find("EPILOGUE_IMG").text();
			var euser = $(DATA).find("USER_ID").text();
			var enick = $(DATA).find("NICKNAME").text();
			var evideo = $(DATA).find("EPILOGUE_VIDEO").text();
			var eteam_no = $(DATA).find("TEAM_NO").text();
			
			var snum =  $(DATA).find("RATY_STAR").text();
			
			//eimg = '/upload/user/user' + user_no + '/' + eimg;

			 var new_img = 'upload/images/user/user' + user_no + "/" + eimg;
             
		     var imgSrc = getImagePromise(new_img).then(value => {
				$('#dr_img'+i).css('background-image', 'url(' + value + ')');
				
				if (eimg == "" && evideo == "") {
					$('#dr_img').css('background-image', 'url(/img/common/no_image.png');
				}
		     });
			
			$('#dr_title_name').html(enick);
			$('#dr_title_date').html(edate);
			
			$('#dr_rate_text').html(snum + ' / 5');
			
			$('#dr_content_title').html(etitle);
			$('#dr_content_subject').html(econtent);
			
			$('#dr_rating').barrating({
		        theme: 'fontawesome-stars',
		        readonly: true,
				showSelectedRating: false,
				showValues: false,
				initialRating: snum
		    });
			
			}).promise().done(function (){
				$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });		
			});
		
		},
		error: function (xhr, message, errorThrown) {
		}
	});
});
