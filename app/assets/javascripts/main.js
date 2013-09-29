$(document).ready(function() {

	console.log("load!");

	$("#top-bar-login-button").click(function(e) {
		e.preventDefault();
		$("#top-bar-buttons, #top-bar-auth").toggleClass("hidden");
	});

	$("#top-bar-auth .close a").click(function(e) {
		e.preventDefault();
		$("#top-bar-buttons, #top-bar-auth").toggleClass("hidden");
	});

});