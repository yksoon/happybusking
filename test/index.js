var cropper;

$(document).on('change', '#file', function(){
	readURL(this, 2, 1);
});

$(document).on('change', '#file2', function(){
	readURL(this, 3, 4);
});

const readURL = (input, w, h) => {
	$('#read-loading').show();
	if(input.files && input.files[0]){
		let reader = new FileReader();
		
		reader.onload =  function(e){
			$('#image').attr('src', e.target.result);
			
			const image = document.getElementById('image');

			if(cropper === undefined || cropper === 'undefined'){
				cropper = new Cropper(image, {
					autoCrop: true,  //true 로 설정
					aspectRatio: w / h,
					ready(){
						$('#read-loading').hide();
					},
					crop(event) {
						/*console.log(event.detail.x);
					    console.log(event.detail.y);
					    console.log(event.detail.width);
					    console.log(event.detail.height);
					    console.log(event.detail.rotate);
					    console.log(event.detail.scaleX);
					    console.log(event.detail.scaleY);*/
					},
				});
			}
			cropper.replace(e.target.result);

		}
		reader.readAsDataURL(input.files[0]);
	}
}

const save = (url) => {
	// Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`.
	// The default value for the second parameter of `toBlob` is 'image/png', change it if necessary.
	cropper.getCroppedCanvas().toBlob((blob) => {
	  const formData = new FormData();
	  const filename = createRandomNum() + '.jpeg';

	  // Pass the image file name as the third parameter if necessary.
	  formData.append('croppedImage', blob, filename);
	  
	  uploadFile(blob, 'test', filename, function(f){
		  // url = '/upload/test/';
		  var new_img = url + f;
          
		     var imgSrc = getImagePromise(new_img).then(value => {
		    	 $('#result').attr('src', value);
		     });
	  });

	  
  		//$('#uploading').show();
	  // Use `jQuery.ajax` method for example
	  /*$.ajax('./image_save.jsp', {
	    method: 'POST',
	    data: formData,
	    processData: false,
	    contentType: false,
	    success: function() {
	    },
	    error: function() {
	    	console.log('Upload error');
	    },
	    complete: function(){
	    	setTimeout(function(){
		    	$('#uploading').hide();
		    	$('#result').attr('src', '/upload/'+filename);
	    	}, 3000);
	    }
	  });*/
	}, 'image/jpeg');
	
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

function uploadFile(file, path, filename, callback){
	//id : input file id
	//target : image prev id
	//callback : 이미지 저장 , 불러오기 성공 후 실행할 함수
	//path : 'images/team/team'+no;
	initFirebase();
	$('#uploading').show();
	
	console.log(file);
	
	const storage = firebase.storage();
	const storageRef = storage.ref();
	
	const str = 'upload/'+ path + '/' + filename;
	
	storageRef
			.child(str)
			.put(file)
			.on('state_changed', snapshot => {
			}, error => {
				alert('파일 저장에 실패하였습니다.\n다시 시도해주세요.');
				$('#uploading').hide();
			}, () => {
				storageRef.child(str).getDownloadURL().then(function(url){
					callback(filename);
					$('#uploading').hide();
				}).catch(function(){
					alert('파일 불러오기에 실패하였습니다.\n다시 시도해주세요.');
					$('#uploading').hide();
				});
			}
	);
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

function pad(n, width) {
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function createRandomNum(){
	const date = new Date();
	const y = String(date.getFullYear()).slice(2,4);
	const m = pad(date.getMonth()+1, 2);
	const d = pad(date.getDate(), 2);
	const h = pad(date.getHours(), 2);
	const mi = pad(date.getMinutes(), 2);
	const s = pad(date.getSeconds(), 2);
	
	const r = String(Math.floor(Math.random() * 9998) + 1);
	
	const res = y+m+d+h+mi+s+r;
	
	return res;
}