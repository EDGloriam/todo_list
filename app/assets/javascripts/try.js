document.documentElement.addEventListener("click", function (event){
	console.log(event.target);
	// if((event.target.parentNode.nodeName === 'TBODY') & (event.target.parentNode.className === 'tasks') ){
	// 	console.log("inside");
		jQuery('.tasks').sortable();
	// }
},true);