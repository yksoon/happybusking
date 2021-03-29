function setItemSlide(){
	var carousel;
    carousel = $("#isu_ccl_event");
    carousel.itemslide(
    	{
    		left_sided: true,
    		disable_clicktoslide: true
    	}
    );
    carousel.reload();
    
    var carousel2;
    carousel2 = $("#isu_ccl_nowseoul");
    carousel2.itemslide(
    	{
    		left_sided: true,
    		disable_clicktoslide: true
    	}
    );
    carousel2.reload();
}