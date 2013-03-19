/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
 function closediv()
{
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}
var rT=false;
var bT=false;

var endaction=false;

var ns4 = document.layers;
var ns6 = document.getElementById && !document.all;
var ie4 = document.all;
offsetX = -60;
offsetY = -30;
var toolTipSTYLE="";
function initToolTips()
{
 if(ns4||ns6||ie4)
 {
 if(ns4) toolTipSTYLE = document.toolTipLayer;
 else if(ns6) toolTipSTYLE = document.getElementById("toolTipLayer").style;
 else if(ie4) toolTipSTYLE = document.all.toolTipLayer.style;
 if(ns4) document.captureEvents(Event.MOUSEMOVE);
 else
 {
 toolTipSTYLE.visibility = "visible";
 toolTipSTYLE.display = "none";
 }
 document.onmousemove = moveToMouseLoc;
 }
}

function moveToMouseLoc(e)
{
 if(ns4||ns6)
 {
 x = e.pageX;
 y = e.pageY;
 }
 else
 {
 x = event.x + document.body.scrollLeft;
 y = event.y + document.body.scrollTop;
 }
 toolTipSTYLE.left = x + offsetX;
 toolTipSTYLE.top = y + offsetY;
 return true;
}

function inner_div(va){
var div=document.createElement('div'); 
div.style.position='absolute'; 
div.id='confirm_div_id';
div.style.width='200px';
div.style.height='150px';
div.style.background='yellow';
div.style.left=(document.body.clientWidth-parseInt(div.style.width))/2+'px';
div.style.top=(document.body.clientHeight-parseInt(div.style.height))/2+'px';
div.innerHTML=va+'<div style="position:absolute;top:100px;left:80px"><input type=button onclick="closeConfirm();" value="<%=demo.getLang("erp","确定")%>"><div>';
document.body.appendChild(div);
}
function confirm_div(va){
var div=document.createElement('div');  
div.id='confirm_div_id';
div.style.position='absolute';
div.style.width='200px';
div.style.height='150px';
div.style.background='yellow';
div.style.left=(document.body.clientWidth-parseInt(div.style.width))/2+'px';
div.style.top=(document.body.clientHeight-parseInt(div.style.height))/2+'px';
div.innerHTML=va+'<div style="position:absolute;top:100px;left:80px"><input type=button value="<%=demo.getLang("erp","确定")%>" onclick="okConfirm()"><input type=button value="<%=demo.getLang("erp","取消")%>"  onclick="closeConfirm()"><div>';
document.body.appendChild(div);
}
function closeConfirm(){
var confirm_div_obj=document.getElementById('confirm_div_id');
document.body.removeChild(confirm_div_obj);
}
function okConfirm(){
var confirm_div_obj=document.getElementById('confirm_div_id');
document.body.removeChild(confirm_div_obj);
delSelNode('3');
}
function registerOk(){
if(doValidate('../../xml/hr/hr_file.xml','mutiValidation')){
var form = document.getElementById('mutiValidation');
form.action='../../hr_file_register_picture';
//if (doValidate('../../xml/qcs/complain/validation-config.xml', 'mutiValidation')){
	form.submit();
//}
}
}
