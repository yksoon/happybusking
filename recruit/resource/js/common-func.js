const onLoad = () => {
	/*showLoading('로딩중입니다.');
	setTimeout(() => {
		hideLoading();
	}, 3000);*/
	
	const nowPage = getParam('np');
	const loc = getParam('plocation');
	
	if(loc === 'app'){
		$('#login-text').html('공모등록을 위하여 재로그인이 필요합니다.');
	}
	
	$('.header-menu').find('.menu').removeClass('on');
	
	if(nowPage === 'join') {
		$('#npjoin').addClass('on');
	} else if(nowPage === 'reg') {
		$('#npreg').addClass('on');
	} else if(nowPage === 'mypbi') {
		$('#npmypbi').addClass('on');
	} else if(nowPage === 'applicant') {
		$('#npapplicant').addClass('on');
	} else {
		$('#nplogin').addClass('on');
	}
	
	if(nowPage === 'reg'){
		$('.hcenter').html('새 공모 등록');
	} else if(nowPage === 'regu'){
		$('.hcenter').html('내 공고 수정');
	} else if(nowPage === 'al'){
		$('.hcenter').html('신청자 목록');
	} else if(nowPage === 'ad' || nowPage === 'sd'){
		$('.hcenter').html('신청자 상세');
	} else if(nowPage === 'sl'){
		$('.hcenter').html('채점결과보기');
	} else if(nowPage === 'mp'){
		$('.hcenter').html('마이페이지');
	} else if(nowPage === 'login'){
		$('.hcenter').html('로그인');
	} else if(nowPage === 'join'){
		$('.hcenter').html('회원가입');
	} else if(nowPage === 'fpw'){
		$('.hcenter').html('비밀번호 찾기');
	}
}

const showLoading = (msg) => {
	$('#loading').find('#loading-msg').html(msg);
	$('#loading').show();
}

const hideLoading = () => {
	$('#loading').hide();
}

function getCookie(name) {
    name = new RegExp(name + '=([^;]*)');
    return name.test(document.cookie) ? unescape(RegExp.$1) : '';
}

const getParam = (sname) => {
    var params = location.search.substr(location.search.indexOf("?") + 1);
    var sval = "";
    params = params.split("&");
    for (var i = 0; i < params.length; i++) {
        temp = params[i].split("=");
        if ([temp[0]] == sname) { sval = temp[1]; }
    }
    return sval;
}

const spaceBreak = (obj) => {
	const str = obj.value;
	obj.value = str.replace(/ /gi, '');
}

const spaceChk = (str) => {
	return str.replace(/ /gi, '');
}

const dateFormatChange = (obj) => {	//날짜 형식 변경
	const str = obj.value;
	obj.value = str.toString().replace(/[^0-9]/g,'').replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
}

const telFormatChange = (obj) => {		//전화번호 형식 변경
	const str = obj.value;
	if(!str) obj.value = '';
	
	let strTemp = str.toString().replace(/ /g, '').replace(/[^0-9]/g,'');
	let strTemp2 = strTemp.substring(0, 2);		
	
	if(strTemp.length <= 9) obj.value =  strTemp.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
	else if(strTemp.length == 10 && strTemp2 == '02') obj.value = strTemp.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
	else if(strTemp.length == 10 && strTemp2 != '02') obj.value = strTemp.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
	else if(strTemp.length >= 11) obj.value = strTemp.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
}
const changeQuotes = (str) => {
	str = str.replace(/;/gi, "");
	str = str.replace(/&/gi, "&amp;");
	str = str.replace(/\'/gi, "&apos;");
	str = str.replace(/\"/gi, "&quot;");
	str = str.replace(/</gi, "&lt;");
	str = str.replace(/>/gi, "&gt;");
	return str;
}

//카카오 지도 불러오기
const getKakaoMap = (x, y) =>{
	$('#map').empty();
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
		center: new kakao.maps.LatLng(x, y), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	map = new kakao.maps.Map(mapContainer, mapOption); 
	
	//지도를 클릭한 위치에 표출할 마커
	var marker = new kakao.maps.Marker({
		// 초기에는 지도 중심부에 마커 생성
		position: map.getCenter()
	});
	markers.push(marker);
	marker.setMap(map);
	
	// 지도 클릭 이벤트 
	kakao.maps.event.addListener(map, 'click', function(e){
		let latlng = e.latLng;
		
		searchDetailAddrFromCoords(latlng, function(res, status){
			if(status === kakao.maps.services.Status.OK){ //주소 검색 성공
				let addr = !!res[0].road_address ? res[0].road_address.address_name : res[0].address.address_name;
				$('#address').val(addr);
				$('#detailaddress').val('');
				
				lat = latlng.getLat();
				lng = latlng.getLng();
				
				addMarkers(lat, lng);
				
			} else { //주소 검색 실패
				alert('주소 검색에 실패했습니다. 다시 시도해주세요');
				return;
			}
		});
	});
}

const addMarkers = (lat, lng) => {
	let marker = new kakao.maps.Marker({
		position: new kakao.maps.LatLng(lat, lng)
	});
	
	markers.push(marker);
	removeMarkers();

	marker.setMap(map);
	
	$('#lat').val(lat);
	$('#lng').val(lng);
}

const removeMarkers = () =>{
	for(let i=0; i<markers.length; i++){
		markers[i].setMap(null);
	}
}

const searchDetailAddrFromCoords = (latlng, callback) => {
	geocoder.coord2Address(latlng.getLng(), latlng.getLat(), callback);
}

const serchGeocoderFromAddr = (addr) => {
	geocoder.addressSearch(addr, function(res, status){
		if(status === kakao.maps.services.Status.OK){	//정상 호출
			let lat = res[0].y;
			let lng = res[0].x;
			
			let coords = new kakao.maps.LatLng(lat, lng);
			addMarkers(lat, lng);
			
			map.setCenter(coords);
		} else { //에러
			alert('좌표 검색에 실패했습니다. 지도에서 클릭해주세요.');
			return;
		}
	});
}

const searchAddrFromText = () =>{
	let q = $('#address').val();
	new daum.Postcode({
        oncomplete: function(data) {
            let addr = '';
            let extraAddr = '';
            
            if(data.userSelectedType === 'R'){
            	addr = data.roadAddress;
            } else {
            	addr = data.jibunAddress;
            }
            
            if(data.userSelectedType === 'R'){
            	if(data.bname != '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
            	
            	if(data.buildingName !== '' && data.spartment === 'Y'){
            		extraAddr += (extraAddr !== '' ? ',' + data.buildingName : data.buildingName);
            	}
            	
            	if(extraAddr !== ''){
            		extraAddr = ' (' + extraAddr + ')';
            	}
            	
            	document.getElementById('detailaddress').value = extraAddr;
            } else {
            	document.getElementById('detailaddress').value = '';
            }
            
            document.getElementById('address').value = addr;
            
            document.getElementById('detailaddress').focus();
            
            serchGeocoderFromAddr(addr);
        }
    }).open({
    	q: q
    });
}

const addComma = (obj) =>{
	const str = String(obj.value);
	obj.value = str.toString().replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

const removeComma = (str) =>{
	return str.replace(/,/g, '');
}

const initFirebase = () => {
	var firebaseConfig = {
	  apiKey: "AIzaSyDL2WVpKQkBmSHJ1Sld0LZhONyrFLoCShM",
	  authDomain: "happybusking.firebaseapp.com",
	  databaseURL: "https://happybusking.firebaseio.com",
	  projectId: "happybusking",
	  storageBucket: "happybusking.appspot.com",
	  appID: "1:832071675001:android:822e4e2908e642b1",
	};

	if(!firebase.apps.length){
		firebase.initializeApp(firebaseConfig);
	}
}

function uploadFile(id, target, path, callback){
	//id : input file id
	//target : image prev id
	//callback : 이미지 저장 , 불러오기 성공 후 실행할 함수
	//path : 'images/team/team'+no;
	const leng = $('#'+id)[0].files.length;
	if(leng < 1) return;
	
	
	showLoading('저장중입니다');
	
	initFirebase();
	
	const file = $('#'+id)[0].files[0];
	
	const storage = firebase.storage();
	const storageRef = storage.ref();
	
	const str = 'upload/'+ path + '/' + file.name;
	
	storageRef
			.child(str)
			.put(file)
			.on('state_changed', snapshot => {
			}, error => {
				alert('파일 저장에 실패하였습니다.\n다시 시도해주세요.');
				hideLoading();
			}, () => {
				storageRef.child(str).getDownloadURL().then(function(url){
					//console.log(url);
					if(target != 'video' && target != 'none'){
						$('#'+target).attr('src', url);
					}
					callback(file.name);
					hideLoading();
				}).catch(function(){
					alert('파일 불러오기에 실패하였습니다.\n다시 시도해주세요.');
					hideLoading();
				});
			}
	);
}
 
function uploadManyFile(id, target, path, callback){
	//id : input file id
	//target : image prev id
	//callback : 이미지 저장 , 불러오기 성공 후 실행할 함수
	
	const fileInput = document.getElementById(id);
	const files = fileInput.files;
	let file;
	let filename;
	
	if(files.length < 1) return;
	
	initFirebase();
	showLoading('저장중입니다');
	
	for(var i=0; i < files.length; i++){
		file = files[i];
		filename = file.name;
		
		const storage = firebase.storage();
		const storageRef = storage.ref();
		
		const str = 'upload/'+ path + '/' + filename;
		
		storageRef
				.child(str)
				.put(file)
				.on('state_changed', snapshot => {
				}, error => {
					alert('파일 저장에 실패하였습니다.\n다시 시도해주세요.');
					hideLoading();
				}, () => {
					storageRef.child(str).getDownloadURL().then(function(url){
						var f = str.split('/');
						f = f[f.length-1];
						callback(url, f);
						hideLoading();
					}).catch(function(){
						alert('파일 불러오기에 실패하였습니다.\n다시 시도해주세요.');
						hideLoading();
					});
				}
		);
	}
}

function getImagePromise(str){
	/*
	사용 예시
	 var new_img = 'upload/images/team/team' + TEAM_NO + "/" + PF_IMG;
                
     var imgSrc = getImagePromise(new_img).then(value => {
		$('#mpimg'+i).attr('src', value);
     });
	*/
	
    initFirebase();
    
	return new Promise(function(resolve, reject){
		const storage = firebase.storage();
		const storageRef = storage.ref();
		
		storageRef.child(str).getDownloadURL().then(function(url){
			resolve(url);
		}).catch(function(){
			reject();
		});
	});
}

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
		
		if(prev > 0) html += '<p class="mp_num mp_btn" id="mp_prev"><img src="/img/homepage/common/con_left.png"></p>';
		else html += '<p class="hidden mp_num mp_btn" id="mp_prev"><img src="/img/homepage/common/con_left.png"></p>';
		
		for(var i=first; i <= last; i++){
			html += '<p class="mp_num ft_12 cursorpointer" id="'+i+'">'+i+'</p>';
		}
		
		if(last < totalPage) html+='<p class="mp_num mp_btn" id="mp_next"><img src="/img/homepage/common/con_right.png"></p>';
		else html+='<p class="hidden mp_num mp_btn" id="mp_next"><img src="/img/homepage/common/con_right.png"></p>';
		
		$pagingView.html(html);
		$pagingView.find('#'+currentPage).addClass('page_on');
		
		$('.mp_num').click(function(){
			let $item = $(this);
			let $id = $item.attr('id');
			let selectedPage = $item.text();
			
			if($id == 'mp_next') selectedPage = next;
			if($id == 'mp_prev') selectedPage = prev;
			
			let search = $('#h_search_text').val();
			let wl = window.location.href;
			let url = wl.split('&currentpage=')[0];
			
			let nowpage = window.location.pathname.split('/');
			nowpage = nowpage[nowpage.length-1].split('.')[0];
			
			if(nowpage == ''){
				url = wl.split('?currentpage=')[0];
				url += '?currentpage=' + selectedPage + '&search=' + search;
			} else {
				url += '&currentpage=' + selectedPage + '&search=' + search;
			}
			
			location.href=url;
			
			PagingFunction.Paging(totalData, dataPerPage, pageCount, selectedPage);
		});
	}
}

const handerMoveExplan = () => {
	let explan = sessionStorage.getItem('explan');
	
	if(explan === null || explan === 'null' || explan === '') explan = '1';
	
	$('.rs-body').addClass('hidden');
	$('.rsm-'+explan).removeClass('hidden');
	
	$('.rs-menu').removeClass('rs-on');
	$('#rsm-'+explan).addClass('rs-on');
	
	
	if(explan === '1') {
		$('#rs-prev').addClass('non-click');
		$('#rs-prev').find('img').attr('src', '/recruit/resource/img/web/leftarrow-lgray.png');
		$('#rs-next').removeClass('non-click');
		$('#rs-next').find('img').attr('src', '/recruit/resource/img/web/rightarrow-gray.png');
	} else if(explan === '5'){
		$('#rs-next').addClass('non-click');
		$('#rs-next').find('img').attr('src', '/recruit/resource/img/web/rightarrow-lgray.png');
		$('#rs-prev').removeClass('non-click');
		$('#rs-prev').find('img').attr('src', '/recruit/resource/img/web/leftarrow-gray.png');
	} else {
		$('#rs-prev').removeClass('non-click');
		$('#rs-next').removeClass('non-click');
		$('#rs-prev').find('img').attr('src', '/recruit/resource/img/web/leftarrow-gray.png');
		$('#rs-next').find('img').attr('src', '/recruit/resource/img/web/rightarrow-gray.png');
	}
}

const handlerOpenQrPopup = (str) => {
	$('#rs-app-qr-img').attr('src', str);
	$('.rs-app-qr').show();
}

const handlerCloseQrPopup = () => {
	$('.rs-app-qr').hide();
}


const oneSend = (id, msg) => {
	$.ajax({
		type: "GET",
		cache: false,
		async: false,
		url: '/recruit/resource/service/common/sendPush.jsp',
		data: {
			no: id,
			body: msg
		},
		contentType: "application/xml; charset=utf-8",
		dataType: "xml",
		timeout: 30000,
		complete: function(data){
			history.go(0);
		}
	});
}

function changeFileName(str){
	let arr1 = str.split('.');
	let exe = arr1[arr1.length-1];
	
	const fname = arr1[0] + '_400x400.' + exe;
	return fname;
}