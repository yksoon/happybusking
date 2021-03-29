function getKoicaApplyList(){
	getFestivalApplyList();
	getFestivalApplyFilter();
	$('#admin_page_container').load('/app_admin/festival_apply.jsp #koica_apply_container');
}

$(document).on('click', '.kacp_item', function(){
	var str = $(this).attr('id');
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/festival_apply_detail.jsp',
		data: {
			kid: str
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(){
				var KNAME = $(this).find('KNAME').text();
				var KBIRTH = $(this).find('KBIRTH').text();
				var KPOSTCODE = $(this).find('KPOSTCODE').text();
				var KADDR = $(this).find('KADDR').text();
				var KDETAILADDR = $(this).find('KDETAILADDR').text();
				var KEMAIL = $(this).find('KEMAIL').text();
				var KTEL = $(this).find('KTEL').text();
				var KTEAM = $(this).find('KTEAM').text();
				var KGENRE = $(this).find('KGENRE').text();
				var KTYPE = $(this).find('KTYPE').text();
				var KINFO = $(this).find('KINFO').text();
				var KURL = $(this).find('KURL').text();
				var KDATE = $(this).find('KDATE').text();
				var KGUBUN = $(this).find('KGUBUN').text();
				
				var address = '(' + KPOSTCODE + ') ' +  KADDR + ',' + KDETAILADDR;
				
				
				$('#kacp_name').text(KNAME);
				$('#kacp_birth').text(KBIRTH);
				$('#kacp_addr').text(address);
				$('#kacp_email').text(KEMAIL);
				$('#kacp_tel').text(KTEL);
				$('#kacp_tname').text(KTEAM);
				$('#kacp_genre').text(KGENRE);
				$('#kacp_type').text(KTYPE);
				$('#kacp_info').text(KINFO);
				$('#kacp_url').text(KURL);
				$('#kacp_date').text(KDATE);
				$('#kacp_area').text(KGUBUN);
			});
		},
		complete: function(){
			$('.kac_popup_background').show();
			$('.kac_popup').show();
		}
	});
});

$(document).on('click', '.kac_popup_background', function(){
	$('.kac_popup_background').hide();
	$('.kac_popup').hide();
	$('.kac_festival_change_popup').hide();
	$('.kac_festival_insert_popup').hide();
});

$(document).on('click', '#kac_change_btn', function(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/get_festival_rec.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				alert('공연 모집을 등록해주세요. ');
				return;
			} else {
				$('#kac_fcp').empty();
				var th = '<tr><th>공연구분</th><th>공연이름</th><th>모집여부</th><th>등록일</th></tr>';
				$('#kac_fcp').append(th);
			}
			
			$(DATA).each(function(i){
				var FRID = $(this).find('FRID').text();
				var FRGUBUN = $(this).find('FRGUBUN').text();
				var FRNAME = $(this).find('FRNAME').text();
				var FRSTATE = $(this).find('FRSTATE').text();
				var FRDATE = $(this).find('FRDATE').text();
				
				var option;
				
				if(FRSTATE == 'Y'){
					option = '<option value="Y" selected="selected">Y</option><option value="N">N</option>';
				} else {
					option = '<option value="Y">Y</option><option value="N" selected="selected">N</option>';
				}
				
				if(i===0 || i%2===0){
					var tr = '<tr class="bg_whiteblue"><td>'+FRGUBUN+'</td><td>'+FRNAME+'</td><td><select class="kac_fcp_select" id="'+FRID+'">'+option+'</select></td><td>'+FRDATE+'</td></tr>';
				} else {
					var tr = '<tr><td>'+FRGUBUN+'</td><td>'+FRNAME+'</td><td><select class="kac_fcp_select" id="'+FRID+'">'+option+'</select></td><td>'+FRDATE+'</td></tr>';
				}
				
				
				$('#kac_fcp').append(tr);
			});
		},
		complete: function(){
			$('.kac_popup_background').show();
			$('.kac_popup').show();
		}
	});
	
	$('.kac_popup_background').show();
	$('.kac_festival_change_popup').show();
});

$(document).on('click', '#kac_insert_btn', function(){
	$('.kac_popup_background').show();
	$('.kac_festival_insert_popup').show();
});

$(document).on('change', '.kac_fcp_select', function(){
	var target = $(this).attr('id');
	var value = $(this).val();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/update_festival_rec.jsp',
		data: {
			frid: target,
			frstate: value
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000
	});
});

$(document).on('change', '#kac_filter', function(){
	var str = $(this).val();
	getFestivalApplyList(str);
});


$(document).on('click', '#kac_fip_apply_btn', function(){
	var frgubun = changeQuotes($('#frgubun').val());
	var frname = changeQuotes($('#frname').val());
	
	if(breakCheck(frgubun) == ''){
		alert('분류를 입력해주세요.');
		$('#frgubun').val('');
		$('#frgubun').focus();
		return;
	} else if(breakCheck(frname) == ''){
		alert('이름을 입력해주세요.');
		$('#frname').val('');
		$('#frname').focus();
		return;
	}
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/insert_festival_rec.jsp',
		data: {
			frgubun: frgubun,
			frname: frname
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(){
			alert('등록 완료');
			getFestivalApplyFilter();

			$('.kac_popup_background').hide();
			$('.kac_festival_insert_popup').hide();
		}
	});
});


function getFestivalApplyList(filter){
	$('.kac_table').empty();
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/festival_apply_list.jsp',
		data: {
			filter: filter
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			var header =  '<tr>'+
							'<th style="width:55px;">회원여부</th>'+
							'<th style="width:55px;">신청공연</th>'+
							'<th style="width:80px;">이름</th>'+
							'<th style="width:70px;">생일</th>'+
						    '<th style="width:250px;">주소</th>'+
						    '<th style="width:170px;">이메일</th>'+
						    '<th style="width:95px;">전화번호</th>'+
						    '<th>팀이름</th>'+
						    '<th>장르</th>'+
						    '<th style="width:45px;">팀구성</th>'+
						    '<th>팀 정보</th>'+
						    '<th>영상 URL</th>'+
						    '<th>신청일</th>'+
						  '</tr>';
			$('.kac_table').append(header);
			
			
			if(DATA.length == 0){
				$('.kac_table').append('<tr><td colspan="13">신청자가 없습니다.</td></tr>');
				return;
			}
			
			$(DATA).each(function(i){
				var KID = $(this).find('KID').text();
				var KUSERCHK = $(this).find('KUSERCHK').text();
				var KNAME = $(this).find('KNAME').text();
				var KBIRTH = $(this).find('KBIRTH').text();
				var KPOSTCODE = $(this).find('KPOSTCODE').text();
				var KADDR = $(this).find('KADDR').text();
				var KDETAILADDR = $(this).find('KDETAILADDR').text();
				var KEMAIL = $(this).find('KEMAIL').text();
				var KTEL = $(this).find('KTEL').text();
				var KTEAM = $(this).find('KTEAM').text();
				var KGENRE = $(this).find('KGENRE').text();
				var KTYPE = $(this).find('KTYPE').text();
				var KINFO = $(this).find('KINFO').text();
				var KURL = $(this).find('KURL').text();
				var KDATE = $(this).find('KDATE').text();
				var KGUBUN = $(this).find('KGUBUN').text();
				
				var address = '(' + KPOSTCODE + ') ' +  KADDR + ',' + KDETAILADDR;
				
				if(i===0 || i%2===0){
					var html =   '<tr class="kacp_item bg_whiteblue" id="'+KID+'">'+
									'<td>'+KUSERCHK+'</td>'+ 
									'<td>'+KGUBUN+'</td>'+ 
								    '<td>'+KNAME+'</td>'+ 
									'<td>'+KBIRTH+'</td>'+
									'<td>'+address+'</td>'+
									'<td>'+KEMAIL+'</td>'+
								    '<td>'+KTEL+'</td>'+
								    '<td>'+KTEAM+'</td>'+ 
									'<td>'+KGENRE+'</td>'+
									'<td>'+KTYPE+'</td>'+
									'<td style="text-overflow: ellipsis; white-space: nowrap; word-wrap: normal; overflow: hidden;">'+KINFO+'</td>'+
								    '<td>'+KURL+'</td>'+
								    '<td>'+KDATE+'</td>'+ 
								  '</tr>';
				} else {
					var html =   '<tr class="kacp_item" id="'+KID+'">'+
									'<td>'+KUSERCHK+'</td>'+ 
									'<td>'+KGUBUN+'</td>'+ 
								    '<td>'+KNAME+'</td>'+ 
									'<td>'+KBIRTH+'</td>'+
									'<td>'+address+'</td>'+
									'<td>'+KEMAIL+'</td>'+
								    '<td>'+KTEL+'</td>'+
								    '<td>'+KTEAM+'</td>'+ 
									'<td>'+KGENRE+'</td>'+
									'<td>'+KTYPE+'</td>'+
									'<td style="text-overflow: ellipsis; white-space: nowrap; word-wrap: normal; overflow: hidden;">'+KINFO+'</td>'+
								    '<td>'+KURL+'</td>'+
								    '<td>'+KDATE+'</td>'+ 
								  '</tr>';
				}
				
				
				
				$('.kac_table').append(html);
			});
		}
	});
}


function getFestivalApplyFilter(){
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/get_festival_rec.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$('#kac_filter').empty();
			$('#kac_filter').append('<option value="전체" selected="selected">전체</option>');
			
			
			$(DATA).each(function(){
				var FRID = $(this).find('FRID').text();
				var FRGUBUN = $(this).find('FRGUBUN').text();
				var FRNAME = $(this).find('FRNAME').text();
				var FRSTATE = $(this).find('FRSTATE').text();
				var FRDATE = $(this).find('FRDATE').text();
				
				$('#kac_filter').append('<option value="'+FRGUBUN+'">'+FRGUBUN+'</option>');
			});
		}
	});
}