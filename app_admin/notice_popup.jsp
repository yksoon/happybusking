<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="/css/admin/notice.css" />
<link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<script type="text/javascript" src="/js/admin/index.js" ></script>
<script type="text/javascript" src="/js/admin/notice.js" ></script>

<link rel="stylesheet" href="/js/dist/summernote.css">
<script type="text/javascript" src="/js/dist/summernote.js"></script>


<title>공지사항 작성 팝업</title>
</head>
<body style="text-align: center;">
	<div class="npc_p_title">공지 대상</div>
	<select class="npc_p_type" id="nt_type">
		<option value="N">전체</option>
		<option value="A">아티스트</option>
		<option value="T">팀</option>
		<option value="M">서울메트로</option>
	</select>
	
	<div class="npc_p_title">공지사항 제목</div>
	<input type="text" id="nt_title">
	
	<div class="npc_p_title">공지사항 내용</div>
	<form name="npc_form" action="./summernote_insert.jsp" method="post">
		<textarea id="summernote"></textarea>
	</form>
	
	<div class="npc_p_btn" id="npc_p_btn">작성</div>
	<input type="hidden" id="ntNo">
</body>

<script type="text/javascript">
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 500,
			callbacks:{
				onImageUpload: function(files, editor, welEditable){
					console.log('upload success');
					sendFile(files[0], editor, welEditable);
				}
			},
			lang: 'ko-KR'
		});
		
		var noticeNo = getParameterByName('noticeNo');
		
		if(noticeNo != null && noticeNo != ''){
			getNoticeDetail(noticeNo);
		}
	});
	
	function getNoticeDetail(noticeNo){
		$('#ntNo').val(noticeNo);
		
		$.ajax({
			type: "GET",//url: "JSON/test.json",
			cache: false,
			url: '/service/admin/get_notice_detail.jsp?ntNo='+noticeNo,
			processData: false,
			contentType: false,
			dataType: "xml",
			async: false,
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var NT_TYPE = $(this).find('NT_TYPE').text();
					var NT_TITLE = $(this).find('NT_TITLE').text();
					var NT_CONTENT = $(this).find('NT_CONTENT').text();
					$('#nt_type').val(NT_TYPE);
					$('#nt_title').val(NT_TITLE);
					$('#summernote').summernote('code', NT_CONTENT);
				});
			},
			error: function(xhr){
				console.log(xhr);
			}
		});
	}
	
	function sendFile(file, editor, welEditable){
		data = new FormData();
		data.append('uploadfile', file);
		$.ajax({
			data: data,
			type: 'post',
			url: './summernote_insert.jsp',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var url = $(this).find('url').text();
					
					url = 'https://www.happybusking.com/upload/user/user0/' + url;
					
					var image = $('<img>').attr('src', url);
					$('#summernote').summernote('insertNode', image[0]);
				});
			}
		});
	}

	function getParameterByName(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
</script>
</html>