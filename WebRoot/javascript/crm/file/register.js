/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var rT=false;
var bT=false;
var endaction=false;
var ns4 = document.layers;
var ns6 = document.getElementById && !document.all;
var ie4 = document.all;
offsetX = -60;
offsetY = -30;
var toolTipSTYLE="";
var sels;
var sels1;

function closediv(){
	var loaddiv=document.getElementById("loaddiv");
	loaddiv.style.display="none";
}
function initToolTips(){
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
function toolTip1(msg, fg, bg){
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

function HideOverSels(objID){
 sels = document.getElementsByTagName('select'); 
    for (var i = 0; i < sels.length; i++) 
      if (Obj1OverObj2(document.all[objID], sels[i])){
        sels[i].style.visibility = 'hidden'; }else{
		sels[i].style.visibility = 'visible';
		}         
}
function HideOverSels1(objID){
 sels1 = document.getElementsByTagName('select'); 
    for (var i = 0; i < sels1.length; i++) 
      if (Obj1OverObj2(document.all[objID], sels1[i])){
        sels1[i].style.visibility = 'hidden'; }else{
		sels1[i].style.visibility = 'visible';
		}         
}
function Obj1OverObj2(obj1, obj2){
  var pos1 = getPosition(obj1) 
  var pos2 = getPosition(obj2) 
  var result = true; 
  var obj1Left = pos1.left - window.document.body.scrollLeft; 
  var obj1Top = pos1.top - window.document.body.scrollTop; 
  var obj1Right = obj1Left + obj1.offsetWidth; 
  var obj1Bottom = obj1Top + obj1.offsetHeight;
  var obj2Left = pos2.left - window.document.body.scrollLeft; 
  var obj2Top = pos2.top - window.document.body.scrollTop; 
  var obj2Right = obj2Left + obj2.offsetWidth; 
  var obj2Bottom = obj2Top + obj2.offsetHeight;
  if (obj1Right <= obj2Left || obj1Bottom <= obj2Top || 
      obj1Left >= obj2Right || obj1Top >= obj2Bottom) 
    result = false; 
  return result; 
}
function sub_f(){
document.getElementById("niceform").style.display='block';
var w=(document.body.clientWidth-300)/2+"px";
var h=(document.body.clientHeight-200)/2+"px";
document.getElementById("niceform").style.position='absolute';
document.getElementById("niceform").style.top=h;
document.getElementById("niceform").style.left=w;
}
function msm_div(){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var xm=xmlhttp3.responseText.split(',');
var input_html="";
for(var i=0;i<xm.length;i++){
input_html+="<INPUT TYPE=\"checkbox\" NAME=\"TXT1\" TABINDEX=\"1\" ID=\"oCtrlID11"+i+"\" value="+xm[i]+" ><LABEL FOR=\"oCtrlID11"+i+"\" ACCESSKEY=\"1\"><SPAN id=\"human\">"+xm[i]+"</SPAN></LABEL>";
}
document.getElementById('okk').innerHTML=input_html;
document.getElementById("msm").style.display='block';
var w=(document.body.clientWidth-300)/2+"px";
var h=(document.body.clientHeight-200)/2+"px";
document.getElementById("msm").style.position='absolute';
document.getElementById("msm").style.top=h;
document.getElementById("msm").style.left=w;
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "ajax_query.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");	
xmlhttp3.send();				
} else {alert('Can not create XMLHttpRequest object, please check your web browser.');}
}
function transfer(filename){
var file_name='';
var tr_input=document.getElementById('okk').getElementsByTagName('input');
for(var i=0;i<tr_input.length;i++){
if(tr_input[i].type=='checkbox'){
if(tr_input[i].checked==true){
file_name+=tr_input[i].value+',';
}
}
}
file_name=file_name.substring(0,file_name.length-1);
var name=document.getElementById('hidden_name').value;
var cont=document.getElementById('msm_cont').value;

if(filename==null||filename==''||filename=='undefined') filename='179206725';
if(cont==null||cont==''||cont=='undefined')cont='179206725';

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
document.getElementById('msm').style.display='none';
document.getElementById('niceform').style.display='none';
alert('发送成功');
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "777.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");	
xmlhttp3.send('name='+name+'&&cont='+cont+'&&file_name='+file_name+'&&filename='+filename);				
} else {alert('Can not create XMLHttpRequest object, please check your web browser.');}
}

function fo_ok(){
if(doValidate('mutiValidation')){
document.getElementById("mutiValidation").submit();
}else{
return false;
}
}
function closefile(){
unloadCover('nseer1');
document.getElementById('nseer1').removeChild(document.getElementById('treeButton'));
document.getElementById('nseer1').style.display='none';
}