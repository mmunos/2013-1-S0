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
		});

});

$(document).on("click",".open-post-form", function(e) {
		e.preventDefault();
		if ($(this).hasClass("fade-open-post")) {
			$(this).fadeOut();
		}
		$(".form-container-post").slideDown(400, function() {
			$(".form-container-post textarea").focus();
		});
});


$(document).on("click",".close-post-form", function(e) {
		e.preventDefault();
		$(".form-container-post").slideUp(400, function(){
			$(".fade-open-post").fadeIn();
			$(".post-form").closest("form")[0].reset();
		});

});

function showganizer(){
	$(".flash-bar").delay(3000).fadeOut();
	$(".form-container").hide();
	$(".form-container-post").hide();
}


