$(document).on('pageinit', '#rating_list', function() {
	var user_no = $('#user_no').val();
	//$('#rating_list_header').empty();
	
	var rating_list_header = '<div id="rl_team_select_div">'+
									'<select name="rl_team_select" id="rl_team_select">'+
										'<option selected disabled hidden>팀 이름을 선택해주세요</option>'+
									'</select>'+
								  '</div>';
	$('.rating_list_header').html(rating_list_header);
	//속한 팀 전체 리스트 불러오기
	$.ajax({
		type: "GET",
		cache: false,
		url: '/service/common/get_team_select.jsp',
		data: {
			user_no : user_no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		success : function(data){
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');

			$(DATA).each(function(i) {
				var TEAM_NAME = $(this).find("TEAM_NAME").text();
				var TEAM_NO = $(this).find("TEAM_NO").text();
				var option_content = '<option value="'+TEAM_NO+'">'+TEAM_NAME+'</option>';
				$('#rl_team_select').append(option_content);
				//$('#sc_area li:firstchild').css('font-weight', 'bold');
				//$('#rl_team_select_div').selectmenu('refresh', true);
				
		}).promise().done(function (){
			$.mobile.loading( 'hide', { text: 'foo', textVisible: false, theme: 'z', html: "" });
		});
		},//end success
		error: function (xhr, message, errorThrown) {
			//hideLoading();
		} // end error
	});
});

$(document).on('change', '#rl_team_select', function() {
	var team_name = $("select option:selected").text();
	var team_no = $(this).val();
	//팀 이름 클릭시 별점 내역 조회
	get_rating_list(team_no);
});

var cancle_pf_no;
function perform_cancle(pf_no) {
	confirmBox('공연 일정을 취소하시겠습니까 ? ', go_perform_cancle);
	cancle_pf_no = pf_no;
}