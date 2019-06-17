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