<!--
*this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="mdemo" class="include.ajax.multi_businessComment" scope="page"/>
<jsp:useBean id="ademo" class="include.ajax.ajax_businessComment" scope="page"/>
<%
if(session.getAttribute("human_IDD")==null) response.sendRedirect("../../home/login.jsp");
String human_ID=(String)session.getAttribute("human_IDD");
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 ademo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<jsp:useBean id="browercheck" scope="session" class="include.nseer_cookie.BrowerVer"/>
<%
		String strhead = request.getHeader("User-Agent");
		if(strhead.indexOf(browercheck.IE)!=-1){
		 
			 	double ver = Double.parseDouble(strhead.substring(strhead.indexOf("MSIE ")+5,strhead.indexOf(";",strhead.indexOf("MSIE "))));
			 	if(ver <browercheck.IEVer){
			RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/alarm.html");
  dispatcher.include(request,response);
				}
		}
%>
<html>
<title><%=demo.getLang("erp","欢迎使用恩信科技开源ERP")%></title>
<head>
<link rel="stylesheet" type="text/css" media="all" href="menu.css">
<style>
#testDiv     { position: absolute; height: 70px; 
               right: 0px; bottom: 0px; width: 250; z-index: 5; 
               border: 0px outset white; margin: 0px; padding: 2px;
			   overflow: hidden;
              }
</style>
<style> 
.dragAble {position:relative;cursor:hand;}
A:visited {
	TEXT-DECORATION: none
}
A:active {
	TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: none
}
A:link {
	TEXT-DECORATION: none
}
</style>
<style>
.drag_text{
position:relative;
z-index:-1 ;
top:10px;
left:22px;
width:60px;
font-size : 9pt;
display:block;
padding:2px 5px 2px 0.5em;
color: #000000;
text-decoration: none;
white-space:nowrap;     
text-overflow:ellipsis;
overflow: hidden;
}

.drag_text2{
position:relative;
z-index:-1 ;
top:10px;
left:22px;
width:48px;
font-size : 9pt;
display:block;
padding:2px 5px 2px 0.5em;
color: #000000;
text-decoration: none;
white-space:nowrap;     
text-overflow:ellipsis;
overflow: hidden;
}

.drag_text1{
position:relative;
z-index:-1 ;
top:10px;
left:0px;
width:110px;
font-size : 9pt;
display:block;
padding:2px 5px 2px 0.5em;
border-left: 0px ;
border-right: 0px ;
background-color: #99FF33;
color: #000000;
text-decoration: none;
text-align: center;
}

.del_drag_text{
z-index:-1 ;
width:80px;
font-size : 9pt;
display:block;
padding:2px 5px 2px 0.5em;
border-left: 0px ;
border-right: 0px ;
background-color: #508fc4;
color: #000000;
text-decoration: none;
text-align: center;
}
.del_drag_text888{

}
.style10{
color: #000000;
font-size : 10pt;
}
</style>


<style> 
.dragAble1 {position:relative;cursor:nw-resize;} 
</style> 
<script>

window.setInterval("session1()",3000);

function session1(){
var xmlhttp2;

if (window.XMLHttpRequest)
		{
		xmlhttp2=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp2=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp2) {
			xmlhttp2.onreadystatechange = function() {
			if (xmlhttp2.readyState==4)
				{
				try {
					if(xmlhttp2.status==200) {
var text1='';
text1=xmlhttp2.responseText;
var task1=document.getElementById("testDiv");
if(parseInt(text1)==456){
	
	task1.style.display='block';
}
if(parseInt(text1)==123)
{
		task1.style.display='none';
	}
}else {
						}
					} catch(exception) {
					}
				}
			};
		xmlhttp2.open("POST", "session.jsp", true);
		xmlhttp2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp2.send('');				
		} else {	        
}
}



</script>




<script language="javascript">


var t=1;
var div_img_id;
var divId;

function del_div(divId){
close_run();
this.divId=divId;
if(t!=1){
var img_div_id=document.getElementById(div_img_id+'TTT');
if(img_div_id!=null){

img_div_id.className=null;
}
var href_div_id=document.getElementById(div_img_id+'TTTT');

if(href_div_id!=null){
if (window.XMLHttpRequest)
{

href_div_id.className='drag_text2';

}else if (window.ActiveXObject)
{

href_div_id.className='drag_text';

}

href_div_id.onmouseover=function (){

href_div_id.className='drag_text1';

};


href_div_id.onmouseout=function (){



if (window.XMLHttpRequest)
		{
href_div_id.className='drag_text2';

		}
		else if (window.ActiveXObject)
		{
href_div_id.className='drag_text';

}


};

}

}
div_img_id=divId.id;

var img_div=document.getElementById(divId.id+'TTT');

var href_div=document.getElementById(divId.id+'TTTT');

href_div.onmouseover=null;

href_div.onmouseout=null;	

img_div.className='del_drag_text';

href_div.className='del_drag_text';

t++;

}


document.onkeydown=mm;

var divv_img=false;
function mm(evt)
{
if (window.XMLHttpRequest)
		{
if(evt.keyCode==46)divv_img=true;
		}
		else if (window.ActiveXObject)
		{
if(event.keyCode==46)divv_img=true;

}

if(divv_img)
{
var xmlhttp_img;
if (window.XMLHttpRequest)
		{
		xmlhttp_img=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp_img=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp_img) {
			xmlhttp_img.onreadystatechange = function() {
			if (xmlhttp_img.readyState==4)
				{
					if(xmlhttp_img.status==200) {

divv_img=false;

var sTr=document.getElementById(divId.id);

if(sTr!=null){
sTr.parentNode.removeChild(sTr);

alert("<%=demo.getLang("erp","删除成功")%>")
}
}else {
alert( xmlhttp_img.status + '=' + xmlhttp_img.statusText);							}
}
}
xmlhttp_img.open("POST", "../../drag_img_del", true);
xmlhttp_img.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp_img.send('id='+img_id);				
} 

}
}

function close_run(){

var view=document.getElementById("module_first");
var ok=document.getElementById("ok");
var module_two=document.getElementById("module_two");
var module_three=document.getElementById("module_three");
var module_four=document.getElementById("module_four");
if(view!=null) view.style.display='none';
if(module_two!=null) module_two.style.display='none';
if(module_three!=null) module_three.style.display='none';
if(module_four!=null) module_four.style.display='none';
if(ok!=null) ok.style.display='none';

if(divId!=null){

var img_div_id=document.getElementById(divId.id+'TTT');
if(img_div_id!=null){
img_div_id.className=null;
}
var href_div_id=document.getElementById(divId.id+'TTTT');

if(href_div_id!=null){

if (window.XMLHttpRequest)
{

href_div_id.className='drag_text2';

}else if (window.ActiveXObject)
{

href_div_id.className='drag_text';

}

href_div_id.onmouseover=function (){

href_div_id.className='drag_text1';

};


href_div_id.onmouseout=function (){

if (window.XMLHttpRequest)
{

href_div_id.className='drag_text2';

}else if (window.ActiveXObject)
{

href_div_id.className='drag_text';

}

};

}
}
}


var num=1;
var ie=document.all; 
var nn6=document.getElementById&&!document.all; 
var nn8=document.getElementById&&!document.all; 
var isdrag=false; 
var y,x;
var y1,x1; 
var oDragObj; 
function mouse_div(){
 num=2;
}
function moveMouse(e) { 
 if (isdrag) { 
 oDragObj.style.top  =  (nn6 ? nTY + e.clientY - y : nTY + event.clientY - y)+"px"; 
 oDragObj.style.left  =  (nn6 ? nTX + e.clientX - x : nTX + event.clientX - x)+"px"; 
 return false; 
 } 
} 
var img_id;
function initDrag(e) { 
 var oDragHandle = nn6 ? e.target : event.srcElement; 
 var topElement = "HTML"; 
 while (oDragHandle.tagName != topElement && oDragHandle.className != "dragAble") { 
 oDragHandle = nn6 ? oDragHandle.parentNode : oDragHandle.parentElement; 
 } 
 if (oDragHandle.className=="dragAble") { 
 isdrag = true; 
 oDragObj = oDragHandle; 
 img_id=oDragObj.id;
 nTY = parseInt(oDragObj.style.top+0); 
 y = nn6 ? e.clientY : event.clientY; 
 nTX = parseInt(oDragObj.style.left+0); 
 x = nn6 ? e.clientX : event.clientX; 
 document.onmousemove=moveMouse; 
 return false; 
 } 
} 
document.onmousedown=initDrag; 
document.onmouseup=dragimg;	

function up_div(e){
var nn8;
if(num==2){
y1 = nn8 ? e.clientY : event.clientY; 
x1 = nn8 ? e.clientX : event.clientX;
var divHeight=document.body.clientHeight;
var divWidth=document.body.clientWidth;
var testDiv=document.getElementById("testDiv");
testDiv.style.height=divHeight-y1;
testDiv.style.width=divWidth-x1;
num=1;
}
}
function dragimg(e){

var img_div_id=document.getElementById(img_id+'TTT');
if(img_div_id!=null){
img_div_id.className=null;
}
var href_div_id=document.getElementById(img_id+'TTTT');

if(href_div_id!=null){

if (window.XMLHttpRequest)
{

href_div_id.className='drag_text2';

}else if (window.ActiveXObject)
{
href_div_id.className='drag_text';

}

href_div_id.onmouseover=function (){

href_div_id.className='drag_text1';

};


href_div_id.onmouseout=function (){

if (window.XMLHttpRequest)
{

href_div_id.className='drag_text2';

}else if (window.ActiveXObject)
{

href_div_id.className='drag_text';

}

};

}




















var nn7=document.getElementById&&!document.all; 
var oDragHandle1 = nn7 ? e.target : event.srcElement; 
isdrag=false;

 var topElement = "HTML"; 
 while (oDragHandle1.tagName != topElement && oDragHandle1.className != "dragAble") { 
 oDragHandle1 = nn6 ? oDragHandle1.parentNode : oDragHandle1.parentElement; 
 } 
if (oDragHandle1.className=="dragAble") {
var drag_img_top=oDragObj.style.top;
var drag_img_left=oDragObj.style.left;
var drag_img_topa=parseInt(drag_img_top);
var drag_img_leftb=parseInt(drag_img_left);
var recover=document.getElementById("recover");
var toop=parseInt(recover.style.top)+40;
var body_left=parseInt(document.body.clientWidth)-120;
if(drag_img_topa<toop&&body_left<drag_img_leftb){
var xmlhttp_img;
if (window.XMLHttpRequest)
		{
		xmlhttp_img=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp_img=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp_img) {
			xmlhttp_img.onreadystatechange = function() {
			if (xmlhttp_img.readyState==4)
				{
					if(xmlhttp_img.status==200) {
var sTr=document.getElementById(img_id);
if(sTr!=null){
sTr.parentNode.removeChild(sTr);

alert("<%=demo.getLang("erp","删除成功")%>")
}
}else {
alert( xmlhttp_img.status + '=' + xmlhttp_img.statusText);							}
}
				}
		xmlhttp_img.open("POST", "../../drag_img_del", true);
		xmlhttp_img.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp_img.send('id='+img_id);				
		} 
}else{
var xmlhttp_img1;
if (window.XMLHttpRequest)
		{
		xmlhttp_img1=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp_img1=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp_img1) {
			xmlhttp_img1.onreadystatechange = function() {
			if (xmlhttp_img1.readyState==4)
				{
				try {
					if(xmlhttp_img1.status==200) {
}else {
alert( xmlhttp_img1.status + '=' + xmlhttp_img1.statusText);							
						}
					} catch(exception) {
						alert(exception);                         
					}
				}
			};
		xmlhttp_img1.open("POST", "../../update_dragImg", true);
		xmlhttp_img1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		xmlhttp_img1.send('id='+img_id+'&drag_img_top='+drag_img_top+'&drag_img_left='+drag_img_left);				
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
}
}
}

}
</script> 
<script>
var url;
var vheight = window.screen.height-200;
var vwidth =  window.screen.width-200;
function openq(file){
close_run();
window.open(file,"","height="+vheight+",width="+vwidth+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");
}
</script>
</head>
<body style="background-image: url(../../images/nseer.jpg);" onload="module_first()">
<script>
var image;
var mod_name;
var top_num;
var div_num;
var topheight;
function body_top(num){
this.top_num=num;
}
function div_top(num1){
this.div_num=num1;
topheight=top_num+div_num;
}
function module_first(){

mine();
var menu=document.getElementById("module_first");
menu.style.position='absolute';
var li = menu.getElementsByTagName("li");
var menu_height=li.length*20;
menu.style.top=document.body.clientHeight-40-menu_height;
var run=document.getElementById("run");
run.style.position='absolute'
run.style.top=document.body.clientHeight-30;
run.style.left=0;
var run_button=document.getElementById("run_button");
run_button.style.position='absolute'
run_button.style.top=document.body.clientHeight-20;
run_button.style.left=3;
//run_button.style.zIndex=500; 
view_text_div();
}



var module_all="";
function menu_first(module_name,view_tree_name,gategory){
module_all="";
module_all=module_all+module_name;
var sTr=document.getElementById("ok");
if(sTr!=null){
sTr.parentNode.removeChild(sTr);
}
if(view_tree_name!=undefined&&gategory!=undefined){
var xmlhttp;
if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
				try {
					if(xmlhttp.status==200) {
var module_two=document.getElementById("module_two");
module_two.innerHTML='';
var str = xmlhttp.responseText.split("\n");
var suggest='<ul>'
for(i=0; i < str.length - 1; i++) {
 suggest+= '<li onclick="div_top(this.offsetTop)"><a id="active" ' + str[i] + '</a></li>';
}
suggest=suggest+'</ul>'
module_two.innerHTML=suggest;
var module_three1=document.getElementById("module_three");
var module_four1=document.getElementById("module_four");
if(module_three1!=null) module_three1.style.display='none';
if(module_four1!=null) module_four1.style.display='none';
}else {
alert( xmlhttp.status + '=' + xmlhttp.statusText);							
						}
					} catch(exception) {							
							 alert(exception);                       
					}
				}
			};
		xmlhttp.open("POST", "../../workSpace_use", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		xmlhttp.send('module_all='+module_all+'&view_tree_name='+view_tree_name+'&gategory='+gategory);				
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
}
}
var module_first=document.getElementById("module_first");
module_two.style.position='absolute';
var li = module_two.getElementsByTagName("li");
module_two.style.left=parseInt(module_first.style.left)+parseInt(module_first.style.width);
module_two.style.top=parseInt(topheight);
module_two.style.display=module_two.style.display=='block'?'block':'block';
if(module_two.style.display=='none')
{
var module_three=document.getElementById("module_three");
var module_four=document.getElementById("module_four");
if(module_three!=null) module_three.style.display='none';
if(module_four!=null) module_four.style.display='none';
}
}
function menu_two(view_tree_name,gategory,m_name){
if(module_all.indexOf("--")==-1){
module_all=module_all+"--"+m_name;
}else{
var module_length=module_all.indexOf("--");
module_all=module_all.substring(0,module_length)+"--"+m_name;
}
var sTr=document.getElementById("ok");
if(sTr!=null){
sTr.parentNode.removeChild(sTr);
}
if(view_tree_name!=undefined&&gategory!=undefined){
var xmlhttp;
if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
				try {
					if(xmlhttp.status==200) {
var module_three=document.getElementById("module_three");
var sTr=document.getElementById("ok");
if(sTr!=null){
sTr.parentNode.removeChild(sTr);
}
module_three.innerHTML='';
var str = xmlhttp.responseText.split("\n");
var suggest='<ul>'
for(i=0; i < str.length - 1; i++) {
 suggest+= '<li onclick="div_top(this.offsetTop)"><a id="active" ' + str[i] + '</a></li>';
}
suggest=suggest+'</ul>'
module_three.innerHTML=suggest;
var module_four=document.getElementById("module_four");
if(module_four!=null) module_four.style.display='none';
}else {
alert( xmlhttp.status + '=' + xmlhttp.statusText);							
						}
					} catch(exception) {							
							 alert(exception);                        
					}
				}
			};
		xmlhttp.open("POST", "../../workSpace_useTwo", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		xmlhttp.send('module_all='+module_all+'&view_tree_name='+view_tree_name+'&gategory='+gategory);				
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
}
};
var module_two=document.getElementById("module_two");
module_three.style.position='absolute';
module_three.style.left=parseInt(module_two.style.left)+parseInt(module_two.style.width);
module_three.style.top=parseInt(topheight);
module_three.style.display=module_three.style.display=='block'?'block':'block';
if(module_three.style.display=='none')
{
var module_four=document.getElementById("module_four");
if(module_four!=null)module_four.style.display='none';
}
}
function menu_three(view_tree_name,gategory,mo_name){
var module_length=module_all.indexOf("--");
var module_all1=module_all.substring(0,module_length);
var module_all2=module_all.substring(module_length+2,module_all.length);
if(module_all2.indexOf("--")!=-1){
var module_length1=module_all2.indexOf("--");
module_all2=module_all2.substring(0,module_length1);
}
module_all=module_all1+"--"+module_all2+"--"+mo_name;
var sTr=document.getElementById("ok");
if(sTr!=null){
sTr.parentNode.removeChild(sTr);
}
if(view_tree_name!=undefined&&gategory!=undefined){
var xmlhttp;
if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
				try {
					if(xmlhttp.status==200) {
var module_four=document.getElementById("module_four");
module_four.innerHTML='';
var str = xmlhttp.responseText.split("\n");
var suggest='<ul>'
for(i=0; i < str.length - 1; i++) {
 suggest+= '<li><a id="active" ' + str[i] + '</a></li>';
}
suggest=suggest+'</ul>'
module_four.innerHTML=suggest;
}else {
alert( xmlhttp.status + '=' + xmlhttp.statusText);							
						}
					} catch(exception) {							
							 alert(exception);                        
					}
				}
			};
		xmlhttp.open("POST", "../../workSpace_useTwo", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		xmlhttp.send('module_all='+module_all+'&view_tree_name='+view_tree_name+'&gategory='+gategory);				
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
}
};
var module_four=document.getElementById("module_four");
var module_three=document.getElementById("module_three");
module_four.style.position='absolute';
module_four.style.left=parseInt(module_three.style.left)+parseInt(module_three.style.width);
module_four.style.top=parseInt(topheight);
module_four.style.display=module_four.style.display=='block'?'block':'block';
if(module_three.style.display=='none')
{
var module_four=document.getElementById("module_four");
if(module_four!=null)module_four.style.display='none';
}
}
function view(){
var view=document.getElementById("module_first");
var li = view.getElementsByTagName("li");
view.style.display=view.style.display=='block'?'none':'block';
if(view.style.display=='none')
{
var ok=document.getElementById("ok");
var module_two=document.getElementById("module_two");
var module_three=document.getElementById("module_three");
var module_four=document.getElementById("module_four");
if(module_two!=null) module_two.style.display='none';
if(module_three!=null) module_three.style.display='none';
if(module_four!=null) module_four.style.display='none';
if(ok!=null) ok.style.display='none';
}
} 
</script>
<script>
var link;
var module_name;
var category;
var tree_view_name;
var etv;
var id;
function right_click(module_name1,link1,id,category,tree_view_name){
this.category=category;
this.tree_view_name=tree_view_name;
this.module_name=module_name1;
this.link=link1;
this.id=id;
var sTr=document.getElementById("ok");
if(sTr!=null){
sTr.parentNode.removeChild(sTr);
}
var right_menu = document.createElement("div");
right_menu.style.zIndex="550"; 
right_menu.id='ok';
right_menu.innerHTML='<a style="z-index:550;width:150px;cursor:hand; font-size : 9pt;padding:2px 5px 2px 0.5em;border-left: 10px solid #FF99FF;border-right: 10px solid #FF99FF;background-color: red;color: #ffffff;text-decoration: none;" href="javascript:drag_img_update_del();"><%=demo.getLang("erp","在桌面创建快捷方式")%></a>';
right_menu.style.position='absolute';
right_menu.style.left=etv.clientX;
right_menu.style.top=etv.clientY +document.body.scrollTop;
var xmlhttp1;
if (window.XMLHttpRequest)
		{
		xmlhttp1=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp1=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp1) {
			xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState==4)
				{
				try {
					if(xmlhttp1.status==200) {
image=xmlhttp1.responseText;
document.body.appendChild(right_menu);
}else {
alert( xmlhttp1.status + '=' + xmlhttp1.statusText);							
						}
					} catch(exception) {
						alert(exception);                         
					}
				}
			};
		xmlhttp1.open("POST", "../../workSpace_useImg", true);
		xmlhttp1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp1.send('module_name='+module_name);				
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
}
}
</script>
<script>
var w=100;
var p=300;
var r=1;
var u=100;
var i=2;
var left_y=10;
var left_x=10;
function drag_img_update_del(){
var vv = new Array("acd.gif","abc.gif","cetset1.gif","design1.gif","compute.gif","nseer_extend.gif","jjjjj1.gif","hr.gif","fgh.gif","design1.gif","acd.gif");
var body_height=document.body.clientWidth;
var task = document.createElement("div");
if(i==vv.length) i=0;
u=u+100;
var num=p-r;
if (u>body_height){
u=100;
left_x=left_x+90;
left_y=10;
var xmlhttp;
if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
				try {
					if(xmlhttp.status==200) {
var bin=xmlhttp.responseText.split(",");
if(bin[0]=="1"){
var module_innser1;
if(link==''||link==null){
module_innser1="<div class=\"dragAble\" id="+id+" onclick=\"del_div(this)\" style=\"position:absolute;display:block;z-index:"+num+" ;top:"+left_x+"px;left:"+left_y+"px;height:100;width=110;\"><div align=center id="+id+"TTT ><img src=../../"+image+" width=50 height=50 ondblclick=\"javascript:openq('workspace_div.jsp?tree_view_name="+toUtf8String.utf8String(exchange.toURL(tree_view_name))+"&category="+toUtf8String.utf8String(exchange.toURL(category))+"');\"></div>";
module_innser1+="<a id="+id+"TTTT  <%if(strhead.indexOf(browercheck.IE)!=-1){%>class=\"drag_text\"<%}else{%>class=\"drag_text2\"<%}%> ";
module_innser1+="ondblclick=\"javascript:openq('workspace_div.jsp?tree_view_name="+toUtf8String.utf8String(exchange.toURL(tree_view_name))+"&category="+toUtf8String.utf8String(exchange.toURL(category))+"');\" ";
}
else{
module_innser1="<div class=\"dragAble\"  id="+id+" onclick=\"del_div(this)\" style=\"position:absolute;display:block;z-index:"+num+" ;top:"+left_x+"px;left:"+left_y+"px;height:100;width=110;\"><div align=center id="+id+"TTT ><img src=../../"+image+" width=50 height=50 ondblclick=\"javascript:openq('../../"+link+"');\"></div>";
module_innser1+="<a id="+id+"TTTT  <%if(strhead.indexOf(browercheck.IE)!=-1){%>class=\"drag_text\"<%}else{%>class=\"drag_text2\"<%}%> ";
module_innser1+="ondblclick=\"javascript:openq('../../"+link+"');\" ";
}
module_innser1+="onmouseover=\"this.className='drag_text1'\" "; module_innser1+="onmouseout=\"this.className='<%if(strhead.indexOf(browercheck.IE)!=-1){%>drag_text<%}else{%>drag_text2<%}%>'\">"+bin[1]+"</a></div>";

task.innerHTML=module_innser1;
left_y=left_y+100;
}else{
alert("<%=demo.getLang("erp","快捷方式已存在")%>")
}
}else {
alert( xmlhttp.status + '=' + xmlhttp.statusText);							
						}
					} catch(exception) {							
							 alert(exception);                        
					}
				}
			};
if(vv[i]==undefined) vv[i]="design1.gif";
		xmlhttp.open("POST", "../../drag_img", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp.send('id='+id+'&link='+link+'&drag_text='+module_name+'&drag_img_top='+left_x+'&drag_img_left='+left_y+'&drag_img_name='+image+'&tree_view_name='+tree_view_name+'&category='+category);			
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
}
}else{
var xmlhttp;
if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
				try {
					if(xmlhttp.status==200) {
var bin=xmlhttp.responseText.split(",");
if(bin[0]=="1"){
var module_innser;
if(link==''||link==null){
module_innser="<div class=\"dragAble\" id="+id+" onclick=\"del_div(this)\" style=\"position:absolute;display:block;z-index:"+num+" ;top:"+left_x+"px;left:"+left_y+"px;height:100;width=110;\"><div align=center id="+id+"TTT ><img src=../../"+image+"  width=50 height=50 ondblclick=\"javascript:openq('workspace_div.jsp?tree_view_name="+toUtf8String.utf8String(exchange.toURL(tree_view_name))+"&category="+toUtf8String.utf8String(exchange.toURL(category))+"');\"></div>";
//alert('../../'+image);
module_innser+="<a id="+id+"TTTT  <%if(strhead.indexOf(browercheck.IE)!=-1){%>class=\"drag_text\"<%}else{%>class=\"drag_text2\"<%}%> ";
module_innser+="ondblclick=\"javascript:openq('workspace_div.jsp?tree_view_name="+toUtf8String.utf8String(exchange.toURL(tree_view_name))+"&category="+toUtf8String.utf8String(exchange.toURL(category))+"');\" ";
}
else{
module_innser="<div class=\"dragAble\" id="+id+" onclick=\"del_div(this)\" style=\"position:absolute;display:block;z-index:"+num+" ;top:"+left_x+"px;left:"+left_y+"px;height:100;width=110;\"><div align=center id="+id+"TTT ><img src=../../"+image+"  width=50 height=50 ondblclick=\"javascript:openq('../../"+link+"');\"></div>";
//alert('../../'+image);
module_innser+="<a id="+id+"TTTT  <%if(strhead.indexOf(browercheck.IE)!=-1){%>class=\"drag_text\"<%}else{%>class=\"drag_text2\"<%}%> ";
module_innser+="ondblclick=\"javascript:openq('../../"+link+"');\" ";
}
module_innser+="onmouseover=\"this.className='drag_text1'\" "; module_innser+="onmouseout=\"this.className='<%if(strhead.indexOf(browercheck.IE)!=-1){%>drag_text<%}else{%>drag_text2<%}%>'\">"+bin[1]+"</a></div>";
task.innerHTML=module_innser;
//left_x=left_x;
left_y=left_y+100;
}else{
alert("<%=demo.getLang("erp","快捷方式已存在")%>")
}
}else {
alert( xmlhttp.status + '=' + xmlhttp.statusText);							
						}
					} catch(exception) {							
							 alert(exception);
					}
				}
			};
		xmlhttp.open("POST", "../../drag_img", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		xmlhttp.send('id='+id+'&link='+link+'&drag_text='+module_name+'&drag_img_top='+left_x+'&drag_img_left='+left_y+'&drag_img_name='+image+'&tree_view_name='+tree_view_name+'&category='+category);	
		} else {	        
			  alert('Can not create XMLHttpRequest object, please check your web browser.');
};
}
document.body.appendChild(task);
r++;
i++;
w++;
var ok=document.getElementById("ok");
if(ok!=null) ok.style.display='none';
}
</script>

<script language="JavaScript"> 
var ii=0; 
var timer; 
var speed=1000; 
function mine() 
{
if(ii==1){
var title_div=document.getElementById('title_div');
var ff=document.getElementById('ff');
title_div.style.display='block';
ff.style.display='block';

}
if(ii==10){
changeOpacity();

}
ii++; 
timer=setTimeout("mine()",speed);

} 

</script>
<script>
IEcuropa = 100;
var FFcuropa = 1;
function changeOpacity(){
 //alert(makeElement.style.filter);
 //alert(typeof(makeElement.style.opacity));

 var makeElement=document.getElementById('title_div');
var text_makeElement=document.getElementById('ff');
 if(typeof(makeElement.style.filter) == "undefined"){
  //如果firefox浏览器
  FFcuropa -= 0.1;
  makeElement.style.opacity = FFcuropa;
  if(FFcuropa > 0){
   setTimeout("changeOpacity();",100);
  }else{
   FFcuropa = 1;
   makeElement.parentNode.removeChild(makeElement);//移除需要删除的元素
      text_makeElement.style.display='none';

  }
 }else if(typeof(makeElement.style.opacity) == "undefined"){
  //如果是IE浏览器
  IEcuropa -= 10;
  makeElement.style.filter="Alpha(Opacity="+IEcuropa+")";
 
  if(IEcuropa > 0){
   setTimeout("changeOpacity();",100);
  }else{
   IEcuropa = 100;
   makeElement.parentNode.removeChild(makeElement);
   text_makeElement.style.display='none';
   //移除需要删除的元素
  }
 }else{
 }
}
</script>
<script>
function view_text_div(){

var title_div=document.getElementById("title_div");
title_div.style.position='absolute'
title_div.style.top=document.body.clientHeight-120;
title_div.style.left=60;
title_div.style.display='none';

var title_div_text=document.getElementById("ff");
title_div_text.style.position='absolute'
title_div_text.style.top=document.body.clientHeight-110;
title_div_text.style.left=73;
title_div_text.style.display='none';
title_div_text.style.width='300px';
title_div_text.style.height='25px';

}

</script>

<script>
 function closead(){
	   var obj_title_div=document.getElementById("title_div");
	    var obj=document.getElementById("ff");
	  obj.style.display="none";
	obj_title_div.style.display="none";
  }
  </script>
<div id=ff style="z-index:100;display:none;" class="style10"><%=demo.getLang("erp","点击这里出现菜单后，您可以直接操作，也可以点击鼠标右键创建快捷方式，您也可以选择时尚界面操作，也可以在此退出系统。")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/close.jpg" onClick="closead()">
   
 
</div>
 
<div id=title_div style="display:none">
<img src="desk.gif">
</div>

<div style="display:none" id="title_recover"><div style="background:#FFFFCC;padding: 2px 5px 2px 0.5em" class="style10"><%=demo.getLang("erp","将快捷方式拖至此处删除")%></div></div>

<div id="recover" style="position:absolute;z-index:100;top:0px;right:0px;width:70;height:70;" onmouseover="title_recover()" onmouseout="title_recover1()">
<table>
<tr><td><img src="../../images/trash.gif" width=50 height=50></td></tr><tr><td align="center" class="style10"><%=demo.getLang("erp","回收站")%></td></tr>
</table>
</div>

<div style="display:none" id="title_top"><div style="background:#FFFFCC;padding: 2px 5px 2px 0.5em" class="style10"><%=demo.getLang("erp","单击这里开始运行恩信科技ERP软件")%></div></div>

<div style="width:100%;height:100%" onclick="close_run()" onmouseup="up_div()"></div>
<div oncontextmenu="return false;" style="width:200px;position:absolute;left:0px;border-top:1px solid #d4d4d4;" id="module_first" onmouseover="body_top(this.offsetTop)">
<ul>
<li><a href="http://www.nseer.com" target="_blank"><%=demo.getLang("erp","欢迎使用恩信科技ERP软件V6.30")%></a></li>
<%
String task="";
String sql="select * from security_config_public_char where kind='task'";
ResultSet rs=security_db.executeQuery(sql);
if(rs.next()){
	task=rs.getString("type_name");
}
sql="select * from security_workspace where human_ID='"+human_ID+"'";
rs=security_db.executeQuery(sql);
while(rs.next()){
if(rs.getString("link").equals("")){
%>
<li onclick="div_top(this.offsetTop)"><a style="background:#96E1A0" href="javascript:menu_first('<%=rs.getString("module_name")%>','<%=rs.getString("view_tree_name")%>','<%=rs.getString("CATEGORY")%>');" oncontextmenu="etv=event;right_click('<%=rs.getString("module_name")%>','','img<%=rs.getString("id")%>','0','<%=rs.getString("view_tree_name")%>_view')"><font style="color:#000000"><%=demo.getLang("erp",rs.getString("module_name"))%></font></a></li>
<%}else{%>
<li><a href="javascript:openq('../../<%=rs.getString("link")%>');" oncontextmenu="right_click('<%=rs.getString("module_name")%>','<%=rs.getString("link")%>','img<%=rs.getString("id")%>')" ><%=demo.getLang("erp",rs.getString("module_name"))%></a></li>
<%}}%>
<li><a href="../../main/index1.jsp"><font color="#000000"><%=demo.getLang("erp","时尚界面")%></font></a></li>
<li><a href="../../home/logout.jsp"><font color="#000000"><%=demo.getLang("erp","退出系统")%></font></a></li>
</ul>
</div>
<div oncontextmenu="return false;" style="display:none;width:200px;" id=module_two onmouseover="body_top(this.offsetTop)">
</div>
<div oncontextmenu="return false;" style="display:none;width:200px;" id=module_three onmouseover="body_top(this.offsetTop)">
</div>
<div oncontextmenu="return false;" style="display:none;width:200px;" id=module_four>
</div>
<div id="run" onmouseover="title_run()" onmouseout="title_run1()"><a href="#" onclick="view()"><img src="../../images/erp.gif" border="0"  ></a></div>
<div id="run_button" onmouseover="title_run()" onmouseout="title_run1()" class="style10"><a href="#" onclick="view()"><font color="#000000"><%=demo.getLang("erp","恩信科技ERP")%></font></a></div>
<script>
function title_run1(){
var title_top=document.getElementById("title_top");
title_top.style.display='none';

}
function title_run(){
var title_top=document.getElementById("title_top");
title_top.style.display='block';
title_top.style.position='absolute';
title_top.style.top=document.body.clientHeight-50;
title_top.style.left=10;

}
</script>
<table width=100%>


<%
String sql1="select * from drag_img where human_ID='"+human_ID+"'";
ResultSet rss=security_db.executeQuery(sql1);
int yy=300;
String img_id="";
String groupName="";
while(rss.next()){
img_id=rss.getString("img_id");
if(!rss.getString("link").equals("")){
%>
<div onclick="del_div(this)" ondblclick="javascript:openq('../../<%=rss.getString("link")%>');" class="dragAble" id=<%=img_id%>
style="position:absolute;display:block;z-index:<%=yy-1%>;top:<%=rss.getString("drag_img_top")%>;left:<%=rss.getString("drag_img_left")%>;height:100;width=110"><div id="<%=img_id%>TTT" align=center><img src=../../<%=rss.getString("drag_img_name")%> width=50;height=50;></div>
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<a class="drag_text" id="<%=img_id%>TTTT" onmouseover="this.className='drag_text1'" onmouseout="this.className='drag_text'">
<%}else{%>
<a class="drag_text2" id="<%=img_id%>TTTT" onmouseover="this.className='drag_text1'" onmouseout="this.className='drag_text2'">
<%}
}else{%>
<div onclick="del_div(this)" ondblclick="javascript:openq('workspace_div.jsp?tree_view_name=<%=toUtf8String.utf8String(exchange.toURL(rss.getString("tree_view_name")))%>&category=<%=toUtf8String.utf8String(exchange.toURL(rss.getString("category")))%>');" class="dragAble" id=<%=img_id%>
style="position:absolute;display:block;z-index:<%=yy-1%>;top:<%=rss.getString("drag_img_top")%>;left:<%=rss.getString("drag_img_left")%>;height:100;width=110"><div align=center id="<%=img_id%>TTT"><img src=../../<%=rss.getString("drag_img_name")%> width=50;height=50; ></div>
<%
if(strhead.indexOf(browercheck.IE)!=-1){
%>
<a class="drag_text" id="<%=img_id%>TTTT" onmouseover="this.className='drag_text1'" onmouseout="this.className='drag_text'">
<%}else{%>
<a class="drag_text2" id="<%=img_id%>TTTT" onmouseover="this.className='drag_text1'" onmouseout="this.className='drag_text2'">
<%}}
if(rss.getString("drag_text").indexOf("--")==-1){
%>
<%=demo.getLang("erp",rss.getString("drag_text"))%>
<%}else{
groupName=rss.getString("tree_view_name").substring(0,rss.getString("tree_view_name").indexOf("_"))+"Tree";
	%>
<%=mdemo.getLang(ademo,groupName,rss.getString("drag_text"))%>
<%}%>
</a></div></div>
</table>
<%
	yy--;
}
security_db.close();
%>
<script>
function title_recover1(){
var title_top=document.getElementById("title_recover");
title_top.style.display='none';

}
function title_recover(){
var title_top=document.getElementById("title_recover");
title_top.style.display='block';
title_top.style.position='absolute';
title_top.style.top=10;
title_top.style.right=60;

}</script>



<%if(task.equals("是")){%>
<div  id="testDiv" style="position: absolute;height: 200px; right: 0px; bottom: 0px; width: 250;border: 0px outset white; margin: 0px;z-index:2000;
padding: 0px;overflow: hidden;border:0px solid #ff6d00;width:240px;padding:0px 0;" style="display:none"><iframe src="task.jsp" width="100%" height="100%" scrolling="no"/></div>
<%}else{%>
<div  id="testDiv"></div>
<%}%>
<div style="display:none"><iframe src="../../main/refresh.jsp" width="100%" height="100%" scrolling="no"/></div>


</body>
</html>
