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

