/*
 * 
 */
function beforeAddTreeNode(tree_obj){
		/*var list_tag=document.getElementById('list_tag').value;
	if(list_tag=='ÊÇ'){
	var file_name=document.getElementById('file_name').value;
	if(file_name!=null&&file_name!=''){
	var u=window.location.href.split('://')[1].split('/');
	var url='';
	for(var i=0;i<u.length-3;i++){url+='../';}	
	var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", url+'hr/config/file/fileKind_register.jsp', true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('file_name='+encodeURI(file_name)+'&&tag=0');
		}
	}
	}*/
}


function afterAddTreeNode(tree_obj){
		var file_id=document.getElementById('file_id').value;
	if(file_id!=''&&file_id.length<=8){
		if(file_id.length==2){file_id+='000000';}
		else if(file_id.length==4){file_id+='0000';}
		else if(file_id.length==6){file_id+='00';}
		kindCounter.setEcommerceOtherCounter(file_id);
	}
	
}
function beforeDeleteNode(tree_obj){
	
}
function afterDeleteNode(tree_obj){
	/*
		var node=tree_obj.getSelectNode();
	if(node.pid>=0){
	for(var i=0;i<node.attributeArray[0].length;i++){
		if(node.attributeArray[0][i].toLowerCase()=='describe3'){
			if(node.attributeArray[1][i]=='ÊÇ'){
	var file_name=node.showStr.substring(node.showStr.split(" ")[0].length+1);
	if(file_name!=null&&file_name!=''){
	var u=window.location.href.split('://')[1].split('/');
	var url='';
	for(var i=0;i<u.length-3;i++){url+='../';}	
	var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", url+'hr/config/file/fileKind_register.jsp', true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('file_name='+encodeURI(file_name)+'&&tag=1');
		}
	}
			}
		}
	}
	}*/
	
}
function beforeChangeNode(tree_obj){
	
}
function afterChangeNode(tree_obj){

}
function beforeQuickSearchNode(tree_ob){
	
}
function afterQuickSearchNode(tree_obj){
	
}
function afterDoubleClick(tree_obj){
	
}
function afterSelectNodeInto(tree_obj){

}
function aftershowAddBrotherDiv(tree_obj){
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){

}