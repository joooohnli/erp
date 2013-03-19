/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var servletName='';
function showDraDiv(value,tableName){/*转入草稿箱*/
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/draft_gar/divToDra.xml','0');
//multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
document.getElementById('div_rows_num').value=value;
document.getElementById('tableName').value=tableName;
} 

function showDeleteDiv(value,tableName,sName){/*永久删除*/
if(sName!=null&&sName!='undefined'&&sName!=''){servletName=sName;}else{servletName='';}
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/draft_gar/divToDelete.xml','0');
//multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
document.getElementById('div_rows_num').value=value;
document.getElementById('tableName').value=tableName;
}

function showDraDiv1(value,tableName){/*档案类转入草稿箱*/
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/draft_gar/divToDra1.xml','0');
//multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
document.getElementById('div_rows_num').value=value;
document.getElementById('tableName').value=tableName;
} 

function sendToDra(fileName){
var ids_str=0;
var tableName=document.getElementById('tableName').value;
var rows_num=parseInt(document.getElementById('div_rows_num').value);
for(var i=1;i<rows_num;i++){
if(document.getElementById('draft_gar'+i).checked){
ids_str+='⊙'+document.getElementById('draft_gar'+i).value;
}
}

if(typeof(ids_str)=='number'){
	multiLangValidate.dwrGetLang("erp",'请您选择要转入草稿箱的记录',{callback:function(msg){n_A.divShow(msg);}});
	n_D.closeDiv('remove');
	return false;
}

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
	if(parseInt(xmlhttp3.responseText.length)==3){
multiLangValidate.dwrGetLang("erp",'转入成功',{callback:function(msg){window.location.reload();}});
}else{
multiLangValidate.dwrGetLang("erp",'您所选记录中'+xmlhttp3.responseText.substring(2,xmlhttp3.responseText.length-2).replace(/\⊙/g,'，')+'已完成，不能转入',{callback:function(msg){alert(msg); window.location.reload();}});
}
}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", fileName, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str.substring(1))+'&tableName='+encodeURI(tableName)+'&gar_tag='+encodeURI(document.getElementById('gar_tag').value)+'&field='+encodeURI(document.getElementById('field').value))}
} 

function sendToDelete(fileName){
var trueFileName;
if(servletName==''||servletName==null||servletName=='undefined'){trueFileName=fileName;}else{trueFileName=servletName;}
var ids_str=0;
var tableName=document.getElementById('tableName').value;
var rows_num=parseInt(document.getElementById('div_rows_num').value);
for(var i=1;i<rows_num;i++){
if(document.getElementById('draft_gar'+i).checked){
ids_str+='⊙'+document.getElementById('draft_gar'+i).value;
}
}
if(typeof(ids_str)=='number'){
	multiLangValidate.dwrGetLang("erp",'请您选择要删除的记录',{callback:function(msg){n_A.divShow(msg);}});
	n_D.closeDiv('remove');
	return false;
}
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
if(parseInt(xmlhttp3.responseText)==1){
multiLangValidate.dwrGetLang("erp",'删除成功',{callback:function(msg){window.location.reload();}});
}
}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", trueFileName, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str.substring(1))+'&&tableName='+encodeURI(tableName));}
}

function sendToDra1(fileName){
var ids_str=0;
var tableName=document.getElementById('tableName').value;
var rows_num=parseInt(document.getElementById('div_rows_num').value);
for(var i=1;i<rows_num;i++){
if(document.getElementById('draft_gar'+i).checked){
ids_str+='⊙'+document.getElementById('draft_gar'+i).value;
}
}

if(typeof(ids_str)=='number'){
	multiLangValidate.dwrGetLang("erp",'请您选择要转入草稿箱的记录',{callback:function(msg){n_A.divShow(msg);}});
	n_D.closeDiv('remove');
	return false;
}

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
	if(parseInt(xmlhttp3.responseText.length)==3){
multiLangValidate.dwrGetLang("erp",'转入成功',{callback:function(msg){alert(msg); window.location.reload();}});
}else{
multiLangValidate.dwrGetLang("erp",'您所选记录'+xmlhttp3.responseText.substring(2,xmlhttp3.responseText.length-2).replace(/\⊙/g,'，')+'为有效档案，不能转入',{callback:function(msg){alert(msg); window.location.reload();}});
}
}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", fileName, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str.substring(1))+'&tableName='+encodeURI(tableName)+'&gar_tag='+encodeURI(document.getElementById('gar_tag').value)+'&field='+encodeURI(document.getElementById('field').value))}
} 

function showRecovery(value,tableName){
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/include/draft_gar/recovery.xml','0');
//multiLangValidate.dwrGetLang("erp",value,{callback:function(msg){document.getElementById('prompt_span').innerHTML=msg;}});
document.getElementById('div_rows_num').value=value;
document.getElementById('tableName').value=tableName;
} 

function recovery(){
var ids_str='';
var tableName=document.getElementById('tableName').value;
var rows_num=parseInt(document.getElementById('div_rows_num').value);
for(var i=1;i<rows_num;i++){
if(document.getElementById('draft_gar'+i).checked){
ids_str+='⊙'+document.getElementById('draft_gar'+i).value;
}
}
if(ids_str==''){
multiLangValidate.dwrGetLang("erp",'请选择您要还原的记录',{callback:function(msg){n_A.divShow(msg); }});
n_D.closeDiv('remove');
return false;
}
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){

if(parseInt(xmlhttp3.responseText.length)==3){
multiLangValidate.dwrGetLang("erp",'还原完成',{callback:function(msg){window.location.reload();}});
}else{
multiLangValidate.dwrGetLang("erp",'您所选的'+xmlhttp3.responseText.substring(2,xmlhttp3.responseText.length-2).replace(/\⊙/g,'，')+'记录是从草稿箱转来的，不能还原',{callback:function(msg){alert(msg); window.location.reload();}});
}

}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST",'../../include_draft_gar_recovery_ok', true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str.substring(1))+'&tableName='+encodeURI(tableName)+'&gar_tag='+encodeURI(document.getElementById('gar_recovery_tag').value)+'&field='+encodeURI(document.getElementById('field1').value))} 
}

