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
function toolTip(msg, fg, bg)
{
 if(toolTip.arguments.length < 1) 
 {
 if(ns4) 
 {
 toolTipSTYLE.visibility = "hidden";
 }
 else 
 {
 if (!endaction) {toolTipSTYLE.display = "none";}
 if (rT) document.all("msg1").filters[1].Apply();
 if (bT) document.all("msg1").filters[2].Apply();
 document.all("msg1").filters[0].opacity=0;
 if (rT) document.all("msg1").filters[1].Play();
 if (bT) document.all("msg1").filters[2].Play();
 if (rT){ 
 if (document.all("msg1").filters[1].status==1 || document.all("msg1").filters[1].status==0){ 
 toolTipSTYLE.display = "none";}
 }
 if (bT){
 if (document.all("msg1").filters[2].status==1 || document.all("msg1").filters[2].status==0){ 
 toolTipSTYLE.display = "none";}
 }
 if (!rT && !bT) toolTipSTYLE.display = "none";
 }
 }
 else 
 {
 if(!fg) fg = "#777777";
 if(!bg) bg = "#eeeeee";
 var content =
 '<table id="msg1" name="msg1" cellspacing="0" cellpadding="1" bgcolor="' + fg + '" class="trans_msg"><td <%=TD_STYLE3%> class="TD_STYLE3">' +
 '<table cellspacing="0" cellpadding="3" bgcolor="' + bg + 
 '"><td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><font face="Arial" width=100% color="' + fg +
 '">' + msg +
 '&nbsp;</td></table></td></table>';

 if(ns4)
 {
 toolTipSTYLE.document.write(content);
 toolTipSTYLE.document.close();
 toolTipSTYLE.visibility = "visible";
 }
 if(ns6)
 {
 document.getElementById("toolTipLayer").innerHTML = content;
 toolTipSTYLE.display='block'
 }
 if(ie4)
 {
 document.all("toolTipLayer").innerHTML=content;
 toolTipSTYLE.display='block'
 var cssopaction=document.all("msg1").filters[0].opacity
 document.all("msg1").filters[0].opacity=0;
 if (rT) document.all("msg1").filters[1].Apply();
 if (bT) document.all("msg1").filters[2].Apply();
 document.all("msg1").filters[0].opacity=cssopaction;
 if (rT) document.all("msg1").filters[1].Play();
 if (bT) document.all("msg1").filters[2].Play();
 }
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

initToolTips();