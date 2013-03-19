var height = window.screen.height-700
var width =  window.screen.width-700
function winopens(file){
	file=encodeURI(file);	
window.open(file,"","height="+height+",width="+width+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}