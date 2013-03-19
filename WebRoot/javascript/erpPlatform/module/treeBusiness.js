/*
 * 
 */
function beforeAddTreeNode(tree_obj){
	
}
function afterAddTreeNode(tree_obj){
}
function beforeDeleteNode(tree_obj){
	
}
function afterDeleteNode(tree_obj){
	
}
function beforeChangeNode(tree_obj){
	
}
function afterChangeNode(tree_obj){
	var nodee=tree_obj.getSelectNode();
	var picture='';
	var treetable=document.getElementById('treetable').value;
	//var pic_amount=parseInt(document.getElementById('pic_amount').value);
	var array=document.getElementsByName('picture');
	for(var i=0;i<array.length;i++){
		if(array[i].checked==true){
			picture=array[i].value;
			break;
		}
	}
	var xmlhttp3;
	if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
	xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
	if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	}else {
	alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
	xmlhttp3.open("POST", "designSub_change.jsp", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send('file_id='+nodee.showStr.split(' ')[0]+'&picture='+picture+'&treetable='+treetable);
	}
}
function beforeQuickSearchNode(tree_ob){
	
}
function afterQuickSearchNode(tree_obj){
	
}
function afterDoubleClick(tree_obj){
	
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){
	var nodee=tree_obj.getSelectNode();
	var treetable=document.getElementById('treetable').value;
	var xmlhttp3;
	if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
	xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
	if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	document.getElementById('td6').innerHTML='<img src="../../images/erpPlatform/designSub/'+xmlhttp3.responseText+'" width="28" height="28" hspace="1">';
	}else {
	alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
	xmlhttp3.open("POST", "designSub_search.jsp", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send('file_id='+nodee.showStr.split(' ')[0]+'&treetable='+treetable);
	}
	/*var pic=nodee.attributeArray[1][2];
	var pic_amount=parseInt(document.getElementById('pic_amount').value);
	var array=document.getElementsByName('pics');
	for(var i=0;i<pic_amount;i++){
		if(array[i].value==pic){
			array[i].checked=true;
			break;
		}
	}*/
}
function afterSelectNodeInto(tree_obj){
}
function aftershowAddBrotherDiv(tree_obj){
}