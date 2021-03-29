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