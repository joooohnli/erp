/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function closefile(){
document.getElementById('nseer1').style.display='none';
document.body.removeChild(document.getElementById('treeButton'));
}

function key()
{
	var locate=document.getElementById('locate');
	var key_locate=document.getElementById('key_locate');
	locate.style.display='none';
	key_locate.style.display='block';
	document.getElementById('timeLocateValidation').action='query_key_locate_getpara.jsp';
}
function back()
{
	var locate=document.getElementById('locate');
	var key_locate=document.getElementById('key_locate');
	locate.style.display='block';
	key_locate.style.display='none';
	document.getElementById('timeLocateValidation').action='query_locate_getpara.jsp';
}

function query_locate_seach(){
var fileKind_chain=document.getElementById('fileKind_chain').value;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	var cla=document.getElementById('search_suggest');
cla.innerHTML='';
if(xmlhttp3.responseText.length!=2){
	document.getElementById('search_suggest').style.display='none';
	}else{
	var value=xmlhttp3.responseText;
	var value1=value.split('⊙');
	for (var i = 1; i < value1.length-1; i++) {
		var suggest = '<div onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
		suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+id+'\');\" ';
		suggest += '>' + value1[i] + '</div>';
		conter += suggest;
}
cla.innerHTML = null;
cla.innerHTML = '';
cla.innerHTML = conter;
cla.style.display = 'block';
}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "quert_locate_seach.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('fileKind_chain='+fileKind_chain);
}
}