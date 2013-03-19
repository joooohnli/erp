<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *这个文件是恩信科技ERP软件的组成部分。
 *版权所有（C）2006-2010 北京恩信创业科技有限公司/http://www.nseer.com
 *
 *这一程序是自由软件，你可以遵照自由软件基金会出版的GNU通用公共许可
 *证条款来修改和重新发布这一程序。或者用许可证的第二版，或者（根据你的选
 *择）用任何更新的版本。
 *
 *发布这一程序的目的是希望它有用，但没有任何担保。甚至没有适合特定目
 *的的隐含的担保。更详细的情况请参阅GNU通用公共许可证。
 *你应该已经和程序一起收到一份GNU通用公共许可证的副本。如果还没有，
 *写信给：
 *The Free Software Foundation, Inc., 675 Mass Ave, Cambridge,
 *MA02139, USA
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*,include.nseer_db.*" import="java.util.*" import="java.io.*" import="java.text.*"%>
<%@include file="head.jsp"%>
<HTML>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="lang" class="include.nseer_cookie.Lang" scope="page"/>
<%
Cookie cookies[]=request.getCookies();
String username="";
if(cookies!=null){
username=cookies[0].getValue();
if(username.length()==32) username="";
}
%>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 String unit_tag=request.getParameter("unit_tag");
	 if(unit_tag==null) unit_tag="0";
	 session.setAttribute("language",language);
%>
<HEAD>

<link href="../style/css/bs.css" rel="stylesheet" type="text/css">
<img align="absmiddle" alt="" src="../images/empty.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/Lplus.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/close.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/L.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/Tminus.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/Lminus.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/I.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/P.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/Tplus.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/T.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/jsdoc.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/open.gif" border="0" style="display:none;"/>

<img align="absmiddle" alt="" src="../images/bg_0ltop.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_0rtop.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_01.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_03.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_0rtop.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_03.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/gb.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_04.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_0lbottom.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_02.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/bg_0rbottom.gif" border="0" style="display:none;"/>

<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer30.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer16.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer12.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer13.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer32.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer33.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer26.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer31.gif" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer20.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer16.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer25.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer18.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer24.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer5.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer15.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer17.png" border="0" style="display:none;"/>
<img align="absmiddle" alt="" src="../images/erpPlatform/design/nseer21.png" border="0" style="display:none;"/>


<TITLE> <%=demo.getLang("erp","欢迎使用恩信科技开源ERP")%> </TITLE>
<Script Language=javascript>
function KeyDown(){
if ((window.event.altKey)&&((window.event.keyCode==37)||(window.event.keyCode==39))){
alert("请不要使用ALT+方向键前进或后退网页！");
event.returnValue=false;
}

if (event.keyCode==116||(event.ctrlKey&&event.keyCode==82)){
event.keyCode=0;
event.returnValue=false;
}
if ((event.ctrlKey)&&(event.keyCode==78)) event.returnValue=false;
if ((event.shiftKey)&&(event.keyCode==121)) event.returnValue=false;
if (window.event.srcElement.tagName == "A"&&window.event.shiftKey)
window.event.returnValue = false;
if ((window.event.altKey)&&(window.event.keyCode==115)){
window.showModelessDialog("about:blank","","dialogWidth:1px;dialogheight:1px");
return false;}
}
</script>
<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.a {
background: #2b8ec9;
width:100%;
height: 8%;
color: #ffffff; 
font-size: 13px;
background-image: url(images/jk.gif);
FILTER: progid:DXImageTransform.Microsoft.Gradient(startColorStr='#59A7D7', endColorStr='#E4F1F7', gradientType='0');
  
}

.b {
background: #FFFFFF;
width:100%;
height: 84%;}

.c {
background: #2b8ec9;
width:100%;
height: 8%;
color: #ffffff;
font-size: 13px;
FILTER: progid:DXImageTransform.Microsoft.Gradient(startColorStr='#E4F1F7', endColorStr='#59A7D7', gradientType='0'); 
}
.btn1_mouseout {
BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#B3D997); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.btn1_mouseover {
BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.STYLE1 {
	font-size: 13px;
	font-family: "宋体";
	color: #FFFFFF;
}
.STYLE2 {
	font-size: 13px;
	font-family: "宋体";
	color: #000000;
}
.STYLE3 {
	font-size: 13px;
	font-family: "宋体";
	color: #FFFFFF;
	line-height: 16pt;

}
.STYLE4 {
	font-size: 13px;
	font-family: "宋体";
	color: #244ac6;
	line-height: 16pt;
}
.STYLE5 {
	font-size: 13px;
	font-family: "宋体";
	color: #000000;
	line-height: 16pt;
}
</style>
</head>

<BODY>

<script>
/*#############################################################
Name: Niceforms
Version: 1.0
Author: Lucian Slatineanu
URL: http://www.badboy.ro/

Feel free to use and modify but please provide credits.
#############################################################*/

//Global Variables
var niceforms = document.getElementsByTagName('form'); 
var inputs = new Array();
var labels = new Array(); 
var radios = new Array(); 
var radioLabels = new Array();
var checkboxes = new Array(); 
var checkboxLabels = new Array();
var texts = new Array();
var textareas = new Array();
var selects = new Array();
var selectText = "please select";
var agt = navigator.userAgent.toLowerCase(); 
this.ie = ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1)); 
var hovers = new Array();
var buttons = new Array(); 
var isMac = new RegExp('(^|)'+'Apple'+'(|$)');

//Theme Variables - edit these to match your theme

var imagesPath = "images/";

//Initialization function - if you have any other 'onload' functions, add them here
function init() {
	if(!document.getElementById) {return false;}
	preloadImages();
	getElements();
	separateElements();
	
	
	if(!isMac.test(navigator.vendor)) {
		replaceTexts();
		replaceTextareas();
		buttonHovers();
	}
}
//preloading required images
function preloadImages() {
	preloads = new Object();
	preloads[0] = new Image(); preloads[0].src = imagesPath + "button_left_xon.gif";
	preloads[1] = new Image(); preloads[1].src = imagesPath + "button_right_xon.gif";
	preloads[2] = new Image(); preloads[2].src = imagesPath + "input_left_xon.gif";
	preloads[3] = new Image(); preloads[3].src = imagesPath + "input_right_xon.gif";
	preloads[4] = new Image(); preloads[4].src = imagesPath + "txtarea_bl_xon.gif";
	preloads[5] = new Image(); preloads[5].src = imagesPath + "txtarea_br_xon.gif";
	preloads[6] = new Image(); preloads[6].src = imagesPath + "txtarea_cntr_xon.gif";
	preloads[7] = new Image(); preloads[7].src = imagesPath + "txtarea_l_xon.gif";
	preloads[8] = new Image(); preloads[8].src = imagesPath + "txtarea_tl_xon.gif";
	preloads[9] = new Image(); preloads[9].src = imagesPath + "txtarea_tr_xon.gif";
}
//getting all the required elements
function getElements() {
	var re = new RegExp('(^| )'+'niceform'+'( |$)');
	for (var nf = 0; nf < document.getElementsByTagName('form').length; nf++) {
		if(re.test(niceforms[nf].className)) {
			for(var nfi = 0; nfi < document.forms[nf].getElementsByTagName('input').length; nfi++) {inputs.push(document.forms[nf].getElementsByTagName('input')[nfi]);}
		 if (window.ActiveXObject)
			{
for(var nft = 0; nft < document.forms[nf].getElementsByTagName('textarea').length; nft++) {textareas.push(document.forms[nf].getElementsByTagName('textarea')[nft]);}		
		}
		}
	}
}
//separating all the elements in their respective arrays
function separateElements() {
	var r = 0; var c = 0; var t = 0; var rl = 0; var cl = 0; var tl = 0; var b = 0;
	for (var q = 0; q < inputs.length; q++) {
		//if((inputs[q].type == "text") || (inputs[q].type == "password")) {texts[t] = inputs[q]; ++t;}
		if((inputs[q].type == "submit") || (inputs[q].type == "button")|| (inputs[q].type == "reset")) {buttons[b] = inputs[q]; ++b;}
	}
}
function replaceTexts() {
	for(var q = 0; q < texts.length; q++) {
		texts[q].style.width = texts[q].size * 10 + 'px';
		txtLeft = document.createElement('img'); txtLeft.src = imagesPath + "input_left.gif"; txtLeft.className = "inputCorner";
		txtRight = document.createElement('img'); txtRight.src = imagesPath + "input_right.gif"; txtRight.className = "inputCorner";
		texts[q].parentNode.insertBefore(txtLeft, texts[q]);
		texts[q].parentNode.insertBefore(txtRight, texts[q].nextSibling);
		texts[q].className = "textinput";
		//create hovers
		texts[q].onfocus = function() {
			this.className = "textinputHovered";
			this.previousSibling.src = imagesPath + "input_left_xon.gif";
			this.nextSibling.src = imagesPath + "input_right_xon.gif";
		}
		texts[q].onblur = function() {
			this.className = "textinput";
			this.previousSibling.src = imagesPath + "input_left.gif";
			this.nextSibling.src = imagesPath + "input_right.gif";
		}
	}
}
function replaceTextareas() {
	for(var q = 0; q < textareas.length; q++) {
		var where = textareas[q].parentNode;
		var where2 = textareas[q].previousSibling;
		textareas[q].style.width = textareas[q].cols * 10 + 'px';
		textareas[q].style.height = textareas[q].rows * 10 + 'px';
		//create divs
		var container = document.createElement('div');
		container.className = "txtarea";
		container.style.width = textareas[q].cols * 10 + 20 + 'px';
		container.style.height = textareas[q].rows * 10 + 20 + 'px';
		var topRight = document.createElement('div');
		topRight.className = "tr";
		var topLeft = document.createElement('img');
		topLeft.className = "txt_corner";
		topLeft.src = imagesPath + "txtarea_tl.gif";
		var centerRight = document.createElement('div');
		centerRight.className = "cntr";
		var centerLeft = document.createElement('div');
		centerLeft.className = "cntr_l";
		if(!this.ie) {centerLeft.style.height = textareas[q].rows * 10 + 10 + 'px';}
		else {centerLeft.style.height = textareas[q].rows * 10 + 12 + 'px';}
		var bottomRight = document.createElement('div');
		bottomRight.className = "br";
		var bottomLeft = document.createElement('img');
		bottomLeft.className = "txt_corner";
		bottomLeft.src = imagesPath + "txtarea_bl.gif";
		//assemble divs
		container.appendChild(topRight);
		topRight.appendChild(topLeft);
		container.appendChild(centerRight);
		centerRight.appendChild(centerLeft);
		centerRight.appendChild(textareas[q]);
		container.appendChild(bottomRight);
		bottomRight.appendChild(bottomLeft);
		//insert structure
		where.insertBefore(container, where2);
		//create hovers
		textareas[q].onfocus = function() {
			this.previousSibling.className = "cntr_l_xon";
			this.parentNode.className = "cntr_xon";
			this.parentNode.previousSibling.className = "tr_xon";
			this.parentNode.previousSibling.getElementsByTagName("img")[0].src = imagesPath + "txtarea_tl_xon.gif";
			this.parentNode.nextSibling.className = "br_xon";
			this.parentNode.nextSibling.getElementsByTagName("img")[0].src = imagesPath + "txtarea_bl_xon.gif";
		}
		textareas[q].onblur = function() {
			this.previousSibling.className = "cntr_l";
			this.parentNode.className = "cntr";
			this.parentNode.previousSibling.className = "tr";
			this.parentNode.previousSibling.getElementsByTagName("img")[0].src = imagesPath + "txtarea_tl.gif";
			this.parentNode.nextSibling.className = "br";
			this.parentNode.nextSibling.getElementsByTagName("img")[0].src = imagesPath + "txtarea_bl.gif";
		}
	}
}
function buttonHovers() {
	for (var i = 0; i < buttons.length; i++) {
		buttons[i].className = "buttonSubmit";
		var buttonLeft = document.createElement('img');
		buttonLeft.src = imagesPath + "button_left.gif";
		buttonLeft.className = "buttonImg";
		buttons[i].parentNode.insertBefore(buttonLeft, buttons[i]);
		var buttonRight = document.createElement('img');
		buttonRight.src = imagesPath + "button_right.gif";
		buttonRight.className = "buttonImg";
		if(buttons[i].nextSibling) {buttons[i].parentNode.insertBefore(buttonRight, buttons[i].nextSibling);}
		else {buttons[i].parentNode.appendChild(buttonRight);}
		buttons[i].onmouseover = function() {
			this.className += "Hovered";
			this.previousSibling.src = imagesPath + "button_left_xon.gif";
			this.nextSibling.src = imagesPath + "button_right_xon.gif";
		}
		buttons[i].onmouseout = function() {
			this.className = this.className.replace(/Hovered/g, "");
			this.previousSibling.src = imagesPath + "button_left.gif";
			this.nextSibling.src = imagesPath + "button_right.gif";
		}
	}
}
//Useful functions
function findPosY(obj) {
	var posTop = 0;
	while (obj.offsetParent) {posTop += obj.offsetTop; obj = obj.offsetParent;}
	return posTop;
}
function findPosX(obj) {
	var posLeft = 0;
	while (obj.offsetParent) {posLeft += obj.offsetLeft; obj = obj.offsetParent;}
	return posLeft;
}

//window.onload = init;
</script>
<style type="text/css" media="screen">@import url(niceforms-default.css);</style>

<script language="javascript" src="../javascript/input_control/Check.js"></script>
<script language="javascript">
function CheckForm(TheForm) {
	if (TheForm.username.value == "") {
		alert("<%=demo.getLang("erp","请填写您的用户名！")%>");
		TheForm.username.focus();
		return false;
	}
    if (TheForm.passwd.value == "") {
		alert("<%=demo.getLang("erp","请填写您的密码！")%>");
		TheForm.passwd.focus();
		return false;
	}
	return true;
}
</script>
<script language="javascript">
function send(option){
	var a=option.options[option.selectedIndex].value;
	location.href=a;
}
</script>
<%
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
String[] languages=lang.getLangs("ondemand1");
%>

<div class="a" valign=" bottom"  align="right"> 



<table width="100%" height="100%" class="STYLE1"  border="0" align="center">
<tr >

<td width="50%" valign="bottom" class="STYLE5"  align="right" ></br>&nbsp;&nbsp;

</td>
</tr>
</table>
</div>
<script>
function login(){
	var login=document.getElementById("login");
	
	login.style.display=login.style.display=='block'?'none':'block';
 var log=document.getElementById("log");
	
	log.style.display=login.style.display=='block'?'none':'block';
 
}
</script>
<script type="text/javascript">
function save(title, url){
if (document.all)
window.external.AddFavorite(url, title);
else if (window.sidebar)
window.sidebar.addPanel(title, url, "")
}
</script>
<script type="text/javascript">
function setHomePage()
{
  if(window.netscape)
  {
        try { 
          netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
        } 
        catch (e) 
        { 
          alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将[signed.applets.codebase_principal_support]设置为'true'"); 
        }
  

  var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
  prefs.setCharPref('browser.startup.homepage',window.location.href);
  }else{
  this.homepage.style.behavior='url(#default#homepage)';this.homepage.sethomepage(window.location.href);
  }

}
</script>

<div class="b" > 

<table width="100%" height="100%" class="STYLE1"  border="0" align="center" class="STYLE2">

<tr>
<td width="48%" valign="center">
<div align="right" class="STYLE2" ><a href="http://www.nseer.com" target="_blank">
<img src="../images/LOGIN.gif" width="205" height="47" border="0" /></a><br><br>
<%=demo.getLang("erp","恩信科技开源ERPv7.10")%>&nbsp;<br><br>
<%=demo.getLang("erp","北京恩信创业科技有限公司")%>&nbsp;<%=demo.getLang("erp","版权所有")%></font>&nbsp;<br><br>
</div>
</td>

</td>
<td width="2%" height="100%">
<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
        
        <tr>
          <td align="center" width="100%" height="100%"><img src="../images/lif.gif" width="5%" height="100%" /></td>
        </tr>
        
      </table>
</td>
<td width="48%">
<div id="login" >
<form name="TheForm" method="post" action="../work" onSubmit="return CheckForm(this)">
<input type="hidden" name="ui" value="1">
<table border="0" class="STYLE2">
<%
nseer_db db=new nseer_db("mysql");
String sql="select * from unit_info where active_tag='1'";
ResultSet rs=db.executeQuery(sql);
if(rs.next()){
	if(unit_tag.equals("0")){
%>
<tr>
<td height="25"><font color="#000000"><%=demo.getLang("erp","单&nbsp;&nbsp;位")%>:&nbsp;</td><td><%=rs.getString("unit_name")%></td>
</tr>
<%}else{%>
<tr>
<td height="25"><font color="#000000"><%=demo.getLang("erp","单&nbsp;&nbsp;位")%>:&nbsp;</td><td><input type="text"  name="unit_name" id="unit_name" style="width:120" value="<%=rs.getString("unit_name")%>"></td>
</tr>
<%}}else{%>
<tr>
<td height="25"><font color="#000000"><%=demo.getLang("erp","单&nbsp;&nbsp;位")%>:&nbsp;</td><td><input type="text"  name="unit_name" id="unit_name" style="width:120" value="恩信科技开源ERP用户"></td>
</tr>
<%}%>
<input name="language" type="hidden" value="">
<tr>
<td><font color="#000000"><b><%=demo.getLang("erp","用户名")%>:&nbsp;</td></b><td><input type="text"  name="username" id="username" style="width:120" value="<%=username%>"><br></font></td>

<td><input type="checkbox" name="remember" value="1"/><%=demo.getLang("erp","记住用户名")%></td></tr>
<tr>
<td><font color="#000000"><b><%=demo.getLang("erp","密码")%>:&nbsp;&nbsp;</b></td><td><input type="password" name="passwd" id="passwd" value="" style="width:120"><br></font></td></tr>
<tr>
<td >&nbsp;</td></tr>
<tr>
<tr><td colspan="2">

<input type="submit" class=btn1_mouseout onmouseover="this.className='btn1_mouseover'"
onmouseout="this.className='btn1_mouseout'" value="<%=demo.getLang("erp","登录")%>">&nbsp;&nbsp;<input type="button" class=btn1_mouseout onmouseover="this.className='btn1_mouseover'"
onmouseout="this.className='btn1_mouseout'" value="<%=demo.getLang("erp","注册")%>" onClick=location="user_enrollment.jsp?language=<%=language%>">&nbsp;&nbsp;<input type="button" class=btn1_mouseout onmouseover="this.className='btn1_mouseover'"
onmouseout="this.className='btn1_mouseout'"  value="<%=demo.getLang("erp","修改密码")%>" onClick=location="change_passwd.jsp?language=<%=language%>"><br></td></tr>
<tr>
<td colspan="3">&nbsp;</td></tr>
<tr>
<td colspan="3"><p><a href="#" name="homepage" target="_search" onclick="setHomePage()"><font color="#000000"><%=demo.getLang("erp","设为首页")%></a>&nbsp;|&nbsp;<a href="javascript:save('恩信科技','http://www.nseer.com')"><font color="#000000"><%=demo.getLang("erp","加入收藏夹")%></a>&nbsp;|&nbsp;<a href="reset_passwd.jsp?language=<%=language%>"><font color="#000000"><%=demo.getLang("erp","忘记密码")%></a>&nbsp;|&nbsp;<a href="login.jsp?language=<%=language%>&unit_tag=1"><font color="#000000"><%=demo.getLang("erp","修改单位")%></a></td></font></p></tr></table>
</div>
</td>
</td>
</tr>
</table>
</form>
</div>

<div class="c"  >   
<table width="100%" height="100%" class="STYLE5"  border="0" align="center">
<tr >

<td width="95%" valign="center" class="STYLE5"><font color="#000000">&nbsp;&nbsp;
<%=demo.getLang("erp","本系统建议使用IE6.0以上版本，最佳分辨率为 1280*1024")%></font>
</font>

</td>

</tr>
</table>
</div>
<input type="hidden" id="show-dialog-btn" >
</BODY>
</HTML>
<IFRAME frameBorder=0 height=0 marginHeight=0 marginWidth=0 name=window
   src="refresh.jsp"
   width=420 height=40></IFRAME>
   <div id="nseer_ad" style="position:absolute;bottom:10px;right:10px;width:400px;height:150px;"><TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0"><TBODY><TR><TD width="1%" height="1%"><IMG  src="../images/bg_0ltop.gif"></TD><TD width="100%" background="../images/bg_01.gif"></TD><TD width="1%" height="1%"><IMG  src="../images/bg_0rtop.gif"></TD></TR><TR><TD  background="../images/bg_03.gif"></TD><TD><div style="position:absolute;top:10px;width:380px;height:130px;background:#F0F3F5;"><div style="height:50px;text-align:left;color:#0000FF;line-height:150%;padding-top:7px;padding-left:10px;padding-right:10px;">您知道吗？<br />&nbsp;&nbsp;&nbsp;&nbsp;恩信科技开源ERP是可以免费使用，源代码开放的软件产品，任何个人或者公司均不能向您销售或变相销售该产品收取费用。为了保护您的合法权益，建议您只接受通过恩信科技认证授权的公司所提供的有偿支持与服务，并要求其出示相关认证和授权证明，必要时请向恩信科技查询核实。</div></div><span style="position:absolute;top:2px;right:7px;width:18px;height:18px;cursor:hand;" onclick="document.getElementById('nseer_ad').style.display='none';"><img src="../images/gb.gif" border="0" width=17px;height=17px></span></div></div> </TD><TD  background="../images/bg_04.gif"></TD></TR><TR><TD width="1%" height="1%"><IMG  src="../images/bg_0lbottom.gif" ></TD><TD background="../images/bg_02.gif"></TD><TD width="1%" height="1%"><IMG  src="../images/bg_0rbottom.gif"></TD> </TR></TBODY></TABLE></div>