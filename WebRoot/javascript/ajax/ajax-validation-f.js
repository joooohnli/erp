/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/
function ajax_validation(valuee,valuea,valueb,valuec,url,valued,urlr,tothis){
var formName=document.getElementById(valuea);
var form=document.getElementById(valuee);
var Namevalue=encodeURI(formName.value);
if (Namevalue=='')
{
}else{
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
	var raRegExp = new RegExp("#ffffff","g");
	var r=xmlhttp.responseText.replace(raRegExp,"#000000");
	n_A.divShow(r);
}
}}};
		xmlhttp.open("POST", url, true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send('IDD=true&'+valuea+'='+Namevalue+'&valueb='+valueb+'&valuec='+valuec+'&valued='+valued+'&urlr='+urlr);
}}
}