/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function beforeAddTreeNode(tree_obj){
	var describe3=document.getElementById('describe3').value;
	if(describe3=='是'){
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
	}
}
function afterAddTreeNode(tree_obj){
	var file_id=document.getElementById('file_id').value;
	//在security_counter中插入计数器
	if(file_id!=''&&file_id.length<=8){
		if(file_id.length==2){file_id+='000000';}
		else if(file_id.length==4){file_id+='0000';}
		else if(file_id.length==6){file_id+='00';}
		kindCounter.setHrCounter(file_id);
	}
}
function beforeDeleteNode(tree_obj){
	
}
function afterDeleteNode(tree_obj){
	var node=tree_obj.getSelectNode();
	if(node.pid>=0){
	for(var i=0;i<node.attributeArray[0].length;i++){
		if(node.attributeArray[0][i].toLowerCase()=='describe3'){
			if(node.attributeArray[1][i]=='是'){
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
	}
	
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
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){
var node=tree_obj.getSelectNode();
	if(node.pid>=0){
	for(var i=0;i<node.attributeArray[0].length;i++){
		if(node.attributeArray[0][i].toLowerCase()=='describe3'){
			if(node.attributeArray[1][i]=='是'){
				if(document.getElementById('file_name')!=null&&document.getElementById('file_name')!='undefiend'){
					document.getElementById('file_name').onfocus=function(){document.getElementById('file_name').blur();};
				}
			}
		}
	}
	}
}
function afterSelectNodeInto(tree_obj){
unloadCover('nseer1');
var chain_str=selectIntoCccc0(tree_obj);
document.getElementById('kind_chain').value=chain_str;
document.getElementById('nseer1').style.display='none';
}
function aftershowAddBrotherDiv(tree_obj){
}
function closefile(){
document.getElementById('nseer1').style.display='none';
}
function jionIn(my_id,tree_obj){
	var str="";
	if(my_id>0){
		str=tree_obj.node_list[my_id].showStr.substring(tree_obj.node_list[my_id].showStr.split(' ')[0].length+1);
		str=jionIn(tree_obj.node_list[my_id].pid,tree_obj)+"-"+str;
	}
	return str;
}
function selectIntoCccc0(tree_obj){ 
 var nodee=tree_obj.getSelectNode();
 var file_value='';
 if(nodee!=null){
 if(nodee.pid>=0){
 file_value=nodee.showStr.split(' ')[0]+" "+jionIn(nodee.id,tree_obj).substring(1); 
 }
 }
	return file_value;
}
function beforeshowAddChildDiv(tree_obj){
	var node=tree_obj.getSelectNode();
	if(node.pid>=0){
	for(var i=0;i<node.attributeArray[0].length;i++){
		if(node.attributeArray[0][i].toLowerCase()=='describe3'){
			if(node.attributeArray[1][i]=='是'){
				alert('零售店下不能继续设立分机构！');
				return false;
			}
		}
	}
	}
}