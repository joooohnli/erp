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
	document.getElementById('tag').value='0';
	document.getElementById('register_div').style.display='block';
	document.getElementById('title_span').innerHTML='添加';
    document.getElementById('currency_id').value='';
 	document.getElementById('currency_name').value='';
 	document.getElementById('currency_id').disabled=false;
    document.getElementById('currency_name').disabled=false;
 	document.getElementById('currency_mark').value='';
 	document.getElementById('conversion_way').value='';
 	document.getElementById('currency_decimal').value='';
 	document.getElementById('currency_time').value='';
}

function register_ok(value){
	if(!doValidate('../../../xml/finance/finance_config_currency.xml','')){return false;}
var currency_id=document.getElementById('currency_id').value;
var currency_name=document.getElementById('currency_name').value;
var currency_mark=document.getElementById('currency_mark').value;
var conversion_way=document.getElementById('conversion_way').value;
var way_tag=document.getElementById('way_tag').value;
var currency_decimal=document.getElementById('currency_decimal').value;
var currency_time=document.getElementById('currency_time').value;
var tag=document.getElementById('tag').value;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {

	if(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)=='0'){
		multiLangValidate.dwrGetLang("erp",'添加成功',{callback:function(msg){alert(msg);window.location.reload();}});
		 
	}else if(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)=='1'){
		multiLangValidate.dwrGetLang("erp",'编号或币种名重复',{callback:function(msg){alert(msg);}});
		return false;
	}else{
		multiLangValidate.dwrGetLang("erp",'汇率调整成功',{callback:function(msg){alert(msg);window.location.reload(); }});
		
	}

}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_voucher_currencyRegister_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('currency_id='+currency_id+'&&currency_name='+currency_name+'&&currency_mark='+currency_mark+'&&conversion_way='+conversion_way+'&&way_tag='+way_tag+'&&currency_decimal='+currency_decimal+'&&currency_time='+currency_time+'&&tag='+tag);
}
}

function delete_currency(){
var inputs_array=document.getElementsByTagName('input');
var ids_str;
for(var i=0;i<inputs_array.length;i++){
	if(inputs_array[i].type=='checkbox'&&inputs_array[i].checked==true){
		ids_str+='◎'+inputs_array[i].value;
	}
}
if(typeof(ids_str)=='undefined'){
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
xmlhttp3.open("POST", "../../../finance_config_voucher_currency_delete_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str));
}
}

function change_currency(currency_id){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	//alert(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2));
var value=xmlhttp3.responseText.split('⊙');
document.getElementById('currency_id').value=value[0];
document.getElementById('currency_name').value=value[1];
document.getElementById('currency_mark').value=value[2];
document.getElementById('conversion_way').value=value[3];
if(value[4]=='0'){
document.getElementById('way_tag').options[0].selected=true;
}else{
document.getElementById('way_tag').options[1].selected=true;
}
document.getElementById('currency_decimal').value=value[5];
document.getElementById('currency_time').value=value[6];
document.getElementById('tag').value='1';
document.getElementById('currency_id').disabled=true;
document.getElementById('currency_name').disabled=true;
document.getElementById('register_div').style.display='block';
document.getElementById('title_span').innerHTML='汇率调整';

}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "currency_query.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('currency_id='+currency_id);
}
}

function Departure(){
document.getElementById('register_div').style.display='none';
}

function decimalControl(input_id){//金额类录入框输入控制
  var input=document.getElementById(input_id);
     input.value = input.value.replace(/[^-0123456789.$]/g,'');
    if(input.value.indexOf('0')==0)  input.value=input.value.substring(1);
    if(input.value.indexOf('-')==0) {
    input.value='-'+input.value.replace(/-/g,'');
    }else{
    input.value=input.value.replace(/-/g,'');
    }
	if(input.value.indexOf('.')!=-1) input.value=input.value.substring(0,input.value.indexOf('.')+1)+input.value.substring(input.value.indexOf('.')+1).replace(/\./g,'');
	if(input.value.indexOf('.')==0) input.value=input.value.substring(1);
	if(input.value==''){
	return 0;
	}else{
	return input.value;
	}
}