$(document).on('pageinit', '#myrecruit', function() {
	const filter = sessionStorage.getItem('mri-filter');

	$('.mr-filter').removeClass('mr-on');

	if (filter === 'Y') {
		$('#mr-filter-pass').addClass('mr-on');
	} else {
		$('#mr-filter-all').addClass('mr-on');
	}
	getMyRecruit();
})

$(document).on('click', '.mr-filter', function() {
	$('.mr-filter').removeClass('mr-on');

	const id = $(this).attr('id');

	if (id === 'mr-filter-pass') {
		sessionStorage.setItem('mri-filter', 'Y');
		$('#mr-filter-pass').addClass('mr-on');
	} else {
		sessionStorage.removeItem('mri-filter');
		$('#mr-filter-all').addClass('mr-on');
	}

	getMyRecruit();
});