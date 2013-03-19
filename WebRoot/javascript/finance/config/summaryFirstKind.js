/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function register(){
document.getElementById('register_div').style.display='block';
}

function register_ok(){
var nick_name=document.getElementById('nick_name').value;
var summary=document.getElementById('summary').value;

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	if(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)=='0'){
		multiLangValidate.dwrGetLang("erp",'添加成功',{callback:function(msg){alert(msg);window.location.reload();}});
		
	}else{
	multiLangValidate.dwrGetLang("erp",'助记码重复',{callback:function(msg){alert(msg);}});
	return false;
	}

}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_voucher_summaryFirstKind_register_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('nick_name='+nick_name+'&&summary='+summary);
}
}

function delete_recofirm(){//对checkbox的处理
var inputs_array=document.getElementsByTagName('input');
var ids_str=0;
for(var i=0;i<inputs_array.length;i++){
	if(inputs_array[i].type=='checkbox'&&inputs_array[i].checked==true){
		ids_str+='◎'+inputs_array[i].value;
	}
}

if(typeof(ids_str)=='number'){//
	multiLangValidate.dwrGetLang("erp",'请您选择要删除的记录',{callback:function(msg){alert(msg);}});
	document.getElementById('delete_div').style.display='none';
	return false;
}
 ids_str=ids_str.substring(1);
var xmlhttp3;
if (window.XMLHttpRequest){
xmlhttp3=new XMLHttpRequest();
}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");

}
if(xmlhttp3){
xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){
try {
if(xmlhttp3.status==200){
if(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)=='0'){

multiLangValidate.dwrGetLang("erp",'删除成功',{callback:function(msg){alert(msg);window.location.reload();}});

}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_voucher_summaryFirstKind_delete_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str));
}
}