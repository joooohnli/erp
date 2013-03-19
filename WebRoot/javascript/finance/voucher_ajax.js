/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function getFileAttribute(obj,arr_number,evt){//通过科目编号获得科目属性
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var return_value=xmlhttp3.responseText;
var tag_group=return_value.substring(2,return_value.length-2).split('@#$');
corr_stock_tag[arr_number]=tag_group[0];
cash_tag[arr_number]=tag_group[1];
bank_tag[arr_number]=tag_group[2];
currency_tag[arr_number]=tag_group[5];
document.getElementById('page_bank_tag').value=bank_tag[arr_number]!=undefined?bank_tag[arr_number]:'';
document.getElementById('page_cash_tag').value=cash_tag[arr_number]!=undefined?cash_tag[arr_number]:'';
document.getElementById('page_corr_stock_tag').value=corr_stock_tag[arr_number]!=undefined?corr_stock_tag[arr_number]:'';
document.getElementById('page_currency_tag').value=currency_tag[arr_number]!=undefined?currency_tag[arr_number]:'';
writeAssis();
write_hidden1();
return_value=return_value.substring(2,return_value.length-2);
setFile(return_value,file_id);
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_FileAttribute.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+obj);
}
}

function getCashItem(obj,obj1){//获得现金流量表项目
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
document.getElementById('bbbbb'+obj1).value=xmlhttp3.responseText;
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_cashItem.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('cashItem='+encodeURI(obj));
}
}

function search_suggest(obj){//根据输入内容快速查询摘要写入下拉层
var keyword=document.getElementById(obj).value;
if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
loadDiv(document.getElementById(obj));
var cla=document.getElementById('search_suggest');
cla.innerHTML='';
if(parseInt(xmlhttp3.responseText)==0){
	document.getElementById('search_suggest').style.display='none';
	}else{
var options =xmlhttp3.responseText.split("\n");
var conter='';
for (var i = 0; i < options.length; i++) {
var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+obj+'\');\" ';
suggest += '>' + options[i] + '</div>';
conter += suggest;
}
cla.innerHTML = null;
cla.innerHTML = '';
cla.innerHTML = conter;
Dynamic (obj);
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword));
}
}
}

function search_file(obj){//根据输入内容快速查询科目写入下拉层
var keyword=document.getElementById(obj).value;
if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
loadDiv(document.getElementById(obj));
var cla=document.getElementById('search_suggest');
cla.innerHTML='';
if(parseInt(xmlhttp3.responseText)==0){
	document.getElementById('search_suggest').style.display='none';
	}else{
var text1=xmlhttp3.responseText.substring(2,xmlhttp3.responseText.length-2);//ajax返回的字符串首尾都自动加了换行符，所以这边要切掉前后各2个字符。
var options1 =text1.split('~~~');
var conter='';
for (var i = 0; i < options1.length; i++) {
var suggest ='<div onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += ' onclick=\"javascript:setFile(\''+options1[i]+'\',\''+obj+'\');\" ';
suggest += '>'+options1[i].split('@#$')[3]+'</div>';
conter += suggest;
}
cla.innerHTML = null;
cla.innerHTML = '';
cla.innerHTML = conter;
Dynamic (obj);
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_file.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword));
}
}
}

function validateFile(obj){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
if(parseInt(xmlhttp3.responseText)==0){
	alert('科目不合法');
	return false;}
	document.getElementById('register_new').submit();

}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_validate.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(obj));
}

}

function validateId(obj_value,start_time,end_time,tag){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
if(tag=='0' && parseInt(xmlhttp3.responseText)!=0){
	alert('凭证号重复，建议使用:'+parseInt(xmlhttp3.responseText));
	return false;
	}
	var groups='';
	var file_name=document.getElementsByName('file_name1');
	for(var i=0;i<file_name.length;i++){
		if(file_name[i].value!='') groups+=file_name[i].value+'◎';
		}
		groups=groups.substring(0,groups.length-1);
	validateFile(groups);
	}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_validateId.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('obj_value='+obj_value+'&&start_time='+start_time+'&&end_time='+end_time);
}

}