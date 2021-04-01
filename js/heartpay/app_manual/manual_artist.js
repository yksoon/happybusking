$(document).on('pageinit', '#manual_artist', function () {
    // var width = window.innerWidth;
    // $(".ma_header").css({"width":width+'px'});
    // $.ajax().always(function () {

    //     var bdc_carousel;

    //     $(document).ready(function () {

    //         bdc_carousel = $(".ma_header");
    //         bdc_carousel.itemslide(
    //             {
    //                 left_sided: true,
    //                 disable_clicktoslide: true
    //             }
    //         );

    //         bdc_carousel.on('changePos', function (_e) {
    //             var ai = bdc_carousel.getActiveIndex() + 1;

               
    //         });
    //     });
    // });
    
        // $(".ma_header").touchFlow({
        //     axis : "x",
        //     snap : true
        // });
    
});

// $(document).ready( function(){
//     $(".ma_header").touchFlow({
//         axis : "x",
//         snap : true
//     });
// });

$(document).on('click', '.ma_header_t_on', function(){
    
});
$(document).on('click', '.ma_header_t_base', function(){
   
    var old = $('.ma_header_t_on').attr('id');
    var newnew = $(this).attr('id'); 
    $('#'+old).removeClass('ma_header_t_on');
    $('#'+old).children('span').removeClass('ma_header_t_t_on');
    $('#'+old).addClass('ma_header_t_base');
    $('#'+old).children('span').addClass('ma_header_t_t_base');

    $(this).removeClass('ma_header_t_base');
    $(this).addClass('ma_header_t_on');
    $(this).children('span').removeClass('ma_header_t_t_base');
    $(this).children('span').addClass('ma_header_t_t_on');

    var ct_ck = old.split('_');
    var ct_ck_new = newnew.split('_');
    $('#ma_c_'+ct_ck[1]).hide();
    $('#ma_c_'+ct_ck_new[1]).show();

});