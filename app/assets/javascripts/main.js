$(document).ready(function() {

	$(".flash-bar a.close").click(function(e) {
		e.preventDefault();
		$(".flash-bar").fadeOut();
	});

	$("#top-bar-login-button").click(function(e) {
		e.preventDefault();
		$("#top-bar-buttons, #top-bar-auth").toggleClass("hidden");
	});

	$("#top-bar-auth .close a").click(function(e) {
		e.preventDefault();
		$("#top-bar-buttons, #top-bar-auth").toggleClass("hidden");
	});



});