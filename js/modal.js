function infoBox(txt, callbackMethod, jsonData){
    modal({
        type: 'success',
        title: '알림',
        text: txt,
        size: 'small',
        buttons: [{
            text: '확인', //Button Text
            val: 'ok', //Button Value
            eKey: true, //Enter Keypress
            addClass: 'btn-large', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
        }, ],        
        callback: function(result) {
        	if(result){
        		callbackMethod(jsonData);
            }
        }

        
    });
}

function infoBoxChk(txt, callbackMethod, callbackMethod2, jsonData){
    modal({
        type: 'success',
        title: '알림',
        text: txt,
        size: 'small',
        buttons: [{
            text: '확인', //Button Text
            val: 'ok', //Button Value
            eKey: true, //Enter Keypress
            addClass: 'btn-large', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
        }, ],        
        callback: function(result) {
        	if(result){
        		callbackMethod(jsonData);
            }else{
            	callbackMethod2(jsonData);
            }
        }

        
    });
}

 
function infoTxtBox(txt){
    modal({
        type: 'success',
        title: '알림',
        text: txt,
        size: 'small',
        buttons: [{
            text: '확인', //Button Text
            val: 'ok', //Button Value
            eKey: true, //Enter Keypress
            addClass: 'btn-large', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
        }, ]
        
    });
}

function confirmBox(txt, callbackMethod, jsonData){
    modal({
        type: 'confirm',
        title: '알림',
        text: txt,
        size: 'small',
        buttonText: {
            yes: '확인',
            cancel: '취소'
        },
        callback: function(result) {
        	if(result){
        		callbackMethod(jsonData);
            }
        }

        
    });
}

function confirmBox2(txt, callbackMethod, jsonData){
    modal({
        type: 'confirm',
        title: '알림',
        text: txt,
        size: 'small',
        buttonText: {
            yes: '확인',
            cancel: '취소'
        },
        callback: function(result) {
        	if(result){
        		callbackMethod(jsonData);
            }
        }

        
    });
}


function confirmBox3(txt){
    modal({
        type: 'confirm',
        title: '알림',
        text: txt,
        size: 'small',
        closable: false,
/*        buttonText: {
        	cancel: '아니오',
            yes: '예'
        },*/
    	template: '<div class="modal-box"><div class="modal-inner"><div class="modal-title"></div><div class="modal-text">'+
    		'</div><div style="padding: 10px 15px; text-align: right; background-color: #f9f9f9; border-top: 1px solid #ddd;">'+
    	'<div class="ui-grid-b"><div class="ui-block-a" style="width: 33.3%; padding: 7px;"><button class="ui-btn" id="fcy_btn">예</button></div>' +
    		'<div class="ui-block-b" style="width: 33.3%; padding: 7px;"><button class="ui-btn" id="fcn_btn">아니오</button></div>' +
    	'<div class="ui-block-c" style="width: 33.3%; padding: 7px;"><button class="ui-btn" id="fcn_close_btn">닫기</button></div></div></div></div></div>',
    	_classes: {
    		box: '.modal-box',
    		boxInner: ".modal-inner",
    		title: '.modal-title',
    		content: '.modal-text',
    		buttons: '.modal-buttons',
    	},
/*        callback: function(result) {
        	if(result){
        		callbackMethod(jsonData);
            }
        }*/

        
    });
}



function confirmBox4(txt, callbackMethod, callbackMethod2){
    modal({
        type: 'confirm',
        title: '알림',
        text: txt,
        size: 'small',
        buttonText: {
        	cancel: '아니오',
            yes: '예'
        },
    	template: '<div class="modal-box"><div class="modal-inner"><div class="modal-title" style="color:#fff;"></div><div class="modal-text"></div><div class="modal-buttons"></div></div></div>',
    	_classes: {
    		box: '.modal-box',
    		boxInner: ".modal-inner",
    		title: '.modal-title',
    		content: '.modal-text',
    		buttons: '.modal-buttons',
    	},
        callback: function(result) {
        	if(result){
        		callbackMethod();
            }else{
            	callbackMethod2();
            }
        }

        
    });
}

