const CommonFunction = {
	headerHtml: '',
	GetParameterByName: function(name){	//파라미터 값 받아오기
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    let regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	},
	HBottomChange: function(){	//헤더부분 페이지 경로 변경
		let $hbottom = $('#h_bottom');
		//$hbottom.find('.delcontent').remove();
		$hbottom.append(CommonFunction.headerHtml);
	},
	GetNowYear: function(){		//현재 년도 가져오기
		let now = new Date();
		return now.getFullYear();
	},
	GetNowMonth: function(){	//현재 월 가져오기
		let now = new Date();
		return now.getMonth() + 1;
	},
	SetPad: function(n, width){	//자리수 채우기
		//n : 숫자, width : 글자수
		n = n + '';
		return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	},
	SpaceChk: function(str){	//공백 제거
		return str.replace(/ /gi, '');
	},
	addComma: function(str){
		return str.toString().replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	},
	removeComma: function(str){
		return str.replace(/,/g, '');
	},
	DateFormatChange: function(str){	//날짜 포멧 변경
		if(!str) return '';
		let format = '';
		
		str = str.replace(/\s/gi, '');
		
		try{
			if(str.length == 8){
				format = str.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
			}
		} catch(e){
			console.log(e);
			format = str;
		}
		return format;
	},
	dateFormatChange: function(str){	//날짜 형식 변경
		if(!str) return '';
		return str.toString().replace(/[^0-9]/g,'').replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	},
	telFormatChange: function(str){		//전화번호 형식 변경
		if(!str) return '';
		
		let strTemp = str.toString().replace(/ /g, '').replace(/[^0-9]/g,'');
		let strTemp2 = strTemp.substring(0, 2);		
		
		if(strTemp.length <= 9) return strTemp.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
		else if(strTemp.length == 10 && strTemp2 == '02') return strTemp.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
		else if(strTemp.length == 10 && strTemp2 != '02') return strTemp.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
		else if(strTemp.length >= 11) return strTemp.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	},
	changeQuotes: function(str){
		str = str.replace(/;/gi, "");
		str = str.replace(/&/gi, "&amp;");
		str = str.replace(/\'/gi, "&apos;");
		str = str.replace(/\"/gi, "&quot;");
		str = str.replace(/</gi, "&lt;");
		str = str.replace(/>/gi, "&gt;");
		return str;
	}
};