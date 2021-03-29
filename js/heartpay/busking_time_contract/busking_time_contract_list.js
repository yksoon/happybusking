$(document).on('pageinit', '#busking_time_contract_list', function () {
    $('.btcl_mid_container').empty();
    // var user_no = $('#user_no').val();

    // console.log(user_no);

    //오늘 날짜 가져오기
    var Now = new Date();

    var year = Now.getFullYear();
    var month = Now.getMonth() + 1;

    for (var i = year; i < year + 3; i++) {
        var pr_year = '<option value="' + i + '">' + i + '년</option>';
        $('#btcl_year_select').append(pr_year);
    }

    for (var i = 1; i <= 12; i++) {
        if ((i + "").length == 1) {
            var pr_month = '<option value="0' + i + '">0' + i + '월</option>';
        }
        else {
            var pr_month = '<option value="' + i + '">' + i + '월</option>';
        }
        $('#btcl_month_select').append(pr_month);
    }
    $('#btcl_year_select').val(year).trigger('change');
    $('#btcl_month_select').val(pad(month, 2)).trigger('change');

    var search_year = $('#btcl_year_select').val();
    var search_month = $('#btcl_month_select').val();
    if (search_month.substr(0, 1) == '0') {
        search_month = search_month.substring(1);
    }


    $("#btcl_month_select").trigger('change');
    $("#btcl_year_select").trigger('change');

    $('#btcl_month_select').change(function () {
        $(".btcl_mid_container").empty();

        var search_year = $('#btcl_year_select').val();
        var search_month = $('#btcl_month_select').val();

        // console.log(search_month);
        // console.log(typeof (search_month));

        if (search_month.substr(0, 1) == '0') {
            search_month = search_month.substring(1);
        }
        // console.log(search_year);
        // console.log(search_month);

        get_btcl_select_date(search_year, search_month);
    });
    $('#btcl_year_select').change(function () {
        $(".btcl_mid_container").empty();

        var search_year = $('#btcl_year_select').val();
        var search_month = $('#btcl_month_select').val();

        // console.log(search_month);
        // console.log(typeof (search_month));

        if (search_month.substr(0, 1) == '0') {
            search_month = search_month.substring(1);
        }
        // console.log(search_year);
        // console.log(search_month);

        get_btcl_select_date(search_year, search_month);
    });
    get_btcl_select_date(search_year, search_month);
});

// $(document).ready(function () {
//     $("#btcl_month_select").trigger('change');
//     $("#btcl_year_select").trigger('change');

//     $('#btcl_month_select').change(function () {
//         $(".btcl_mid_container").empty();

//         var search_year = $('#btcl_year_select').val();
//         var search_month = $('#btcl_month_select').val();

//         // console.log(search_month);
//         // console.log(typeof (search_month));

//         if (search_month.substr(0, 1) == '0') {
//             search_month = search_month.substring(1);
//         }
//         console.log(search_year);
//         console.log(search_month);

//         get_btcl_select_date(search_year, search_month);
//     });
//     $('#btcl_year_select').change(function () {
//         $(".btcl_mid_container").empty();

//         var search_year = $('#btcl_year_select').val();
//         var search_month = $('#btcl_month_select').val();

//         // console.log(search_month);
//         // console.log(typeof (search_month));

//         if (search_month.substr(0, 1) == '0') {
//             search_month = search_month.substring(1);
//         }
//         console.log(search_year);
//         console.log(search_month);

//         get_btcl_select_date(search_year, search_month);
//     });
// });


// $(document).on('change', '#btcl_month_select', function () {
//     $(".btcl_mid_container").empty();

//     var search_year = $('#btcl_year_select').val();
//     var search_month = $('#btcl_month_select').val();

//     // console.log(search_month);
//     // console.log(typeof (search_month));

//     if (search_month.substr(0, 1) == '0') {
//         search_month = search_month.substring(1);
//     }
//     console.log(search_year);
//     console.log(search_month);

//     get_btcl_select_date(search_year, search_month);
// });