/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function showChangeDiv(){
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/erpPlatform/config/divPrecision.xml','0');
document.getElementById('div_precision').value=document.getElementById('precision').innerHTML;
} 
function validate(){
var input=document.getElementById('div_precision');
input.value = input.value.replace(/[^0123456789]/g,'');
}
function send(){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
	if(parseInt(xmlhttp3.responseText)==1){
document.getElementById('precision').innerHTML=document.getElementById('div_precision').value;
n_D.closeDiv('remove');
	}else{
		return false;
	}

}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", '../../erpPlatform_config_precision_ok', true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('precision='+document.getElementById('div_precision').value);}
}