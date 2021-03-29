var team_board_main_menu = '';
var team_board_sub_menu = '';

var board_category = '자유';
var team_board_sort = 1;

var team_board_count = 0;

var tb_search_temp = '';

$(document).on('pageinit', '#team_board', function() {
	team_board_sort = 1;
	team_board_count = 0;
	
});

$(document).on('pageshow', '#team_board', function() {
	if(board_category == '자유'){
		$('#Go_allBoard').click();
	}
	else if(board_category == '팀원모집'){
		$('#Go_recruitmentBoard').click();
	}
	else{
		$('#Go_withBoard').click();
	}
});

//게시글 새로고침 버튼 클릭시 이미지 회전
$(document).on('click', '#board_refresh_btn', function() {
	$(this).addClass('imgRotate');
	
	setTimeout( 'stop_imgRotate()' , 1000);
	
	team_board_load();
});

//자유 버튼 클릭시
$(document).on('click', '#Go_allBoard', function() {
	if(board_category != '자유') {
		sessionStorage.removeItem('tbLimit');
	}
	$('#team_board_middle').show();
	
	tb_search_temp = '';
	$('#tb_search_date').val('');
	$('#team_board_main_menu').empty();
	
	team_board_main_menu = '<div class="ui-grid-b header_menu_container">'+
								'<div id="Go_allBoard" class="ui-block-a">'+
									'<div class="haeder_menu_div_on">'+
										'<span>자유</span>'+
									'</div>'+
								'</div>'+
								'<div id="Go_recruitmentBoard" class="ui-block-b">'+
									'<div class="haeder_menu_div_base">'+
										'<span>팀원모집</span>'+
									'</div>'+
								'</div>'+
								'<div id="Go_withBoard" class="ui-block-c">'+
									'<div class="haeder_menu_div_base">'+
										'<span>함께공연</span>'+
									'</div>'+
								'</div>'+	
							'</div>';
	
	$('#team_board_main_menu').append(team_board_main_menu);
	
	board_category = $(this).find('span').text();
	team_board_count = 0;
	$('#Go_newBoard').trigger('click');
	
	//게시판 목록 불러오기
	team_board_load();
});

//팀원모집 버튼 클릭시
$(document).on('click', '#Go_recruitmentBoard', function() {
	if(board_category != '팀원모집') {
		sessionStorage.removeItem('tbLimit');
	}
	$('#team_board_middle').show();
	
	tb_search_temp = '';
	$('#tb_search_date').val('');
	$('#team_board_main_menu').empty();
	
	team_board_main_menu = '<div class="ui-grid-b header_menu_container">'+
								'<div id="Go_allBoard" class="ui-block-a">'+
									'<div class="haeder_menu_div_base">'+
										'<span>자유</span>'+
									'</div>'+
								'</div>'+
								'<div id="Go_recruitmentBoard" class="ui-block-b">'+
									'<div class="haeder_menu_div_on">'+
										'<span>팀원모집</span>'+
									'</div>'+
								'</div>'+
								'<div id="Go_withBoard" class="ui-block-c">'+
									'<div class="haeder_menu_div_base">'+
										'<span>함께공연</span>'+
									'</div>'+
								'</div>'+	
							'</div>';
	$('#team_board_main_menu').append(team_board_main_menu);
	
	board_category = $(this).find('span').text();
	team_board_count = 0;
	$('#Go_newBoard').trigger('click');
	//게시판 목록 불러오기
	team_board_load();
});

//함께공연 버튼 클릭시
$(document).on('click', '#Go_withBoard', function() {
	if(board_category != '함께공연') {
		sessionStorage.removeItem('tbLimit');
	}
	$('#team_board_middle').show();
	
	tb_search_temp = '';
	$('#tb_search_date').val('');
	$('#team_board_main_menu').empty();
	
	team_board_main_menu = '<div class="ui-grid-b header_menu_container">'+
								'<div id="Go_allBoard" class="ui-block-a">'+
									'<div class="haeder_menu_div_base">'+
										'<span>자유</span>'+
									'</div>'+
								'</div>'+
								'<div id="Go_recruitmentBoard" class="ui-block-b">'+
									'<div class="haeder_menu_div_base">'+
										'<span>팀원모집</span>'+
									'</div>'+
								'</div>'+
								'<div id="Go_withBoard" class="ui-block-c">'+
									'<div class="haeder_menu_div_on">'+
										'<span>함께공연</span>'+
									'</div>'+
								'</div>'+	
							'</div>';
	$('#team_board_main_menu').append(team_board_main_menu);
	
	board_category = $(this).find('span').text();
	team_board_count = 0;
	$('#Go_newBoard').trigger('click');
	//게시판 목록 불러오기
	team_board_load();
});



////////////////////////////////////////////////////////////////////////////////////////////////////

//최신순 클릭시
$(document).on('click', '#Go_newBoard', function() {
	team_board_sort = 1;
	
	$('#team_board_sub_menu').empty();
	
	team_board_sub_menu = '<div class="ui-grid-b">'+
						  	'<div id="Go_newBoard" class="ui-block-a sub_menu">'+
						  		'<div class="sub_menu_click">'+
								'<span>최신순</span>'+
								'</div>'+
							'</div>'+
							'<div id="Go_likeBoard" class="ui-block-b sub_menu">'+
								'<span>댓글순</span>'+
							'</div>'+
							'<div id="Go_viewBoard" class="ui-block-c sub_menu">'+
								'<span>조회수순</span>'+
							'</div>'+	  				  		
							'</div>';
	
	$('#team_board_sub_menu').append(team_board_sub_menu);
	team_board_count = 0;
	//게시판 목록 불러오기
	team_board_load();
});

//댓글순 클릭시
$(document).on('click', '#Go_likeBoard', function() {
	team_board_sort = 2;
	
	$('#team_board_sub_menu').empty();
	
	team_board_sub_menu = '<div class="ui-grid-b">'+
						  	'<div id="Go_newBoard" class="ui-block-a sub_menu">'+
								'<span>최신순</span>'+
							'</div>'+
							'<div id="Go_likeBoard" class="ui-block-b sub_menu">'+
					  		'<div class="sub_menu_click">'+
								'<span>댓글순</span>'+
							'</div>'+
							'</div>'+
							'<div id="Go_viewBoard" class="ui-block-c sub_menu">'+
								'<span>조회수순</span>'+
							'</div>'+	  				  		
							'</div>';
	
	$('#team_board_sub_menu').append(team_board_sub_menu);
	team_board_count = 0;
	//게시판 목록 불러오기
	team_board_load();
});

//조회수순 클릭시
$(document).on('click', '#Go_viewBoard', function() {
	team_board_sort = 3;
	
	$('#team_board_sub_menu').empty();
	
	team_board_sub_menu = '<div class="ui-grid-b">'+
						  	'<div id="Go_newBoard" class="ui-block-a sub_menu">'+
								'<span>최신순</span>'+
							'</div>'+
							'<div id="Go_likeBoard" class="ui-block-b sub_menu">'+
								'<span>댓글순</span>'+
							'</div>'+
							'<div id="Go_viewBoard" class="ui-block-c sub_menu">'+
					  		'<div class="sub_menu_click">'+
								'<span>조회수순</span>'+
							'</div>'+
							'</div>'+	  				  		
							'</div>';
	
	$('#team_board_sub_menu').append(team_board_sub_menu);
	team_board_count = 0;
	//게시판 목록 불러오기
	team_board_load();
});

//게시판 검색
$(document).on('keyup', '#tb_search_date', function(e) {
	var tb_search = $(this).val();
	
	//엔터쳤을때
	if(e.keyCode == 13){
		tb_search_temp = tb_search;
		team_board_load();
	}
});


//검색 부분 X표시 눌렀을 때 텍스트 초기화 및 버튼 없애기
$(document).on('click', '#team_board_cancle', function() {
	$('#tb_search_date').val('');
	$('#tb_search_date').focus();
	
	if(board_category == '자유'){
		$('#Go_allBoard').click();
	}
	else if(board_category == '팀원모집'){
		$('#Go_recruitmentBoard').click();
	}
	else{
		$('#Go_withBoard').click();
	}
});


//게시글 수정페이지 생성시
$(document).on('pageinit', '#team_board_update', function(){
	const no = sessionStorage.getItem('bupdateNo');
	$.ajax({
		type: "GET",//url: "JSON/test.json",
		url: '/service/team_board/get_team_board.jsp',
		data : {
			board_no: no
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		async: false,
		timeout: 30000,
		success: function(data) {
			var ROOT = $(data).find('ROOT');
			var DATA = $(ROOT).find('DATA');
			
			$(DATA).each(function() {
				var BOARD_TITLE = $(this).find('BOARD_TITLE').text();
				var BOARD_CONTENT = $(this).find('BOARD_CONTENT').text();
				var BOARD_CATEGORY = $(this).find('BOARD_CATEGORY').text();
				
				$('#board_no').val(no);
				
				$('#board_update_title_area').val(BOARD_TITLE);
				$('#board_update_subject_area').val(BOARD_CONTENT);
				
				$("#team-board-update-select").val(BOARD_CATEGORY).prop("selected", true);
				
				if(BOARD_CATEGORY == "1"){
					$('#team-board-update-select-button').find('span').html("일반");
				}
				else if(BOARD_CATEGORY == "2"){
					$('#team-board-update-select-button').find('span').html("팀모집");
				}
				else{
					$('#team-board-update-select-button').find('span').html("함께공연");
				}
			});
		}
	});
});