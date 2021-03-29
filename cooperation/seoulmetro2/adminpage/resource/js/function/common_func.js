on/seoulmetro/adminpage/resource/service/user/loginchk.jsp',
			data: {
				uid: uid
			},
			contentType: "application/xml; charset=utf-8",
			dataType: "xml",
			timeout: 30000,
			success : function(data){
				var ROOT = $(data).find('ROOT');
				var DATA = $(ROOT).find('DATA');
				
				$(DATA).each(function(){
					var LCNT = $(this).find('LCNT').text();
					var DCNT = $(this).find('DCNT').text();
					
					if(LCNT == '0'){
						//로그인 안된 경우
						alert('로그인 해주세요.');
						location.href='/cooperation/seoulmetro/adminpage/view/user/login.jsp';
					} else {
						//로그인 된경우
						if(DCNT == '0'){
							//중복로그인 된 경우
							alert('다른 기기에서 로그인되었습니다. 다시 로그인 해주세요.');
							sessionStorage.removeItem('uid');
							location.href='/cooperation/seoulmetro/adminpage/view/user/login.jsp';
						}
					}
				});
			},
			error: function(x, h, r){
				console.log(x);
				console.log(h);
				console.log(r);
			}
		});
	}
};

const PagingFunction = {
	//totalData 	//총 데이터 수
	//dataPerPage: 10,		//한 페이지에 나타낼 데이터 수
	//pageCount: 10,		//한 블럭에 나타낼 페이지 수
	Paging: function(totalData, dataPerPage, pageCount, currentPage){
		let totalPage = Math.ceil(totalData/dataPerPage);
		let pageGroup = Math.ceil(currentPage/pageCount);
		
		let last = pageGroup * pageCount;
		if(last > totalPage) last = totalPage;
		let first = last - (pageCount-1);
		if(first < 1) first = 1;
		let next = last + 1;
		let prev = first - 1;
		
		let $pagingView = $('#paging');
		
		$pagingView.empty();
		
		let html = '';
		
		if(prev > 0) html += '<p class="mp_num" id="mp_prev"><img src="/img/homepage/common/con_left.png"></p>';
		else html += '<p class="mp_num hidden" id="mp_prev"><img src="/img/homepage/common/con_left.png"></p>';
		
		for(var i=first; i <= last; i++){
			html += '<p class="mp_num ft_13 cursorpointer" id="'+i+'">'+i+'</p>';
		}
		
		if(last < totalPage) html+='<p class="mp_num" id="mp_next"><img src="/img/homepage/common/con_right.png"></p>';
		else html+='<p class="mp_num hidden" id="mp_next"><img src="/img/homepage/common/con_right.png"></p>';
		
		$pagingView.html(html);
		$pagingView.find('#'+currentPage).addClass('page_on');
		
		$('.mp_num').click(function(){
			let $item = $(this);
			let $id = $item.attr('id');
			let selectedPage = $item.text();
			
			if($id == 'mp_next') selectedPage = next;
			if($id == 'mp_prev') selectedPage = prev;
			
			let search = $('#h_search_text').val();
			let url = window.location.pathname + '?currentpage=' + selectedPage + '&search=' + search;
			let nowpage = window.location.pathname.split('/');
			nowpage = nowpage[nowpage.length-1].split('.')[0];
			
			if(nowpage == 'evaluationinfo'){
				let y = $('#ei_year').val();
				let m = $('#ei_month').val();
				
				url += '&y=' + y + '&m=' + m;
			}
			
			location.href=url;
			
			PagingFunction.Paging(totalData, dataPerPage, pageCount, selectedPage);
		});
	}
};