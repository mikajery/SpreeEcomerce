$(function(){
	
	$('#deli-form').css("display", "none");
	$("#add-delivery").click(function(){
		$('#deli-form').css("display", "block");
		$(this).css("display", "none");
	});
})