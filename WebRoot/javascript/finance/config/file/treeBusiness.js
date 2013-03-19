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
if(document.getElementById('dialogAddI')!=null&&document.getElementById('dialogAddI')!='undefined'){/*将辅助核算五项拼起来放入assistance内好写入数据库*/
	var i='';
	if(document.getElementById('part').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('personal').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('customer').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('purchaser').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('programme').checked){i=i+'1';}else{i=i+'0';}
	document.getElementById('assistance').value=i;
}
}
function afterAddTreeNode(tree_obj){
	var node=tree_obj.getSelectNode();
	var parent_file_id=node.showStr.split(' ')[0];
	var details_tag=node.child_list.length>0?1:0;
	var file_id=document.getElementById("file_id").value;
	var file_name=document.getElementById("file_name").value;
	var xmlhttp;
if (window.XMLHttpRequest){
		xmlhttp=new XMLHttpRequest();
		}else if (window.ActiveXObject){
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
			if(xmlhttp.status==200) {
var text=xmlhttp.responseText+'123';
if(parseInt(text)==123){
}else{
}
}}};
		xmlhttp.open("POST", "file_assistant.jsp", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send('IDD=true&parent_file_id='+parent_file_id+'&file_id='+file_id+'&file_name='+file_name+'&details_tag='+details_tag);
}
}
function beforeDeleteNode(tree_obj){

}
function afterDeleteNode(tree_obj){
}
function beforeChangeNode(tree_obj){
	
}
function afterChangeNode(tree_obj){

}
function beforeQuickSearchNode(tree_obj){
	
}
function afterQuickSearchNode(tree_obj){
	
}
function afterDoubleClick(tree_obj){
	
}
function afterSelectNodeInto(tree_obj){

}
function aftershowAddBrotherDiv(tree_obj){	
if(document.getElementById('dialogAddI')!=null&&document.getElementById('dialogAddI')!='undefined'){/*从后台查询资产负债表所属项目，损益表所属项目，现金流量表补充资料所属项目然后放入页面的selec框中*/	
		var xmlhttp3;
		if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
		xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
		var select=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2).split('☆');
		var	itema=select[0].split('◎');
		var	itemb=select[1].split('◎');
		var	itemd=select[2].split('◎');
		var option='';
		var itema_name=document.getElementById('itema_name');
		var itemb_name=document.getElementById('itemb_name');
		var itemd_name=document.getElementById('itemd_name');
		for(var i=0;i<itema.length-1;i++){
			option=document.createElement('option');
    		option.text=itema[i].split('⊙')[1];
     		option.value=itema[i].split('⊙')[0];
     		itema_name.add(option);
		}
		for(var i=0;i<itemb.length-1;i++){
			option=document.createElement('option');
    		option.text=itemb[i].split('⊙')[1];
     		option.value=itemb[i].split('⊙')[0];
     		itemb_name.add(option);
		}
		for(var i=0;i<itemd.length-1;i++){
			option=document.createElement('option');
    		option.text=itemd[i].split('⊙')[1];
     		option.value=itemd[i].split('⊙')[0];
     		itemd_name.add(option);
		}
		}else {
		alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp3.open("POST", "file_search.jsp", true);
		xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp3.send('tag=select');
		}
}else if(document.getElementById('dialogAddII')!=null&&document.getElementById('dialogAddII')!='undefined'){
	var node=tree_obj.getSelectNode();
	var str=['kind_tag','muti_field_type','debit_or_loan','itema_name','itemb_name','itemd_name','profit_or_cost','corr_stock_tag','cash_tag','daily_tag','bank_tag','assistance'];
	for(var i=0;i<node.attributeArray[0].length;i++){
		if(str.join(',').indexOf(node.attributeArray[0][i].toLowerCase())!=-1){
			document.getElementById(node.attributeArray[0][i].toLowerCase()).value=node.attributeArray[1][i];
		}
	}
	}
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){

}
function showCurrency(select_id,input_id){
	if(document.getElementById(select_id).value=='1'){
		var xmlhttp3;
		if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
		xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
		if(xmlhttp3.responseText.length==2){
			divPrompt3('您还未设置任何种类的外币！');
		}else{
		var select=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2).split('◎');
			for(var i=0;i<select.length;i++){
				option=document.createElement('option');
				option.text=select[i].split('⊙')[1];
     			option.value=select[i].split('⊙')[0]+"/"+select[i].split('⊙')[1];
     			document.getElementById(input_id).add(option);
			}
		}
		}else {
		alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp3.open("POST", "file_search.jsp", true);
		xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp3.send('tag=currency');
		}
	}else{
		document.getElementById(input_id).options.length=1;
	}
}