$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	});
	$('.element-a-flow').click(function(){
		var $this = $(this);
		if($this.text()==="flowing"){
			$this.removeClass("flowing");
			$this.text("flow");
		}else{
			$this.addClass("flowing");
			$this.text("flowing");
		}
	});
})

$('.a-img-element').click(function(){
	var img = $(this).find('img').attr('src');
	$('.img-modal').attr('src',img);
	var _right = $(this).siblings('.element-col-right');
	var _title = _right.find('.element-content-title');
	var _description = _right.find('.element-content-mid');
	var title = _title.text();
	var description = _description.text();
	$('h4.modal-title').text(title);
	$('p.modal-description').text(description);
});