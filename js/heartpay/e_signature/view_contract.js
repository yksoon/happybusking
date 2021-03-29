$(document).on('pageinit', '#view_contract', function () {
    if (owner_chk()) {
        vc_owner_contract();
    }
    else if (artist_chk()) {
        vc_artist_contract();
    }
});

function go_view_contract() {
    loadPage2('e_signature/view_contract.jsp')
}
function loadPage2(str) {
    var url = '/app_root/jsp/' + str;
    $.mobile.loading('show', { text: '계약서 불러오는중', textVisible: false, theme: 'c', html: "" });
    $.mobile.loading('hide', { text: '계약서 불러오는중', textVisible: false, theme: 'c', html: "" });
    $.mobile.changePage(url, { transition: 'none' });
}
// 새로고침
$(document).on('click', '#vc_refresh', function () {
    location.reload();
})

$(document).on('click', '#vc_footer', function () {
    //pdf_wrap을 canvas객체로 변환
    // html2canvas($('#vc_pdf_form')[0]).then(function (canvas) {
    //     var doc = new jsPDF('p', 'mm', 'a4'); //jspdf객체 생성
    //     var imgData = canvas.toDataURL('image/png'); //캔버스를 이미지로 변환
    //     doc.addImage(imgData, 'PNG', 0, 0); //이미지를 기반으로 pdf생성
    //     doc.save('sample-file.pdf'); //pdf저장
    // });

    html2canvas($('#vc_pdf_form')[0]).then(function (canvas) {
        var perform_no = sessionStorage.getItem('es_con_perform_no');

        // 캔버스를 이미지로 변환
        var imgData = canvas.toDataURL('image/png');

        var imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
        var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
        var imgHeight = canvas.height * imgWidth / canvas.width;
        var heightLeft = imgHeight;

        var doc = new jsPDF('p', 'mm');
        var position = 0;

        // 첫 페이지 출력
        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;

        // 한 페이지 이상일 경우 루프 돌면서 출력
        while (heightLeft >= 20) {
            position = heightLeft - imgHeight;
            doc.addPage();
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
        }

        // 파일 저장
        // doc.save('sample_A4.pdf');
        //var data = doc.output('blob');

        console.log(doc.output());

        const NAME = perform_no + "_계약서.pdf";
        const CONTENT = "http://116.126.142.192:8094/app_root/jsp/e_signature/123123123123.pdf";


        var url = "http://116.126.142.192:8094/app_root/jsp/e_signature/123123123123.pdf";

        //Create XMLHTTP Request.
        //var req = new XMLHttpRequest();
        //req.open("GET", url, true);
        //req.responseType = "blob";
        //req.onload = function () {
        //console.log("1" + req.response);


        const BLOB = new Blob(
            [doc.output('blob')],
            { type: 'application/pdf;charset=EUC-KR;' }
        );





        if (navigator.appVersion.toString().indexOf('.NET') > 0) {
            //console.log("mobile");
            window.navigator.msSaveBlob(BLOB, FILE_NAME);
        } else {
            //console.log("pc");

            console.log(BLOB);
            const ENCODED_URL = URL.createObjectURL(BLOB);

            console.log(ENCODED_URL);
            const LINK = document.createElement('a');

            LINK.setAttribute('href', ENCODED_URL);
            LINK.setAttribute('download', NAME);
            LINK.click();
        }

        //};
        //req.send();
        //var a = document.createElement("a"); //Create <a>
        //	a.href = "123123123123.pdf"; //Image Base64 Goes here
        //a.download = "Image.pdf"; //File name Here
        //a.click(); //Downloaded file



        //saveAs(data, perform_no + "_계약서.pdf");
    });
});


// 사업주 계약서 가져오기
function vc_owner_contract() {
    var perform_no = sessionStorage.getItem('es_con_perform_no');

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/e_signature/get_view_contract_owner.jsp',
        data: {
            perform_no: perform_no
        },
        async: false,
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 60000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '계약서 가져오는 중..', textVisible: true, theme: 'c', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var CONTRACT_NO = $(this).find("CONTRACT_NO").text();
                var CONTRACT_1 = $(this).find("CONTRACT_1").text();
                var PERFORM_NO = $(this).find("PERFORM_NO").text();

                var vc_img = '<img class="vc_img" src="' + CONTRACT_1 + '" />'

                $('.vc_img_container').append(vc_img);
            });
        },
        complete: function () {
            $.mobile.loading('hide', { text: '계약서 가져오는 중..', textVisible: true, theme: 'c', html: "" });
        }

    });
}

// 아티스트 계약서 가져오기
function vc_artist_contract() {
    var perform_no = sessionStorage.getItem('es_con_perform_no');
    var user_no = $('#user_no').val();

    var contract_no = perform_no + '-' + user_no

    $.ajax({
        type: "GET",
        cache: false,
        url: '/service/e_signature/get_view_contract_artist.jsp',
        data: {
            contract_no: contract_no
        },
        async: false,
        contentType: "application/xml; charset=utf-8",
        dataType: "xml",
        timeout: 60000,
        beforeSend: function () {
            $.mobile.loading('show', { text: '계약서 가져오는 중..', textVisible: true, theme: 'c', html: "" });
        },
        success: function (data) {
            var ROOT = $(data).find('ROOT');
            var DATA = $(ROOT).find('DATA');

            $(DATA).each(function (i) {
                var CONTRACT_NO = $(this).find("CONTRACT_NO").text();
                var CONTRACT_1 = $(this).find("CONTRACT_1").text();
                var PERFORM_NO = $(this).find("PERFORM_NO").text();

                var vc_img = '<img class="vc_img" src="' + CONTRACT_1 + '" />'

                $('.vc_img_container').append(vc_img);
            });
        },
        complete: function () {
            $.mobile.loading('hide', { text: '계약서 가져오는 중..', textVisible: true, theme: 'c', html: "" });
        }

    });
}