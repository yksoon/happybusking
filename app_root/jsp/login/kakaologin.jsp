<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/importhaed.jsp" %>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<title>Kakao JavaScript SDK login test</title>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('7c9b2fb8116ff5d69c8ebf09a249bb13');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
             // 로그인 성공시, API를 호출합니다.
             Kakao.API.request({
               url: '/v2/user/me',
               success: function(res) {
                 alert(JSON.stringify(res));
                 /* alert(JSON.stringify(authObj));
	        	 alert(JSON.stringify(res)); //<---- kakao.api.request 에서 불러온 결과값 json형태로 출력
                 alert(JSON.stringify(authObj)); //<----Kakao.Auth.createLoginButton에서 불러온 결과값 json형태로 출력
                 console.log(authObj.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
                 console.log(authObj.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
                 console.log(authObj.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
                 res.properties.nickname으로도 접근 가능 )
                 console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력 
                 */
                 $.ajax({
       				type: "GET",
       				cache: false,
       				url: '/service/join/join_chk.jsp',
       				data:{
       					user_id : response.email,
       				},
       				contentType: "application/xml; charset=utf-8",
       				dataType: "xml",
       				timeout: 30000,
       				success: function(data){
      					var ROOT = $(data).find('ROOT');
       					var DATA = $(ROOT).find('DATA');
       					
       					$(DATA).each(function() {
       						var CNT = $(this).find('CNT').text();
       						if(CNT == '0'){
       							email_overlap = 'N';
       							$.ajax({
       								type: "POST",
       								url: '/service/join/join.jsp',
       								data:{
       									user_active: 'Y',
       									artist_check: 'N',
       									busking_oath: 'N',
       									user_id: authObj.kaccount_email,
       									nickname: authObj.properties['nickname'],
       									login_chk: 'K'
       								},
       								success: function (data) {
       									goJoinComplete(response.email);
       								},
       								error: function(a, b, c) {
       									toHome();
       								}
       							});
       						}
       						
       						if(email_overlap == 'Y'){
       							infoTxtBox('이미 가입된 이메일입니다.');
       							return;
       						}          						
       					});
       				}
       			});
               },
               fail: function(error) {
                 alert(JSON.stringify(error));
               }
             });
           },
           fail: function(err) {
             alert(JSON.stringify(err));
           }
      });
    };
  //]]> */
</script>
<!-- src="demo_iframe.htm" -->

<div id="custom-login-btn-div">
<a id="custom-login-btn" href="javascript:loginWithKakao()">
<img src="/img/login/kakaologin.jpg" width="300"/>
</a>
</div>

</head>
<body>