<!DOCTYPE html>
<html>
<head>
<title>Facebook Login JavaScript</title>
<meta charset="euc-kr">
<script>
//login_redirect_facebook.jsp 부분 javascript 내용
//This is called with the results from from FB.getLoginStatus().
function statusChangeCallback(response) {
  if (response.status === 'connected') {      // 페이스북을 통해서 로그인 
    DisplayResult();
  } else if (response.status === 'not_authorized') {      // 페이스북에는 로그인 했지만, 앱에는 로그인이 되어있지 않다 
    document.getElementById('status').innerHTML = 'Please log ' +  'into this app.';
  } else {	  // 페이스북에 로그인 되어있지 않아서, 앱에 로그인이 되어있는지 불확실
    document.getElementById('status').innerHTML = 'Please log ' +   'into Facebook.';
  }
}


window.fbAsyncInit = function() {
	  FB.init({
	    appId      : '974326732910806',
	    cookie     : true,  // enable cookies to allow the server to access 
	                        // the session
	    xfbml      : true,  // parse social plugins on this page
	    version    : 'v3.3' // The Graph API version to use for the call
	  });


FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

};

// SDK를 비동기적으로 호출
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function DisplayResult() {
  console.log('Welcome!  Fetching your information.... ');
  FB.api('/me', {fields: 'name,email'}, function(response) {
    console.log('Successful login for: ' + response.name);
    document.getElementById('status').innerHTML =  "/ 이름 " + response.name + '아이디 ' + response.id + '/ 이메일 ' + response.email ;				
  });
}
</script>

</head>
<body>


<div id="status">
</div>

</body>
</html>
