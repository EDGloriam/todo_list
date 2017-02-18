$(document).ready ->
	$(".button-add-list").click ->
		# $('test').tmpl({ name: "VASYA!!!" }).appendTo('#test-container')
		$.tmpl("qwe", { name: "VASYA!!!" }).appendTo("#test-container")
		console.log "ta"
