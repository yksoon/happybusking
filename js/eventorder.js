var CURRENT_PAGE = "";

var events = [
    // page load events
    'pagebeforeload',
    'pageload',
    'pageloadfailed',

    // page chage events
    'pagebeforechange',
    'pagechange',
    'pagechangefailed',

    // page transition events
    'pageshow',
    'pagehide',
    'pagebeforehide',
    'pagebeforeshow',

    // page initialization events
    'pagebeforecreate',
    'pagecreate',
    'pageinit',

    // page remove events
    'pageremove',

    // layout update events
    'updatelayout'
].join(' ');



$(document).on(events, function (e) {
    //firedOnDocument.push(e.type);
    //alert(e.type);
});


$(document).on('pagecreate', function (e) {
    CURRENT_PAGE = e.target.id;
});





