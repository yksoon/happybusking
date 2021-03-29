$(document).on('pageinit', '#share_busking_list', function(){
	var keyword = sessionStorage.getItem('bzlKeyword');
	if(keyword != null){
		$('#bzl_search').val(keyword);
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_area_code.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#bzl_header_ul').empty();
			
			var sBzlText = sessionStorage.getItem('bzlArea');
			
			if(sBzlText == null || sBzlText == '전국'){
				var li_content = '<li class="bzl_header_li area_on" value="전국"><div>전국</div></li>';
			} else {
				var li_content = '<li class="bzl_header_li" value="전국"><div>전국</div></li>';
			}
			
			$('#bzl_header_ul').append(li_content);
			
			$(DATA).each(function(i) {
				var AREA_NAME = $(this).find("AREA_NAME").text();
				var AREA_VALUE = $(this).find('AREA_VALUE').text();
				
				if(sBzlText != null && sBzlText == AREA_NAME){
					var li_content = '<li class="bzl_header_li area_on" value="'+AREA_VALUE+'"><div>'+AREA_NAME+'</div></li>';
				} else {
					var li_content = '<li class="bzl_header_li" value="'+AREA_VALUE+'"><div>'+AREA_NAME+'</div></li>';
				}
				
				$('#bzl_header_ul').append(li_content);
				
		}).promise().done(function (){
			var carousel;

    	    carousel = $("#bzl_header_ul");
    	    carousel.itemslide(
    	    	{
    	    		left_sided: true,
    	    		disable_clicktoslide: true
    	    	}
    	    );
    	    
    	    var sBzlText = sessionStorage.getItem('bzlArea');
    	    var sBzlKeyword = sessionStorage.getItem('bzlKeyword');
    	    var limit = sessionStorage.getItem('bzlLimit');
    	    var lastlimit = 0;
    	    
    	    if(sBzlText == null) sBzlText = '전국';
    	    if(sBzlKeyword == null) sBzlKeyword = '';
    	    if(limit == null){
    	    	limit = 0;
    	    } else if (limit != 0){
    	    	lastlimit = (limit * 1) + 20;
    	    }
    	    
    	    getBuskingzoneList(sBzlText, sBzlKeyword, limit, lastlimit);
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});	
});


$(document).on('click', '.bzl_header_li', function(){
	$('.bzl_header_li').removeClass('area_on');
	$(this).addClass('area_on');
	var sBzlText = $(this).text();
	
	sessionStorage.setItem('bzlArea', sBzlText);
	

    var sBzlKeyword = sessionStorage.getItem('bzlKeyword');
    if(sBzlKeyword == null) sBzlKeyword = '';
    
    sessionStorage.setItem('bzlLimit', 0);
    
    sessionStorage.removeItem('bz_scroll');
    
	getBuskingzoneList(sBzlText, sBzlKeyword, 0, 0);
});

$(document).on('keyup', '#bzl_search', function(e){
	var str = $(this).val();
	
	if(e.keyCode == 13){
		sessionStorage.setItem('bzlKeyword', str);
		var sBzlText = sessionStorage.getItem('bzlArea');
		if(sBzlText == null) sBzlText = '전국';
		
		sessionStorage.setItem('bzlLimit', 0);
		
		sessionStorage.removeItem('bz_scroll');
		
		getBuskingzoneList(sBzlText, str, 0, 0);
	}
});


$(document).on('click', '#bzl_search_cancel_btn', function(){
	$('#bzl_search').val('');
	sessionStorage.removeItem('bzlKeyword');
	
	var sBzlText = sessionStorage.getItem('bzlArea');
	if(sBzlText == null) sBzlText = '전국';
	
	sessionStorage.removeItem('bz_scroll');
	
	sessionStorage.setItem('bzlLimit', 0);
	
	getBuskingzoneList(sBzlText, '', 0, 0);
});