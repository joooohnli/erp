/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function showGarDiv(value,tableName){/*转入垃圾箱*/
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/draft_gar/divToGar.xml','0');
//multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
document.getElementById('div_rows_num').value=value;
document.getElementById('tableName').value=tableName;
} 

function showCheckDiv(value,tableName){/*提交审核*/
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/draft_gar/divToCheck.xml','0');
//multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
document.getElementById('div_rows_num').value=value;
document.getElementById('tableName').value=tableName;
}
function sendToGar(fileName){
var ids_str='';
var tableName=document.getElementById('tableName').value;
var rows_num=parseInt(document.getElementById('div_rows_num').value);
for(var i=1;i<rows_num;i++){
if(document.getElementById('draft_gar'+i).checked){
ids_str+='⊙'+document.getElementById('draft_gar'+i).value;
}
}
if(ids_str==''){	
	multiLangValidate.dwrGetLang("erp",'请您选择要转入垃圾箱的记录',{callback:function(msg){n_A.divShow(msg);}});
	n_D.closeDiv('remove');
	return false;
}
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
if(parseInt(xmlhttp3.responseText)==1){
multiLangValidate.dwrGetLang("erp",'转入成功',{callback:function(msg){alert(msg); window.location.reload();}});
}
}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../include_draft_gar_sendToGar_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str.substring(1))+'&&tableName='+encodeURI(tableName));}
} 

function sendToCheck(fileName){
var ids_str='';
var tableName=document.getElementById('tableName').value;
var rows_num=parseInt(document.getElementById('div_rows_num').value);
for(var i=1;i<rows_num;i++){
if(document.getElementById('draft_gar'+i).checked){
ids_str+='⊙'+document.getElementById('draft_gar'+i).value;
}
}
if(ids_str==''){	
	multiLangValidate.dwrGetLang("erp",'请您选择要提交审核的记录',{callback:function(msg){n_A.divShow(msg);}});
	n_D.closeDiv('remove');
	return false;
}
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
if(parseInt(xmlhttp3.responseText)==1){
multiLangValidate.dwrGetLang("erp",'提交成功',{callback:function(msg){alert(msg); window.location.reload();}});
}
}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", fileName, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str.substring(1))+'&&tableName='+encodeURI(tableName));}
}
function sendOk(formId,fileName,validateXml){
var form=document.getElementById(formId);
form.action=fileName;
if(validateXml!=null){
if(doValidate(validateXml,formId)){form.submit();}
}else{
form.submit();
}
}
function draftOk(formID,fileName,validiteXml){
var form = document.getElementById(formID);
form.action=fileName;
if(validiteXml!=null){
if(doValidate(validiteXml,formID)){
form.submit();
}
}else{
form.submit();
}
}


