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
var file_id=document.getElementById('file_id').value;
if(document.getElementById('depositing_subject')==undefined){
var lifecycle=document.getElementById('lifecycle').value;
var remnant_value_rate=document.getElementById('remnant_value_rate').value;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "kind_change.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+file_id+'&lifecycle='+lifecycle+'&remnant_value_rate='+remnant_value_rate);
}
}else{
var depositing_subject=document.getElementById('depositing_subject').value
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "kind_change.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+file_id+'&depositing_subject='+depositing_subject);
}
}


}
function beforeQuickSearchNode(tree_ob){
	
}
function afterQuickSearchNode(tree_obj){
	
}
function afterDoubleClick(tree_obj){
	
}
function afterSelectNodeInto(tree_obj){
var node=tree_obj.getSelectNode();
	//alert(node.showStr);
}
function aftershowAddBrotherDiv(tree_obj){
if(document.getElementById('dialogAddI').style.display=='block'){
		var xmlhttp3;
		if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
		xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
		var select=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2).split('¡î');
		var	itema=select[0].split('¡ò');
		var	itemb=select[1].split('¡ò');
		var	itemd=select[2].split('¡ò');
		var option='';
		var itema_name=document.getElementById('itema_name');
		var itemb_name=document.getElementById('itemb_name');
		var itemd_name=document.getElementById('itemd_name');
		for(var i=0;i<itema.length-1;i++){
			option=document.createElement('option');
    		option.text=itema[i].split('¡Ñ')[1];
     		option.vlaue=itema[i].split('¡Ñ')[0];
     		itema_name.add(option);
		}
		for(var i=0;i<itemb.length-1;i++){
			option=document.createElement('option');
    		option.text=itemb[i].split('¡Ñ')[1];
     		option.vlaue=itemb[i].split('¡Ñ')[0];
     		itemb_name.add(option);
		}
		for(var i=0;i<itemd.length-1;i++){
			option=document.createElement('option');
    		option.text=itemd[i].split('¡Ñ')[1];
     		option.vlaue=itemd[i].split('¡Ñ')[0];
     		itemd_name.add(option);
		}
		}else {
		alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp3.open("POST", "file_search.jsp", true);
		xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp3.send('tag=select');
		}
	}
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){

}