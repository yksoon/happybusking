function showLoading(sh, str){
	if(sh === 'show'){
		$('#loading').show();
	} else {
		$('#loading').hide();
	}
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
	showLoading('show', '저장중입니다');
	
	initFirebase();
	
	const file = $('#'+id)[0].files[0];
	
	//console.log(file);
	
	const storage = firebase.storage();
	const storageRef = storage.ref();
	
	const str = 'upload/'+ path + '/' + file.name;
	
	storageRef
			.child(str)
			.put(file)
			.on('state_changed', snapshot => {
				console.log(snapshot);
			}, error => {
				alert('파일 저장에 실패하였습니다.\n다시 시도해주세요.');
				showLoading('hide', '저장중입니다');
			}, () => {
				storageRef.child(str).getDownloadURL().then(function(url){
					//console.log(url);
					if(target != 'video'){
						$('#'+target).attr('src', url);
					}
					callback();
					showLoading('hide', '저장중입니다');
				}).catch(function(){
					alert('파일 불러오기에 실패하였습니다.\n다시 시도해주세요.');
					showLoading('hide', '저장중입니다');
				});
			}
	);
}

function uploadManyFile(id, target, path, callback){
	//id : input file id
	//target : image prev id
	//callback : 이미지 저장 , 불러오기 성공 후 실행할 함수
	showLoading('show', '저장중입니다');
	
	initFirebase();
	
	const fileInput = document.getElementById(id);
	const files = fileInput.files;
	let file;
	let filename;
	
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
					console.log(snapshot);
				}, error => {
					alert('파일 저장에 실패하였습니다.\n다시 시도해주세요.');
					showLoading('hide', '저장중입니다');
				}, () => {
					storageRef.child(str).getDownloadURL().then(function(url){
						var f = str.split('/');
						f = f[f.length-1];
						callback(url, f);
						showLoading('hide', '저장중입니다');
					}).catch(function(){
						alert('파일 불러오기에 실패하였습니다.\n다시 시도해주세요.');
						showLoading('hide', '저장중입니다');
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
