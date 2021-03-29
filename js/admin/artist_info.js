$(document).on('keyup', '#aic_search', function(e){
	if(e.keyCode == 13){
		var str = $(this).val();
		searchArtistInfo(str);
	}
});

$(document).on('click', '.aic_list', function(){
	var uno = $(this).attr('id');
	var aname = $(this).find('#aname').text();
	
	$('#uno').val(uno);
	$('#aname').val(aname);
	$('#artist_name').text(aname);
	
	$('#aic_table').empty();
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/artist_info_detail.jsp',
		data:{
			uno: uno
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			if(DATA.length == 0){
				var html = '<tr>'+
							'<td colspan="4">가입된 팀이 없습니다.</td>'+
						   '</tr>';
				$('#aic_table').append(html);
				return;
			} else {
				var html = '<tr>'+
								'<th>팀번호</th>'+
								'<th>팀명</th>'+
							'</tr>';
				$('#aic_table').append(html);
			}
			
			$(DATA).each(function(i){
				var USER_NO = $(this).find('USER_NO').text();
				var TEAM_NO = $(this).find('TEAM_NO').text();
				var LEADER_CHK = $(this).find('LEADER_CHK').text();
				var MEMBER_REQ_STATUS = $(this).find('MEMBER_REQ_STATUS').text();
				var TEAM_NAME = $(this).find('TEAM_NAME').text();
				var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
				
				if(LEADER_CHK == '1'){
					LEADER_CHK = '리더';
				} else {
					LEADER_CHK = '멤버';
				}
				
				if(MEMBER_REQ_STATUS == '1'){
					MEMBER_REQ_STATUS = '진행중';
				} else if(MEMBER_REQ_STATUS == '2'){
					MEMBER_REQ_STATUS = '수락';
				} else {
					MEMBER_REQ_STATUS = '거절';
				}
				
				
				var html = '<tr>' +
								'<td id="'+TEAM_NO+'">' + '<input type="text" id="aip_tno"  value="'+TEAM_NO+'">' + '</td>' +
								'<td id="aip_tname">' + TEAM_NAME + '</td>' +
							'</tr>';	
			
				
				$('#aic_table').append(html);
			});
		},
		error: function(xhr){
			console.log(xhr);
		},
		complete: function(){
			$('.aic_popup').show();
		}
	});
});

$(document).on('click', '#aic_popup_close', function(){
	$('.aic_popup').hide();
});

$(document).on('keyup', '#aip_tno', function(e){
	if(e.keyCode == 13){
		var str = $(this).val();
		var str2 = $(this).parents('td').attr('id');
		var tname = $('#aip_tname').text();
		
		var conf = confirm(tname + ' 팀의 팀 번호를 ' + str +'로 바꾸시겠습니까?');
		if(!conf){
			return;
		}
		
		$.ajax({
			type: "GET",
			cache: false,
			url: '/service/admin/change_team_no.jsp',
			data:{
				newTno: str,
				oldTno: str2
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			complete : function(){
				alert('변경 완료');
				self.reload();
			}
		});
	}
});

$(document).on('click', '.aic_tcreate_chk_table', function(){
	var ainfoSort = sessionStorage.getItem('ainfoSort');
	if(ainfoSort == null || ainfoSort == 'A'){
		sessionStorage.setItem('ainfoSort', 'OK');
	} else if(ainfoSort == 'OK'){
		sessionStorage.setItem('ainfoSort', 'NO');
	} else if(ainfoSort == 'NO'){
		sessionStorage.setItem('ainfoSort', 'A');
	}
	
	getArtistInfo();
});

function getArtistInfo(){
	var ainfoSort = sessionStorage.getItem('ainfoSort');
	$('#admin_page_container').empty();
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/artist_info_list.jsp',
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var TCOUNT = $(this).find('TCOUNT').text();
				var USER_NO = $(this).find('USER_NO').text();
				var PHONE = $(this).find('PHONE').text();
				var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
				var ID = $(this).find('ID').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				var ARTIST_INTRO = $(this).find('ARTIST_INTRO').text();
				
				if(TCOUNT == '0'){
					//팀 가입 안된사람
					TCOUNT = 'N';
				} else {
					//팀 가입 된사람
					TCOUNT = 'Y';
				}

				
				if(ainfoSort == null || ainfoSort == 'A'){
					if(i===0 || i%2===0) {
						html = '<tr class="aic_list bg_whiteblue" id="'+USER_NO+'">' + 
									'<td>' + (i+1) + '</td>'+
									'<td>' + ID + '</td>' +
									'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
									'<td id="aname">' + ARTIST_NAME + '</td>' +
									'<td>' + TCOUNT+ '</td>' +
									'<td class="aic_phone_table">' + PHONE + '</td>' +
									'<td class="">' + ARTIST_INTRO + '</td>' +
							   '</tr>';
					} else {
						html = '<tr class="aic_list" id="'+USER_NO+'">' + 
									'<td>' + (i+1) + '</td>'+
									'<td>' + ID + '</td>' +
									'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
									'<td id="aname">' + ARTIST_NAME + '</td>' +
									'<td>' + TCOUNT+ '</td>' +
									'<td class="aic_phone_table">' + PHONE + '</td>' +
									'<td class="">' + ARTIST_INTRO + '</td>' +
							   '</tr>';
					}
					$('.aic_table').append(html);
					
				} else if(ainfoSort == 'OK'){
					if(TCOUNT == 'Y'){
						if(i===0 || i%2===0) {
							html = '<tr class="aic_list bg_whiteblue" id="'+USER_NO+'">' + 
										'<td>' + (i+1) + '</td>'+
										'<td>' + ID + '</td>' +
										'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
										'<td id="aname">' + ARTIST_NAME + '</td>' +
										'<td>' + TCOUNT+ '</td>' +
										'<td class="aic_phone_table">' + PHONE + '</td>' +
										'<td class="">' + ARTIST_INTRO + '</td>' +
									'</tr>';
						} else {
								html = '<tr class="aic_list" id="'+USER_NO+'">' + 
											'<td>' + (i+1) + '</td>'+
											'<td>' + ID + '</td>' +
											'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
											'<td id="aname">' + ARTIST_NAME + '</td>' +
											'<td>' + TCOUNT+ '</td>' +
											'<td class="aic_phone_table">' + PHONE + '</td>' +
											'<td class="">' + ARTIST_INTRO + '</td>' +
									   '</tr>';
						}
						$('.aic_table').append(html);
					}
					
				} else if(ainfoSort == 'NO'){
					if(TCOUNT == 'N'){
						if(i===0 || i%2===0) {
							html = '<tr class="aic_list bg_whiteblue" id="'+USER_NO+'">' + 
										'<td>' + (i+1) + '</td>'+
										'<td>' + ID + '</td>' +
										'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
										'<td id="aname">' + ARTIST_NAME + '</td>' +
										'<td>' + TCOUNT+ '</td>' +
										'<td class="aic_phone_table">' + PHONE + '</td>' +
										'<td class="">' + ARTIST_INTRO + '</td>' +
								   '</tr>';
						} else {
							html = '<tr class="aic_list" id="'+USER_NO+'">' + 
										'<td>' + (i+1) + '</td>'+
										'<td>' + ID + '</td>' +
										'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
										'<td id="aname">' + ARTIST_NAME + '</td>' +
										'<td>' + TCOUNT+ '</td>' +
										'<td class="aic_phone_table">' + PHONE + '</td>' +
										'<td class="">' + ARTIST_INTRO + '</td>' +
								   '</tr>';
						}
						
						$('.aic_table').append(html);
					}
					
				}
			});
		}, 
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/artist_info.jsp #artist_info_container');
}

function searchArtistInfo(str){
	$('#admin_page_container').empty();
	$('.aic_table').empty();
	
	var tableHeader =  '<tr>'+
					    '<th>아이디</th>'+ 
						'<th>닉네임</th>'+
						'<th>아티스트명</th>'+
						'<th>연락처</th>'+
					    '<th>주소</th>'+
					  '</tr>';
	$('.aic_table').append(tableHeader);
	
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/admin/artist_info_list.jsp',
		data:{
			str: str
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function(i){
				var TCOUNT = $(this).find('TCOUNT').text();
				var USER_NO = $(this).find('USER_NO').text();
				var PHONE = $(this).find('PHONE').text();
				var ARTIST_NAME = $(this).find('ARTIST_NAME').text();
				var POSTCODE = $(this).find('POSTCODE').text();
				var ADDR = $(this).find('ADDR').text();
				var DETAIL_ADDR = $(this).find('DETAIL_ADDR').text();
				var ID = $(this).find('ID').text();
				var NICKNAME = $(this).find('NICKNAME').text();
				
				var fullAddr = '(' + POSTCODE + ') ' + ADDR + ', ' + DETAIL_ADDR;
				if(TCOUNT == '0'){
					//팀 가입 안된사람
					TCOUNT = 'N';
				} else {
					//팀 가입 된사람
					TCOUNT = 'Y';
				}
				
				if(i===0 || i % 2 === 0) {
					html = '<tr class="aic_list bg_whiteblue" id="'+USER_NO+'">' + 
							'<td>' + (i+1) + '</td>'+
							'<td>' + ID + '</td>' +
							'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
							'<td id="aname">' + ARTIST_NAME + '</td>' +
							'<td>' + TCOUNT+ '</td>' +
							'<td class="aic_phone_table">' + PHONE + '</td>' +
							'<td class="aic_addr_table">' + fullAddr + '</td>' +
					   '</tr>';
				} else {
					html = '<tr class="aic_list" id="'+USER_NO+'">' + 
								'<td>' + (i+1) + '</td>'+
								'<td>' + ID + '</td>' +
								'<td class="aic_nickname_table">' + NICKNAME + '</td>' +
								'<td id="aname">' + ARTIST_NAME + '</td>' +
								'<td>' + TCOUNT+ '</td>' +
								'<td class="aic_phone_table">' + PHONE + '</td>' +
								'<td class="aic_addr_table">' + fullAddr + '</td>' +
						   '</tr>';
				}
				
				
				
				$('.aic_table').append(html);
			});
		}, 
		error: function(xhr){
			console.log(xhr);
		}
	});
	
	$('#admin_page_container').load('/app_admin/artist_info.jsp #artist_info_container');
}