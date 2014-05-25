var colorIndex = 0;
var colors = ["bg-aqua", "bg-green", "bg-yellow", "bg-red", "bg-blue", "bg-purple", "bg-teal", "bg-maroon"];
		
$(document).ready(function() {
	$(".knob").knob();
	
	// loop colors
	$(".colors").each(function(ix, elem) {
		if (colorIndex >= colors.length) {
			colorIndex = 0;
		}
		$(elem).addClass(colors[colorIndex++]);
	});
});