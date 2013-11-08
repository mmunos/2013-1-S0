$(document).ready(showganizer);
$(window).bind('page:change', showganizer)

$(document).on("click",".flash-bar a.close",function(e) {
		e.preventDefault();
		$(".flash-bar").fadeOut();
});

$(document).on('click', "#top-bar-login-button", function(e) {
		e.preventDefault();
		$("#top-bar-buttons, #top-bar-auth").toggleClass("hidden");
		$("#top-bar-buttons, #top-bar-auth").toggleClass("show");
});

$(document).on("click","#top-bar-auth .close a", function(e) {
		e.preventDefault();
		$("#top-bar-buttons, #top-bar-auth").toggleClass("hidden");
		$("#top-bar-buttons, #top-bar-auth").toggleClass("show");
});

$(document).on("click",".open-review-form", function(e) {
		e.preventDefault();
		if ($(this).hasClass("fade-open-review")) {
			$(this).fadeOut();
		}
		$(".form-container").slideDown(400, function() {
			$(".form-container textarea").focus();
		});
});

$(document).on("click",".close-review-form", function(e) {
		e.preventDefault();
		$(".form-container").slideUp(400, function(){
			$(".fade-open-review").fadeIn();
			$(".review-form").closest("form")[0].reset();
			$(".review-form-charleft").fadeOut();
			$(".review-form-charleft-number").html(1000);
		});

});



function showganizer(){
	$(".flash-bar").delay(3000).fadeOut();
	$(".form-container").hide();
	$(".review-form-charleft").hide()

	$("#review_content").keyup(function(e) {
		var charleft = 1000-$(this).val().length;
		$(".review-form-charleft-number").html(charleft);
		if(charleft < 0) {
			$(".review-form-charleft").css({
				color: 'red',
				fontWeight: 'bold'
			});
			$(".review-form-submit input").attr('disabled', 'disabled').css({opacity: 0.3});
		} else {
			$(".review-form-charleft").removeAttr("style");
			$(".review-form-submit input").removeAttr('disabled').removeAttr("style");
		}
	}).focus(function(e){
		$(".review-form-charleft").fadeIn();
	});
}
