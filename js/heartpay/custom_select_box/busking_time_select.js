$(document).on('click', '#bts_back', function () {
    $("html, body").css({ "overflow": "auto", "height": "auto" });
    $('#busking_time_select_popup').unbind('touchmove');

    $('#busking_time_select_popup').hide();

    $('#header').show();
    $('#footer').show();
});

$(document).on('click', '#bts_time_add', function () {
    $('#bts_perform').after(
        '<div class="bts_perform_container" id="bts_perform" style="margin-top:30px;">' +
        '<div class="bts_perform_cell perform_start">' +
        '<div class="bts_perform_p_title">' +
        '<p class="bts_perform_p">공연시작</p>' +
        '</div>' +
        '<div class="bts_perform_time start_time">' +
        '<p class="bts_perform_time_p">19:30</p>' +
        '</div>' +
        '</div>' +
        '<div class="bts_perform_cell perform_end">' +
        '<div class="bts_perform_p_title">' +
        '<p class="bts_perform_p">공연종료</p>' +
        '</div>' +
        '<div class="bts_perform_time end_time">' +
        '<p class="bts_perform_time_p">20:00</p>' +
        '</div>' +
        '</div>' +
        '</div>');
});