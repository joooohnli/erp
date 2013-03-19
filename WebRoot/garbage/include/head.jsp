<%@page contentType="text/html; charset=UTF-8"%>
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
<head>
<%@ taglib uri="http://www.nseer.com/tag" prefix="app" %>
<app:checkLogon database="garbage"/>
<style>
.nseerGround{
	position:absolute;
	left:1%;
	height:100%;
	width:98%;
	<%if(strhead.indexOf(browercheck.IE)!=-1){%>z-index:-1;<%}%>
}
.div_handbook{
	position:absolute;
	left:1%;
	width:98%
}
form{
	margin:0;
}
.resizeDivClass
{
position:relative;
background-color:#DEDBD6;
width:2;
z-index:1;
left:expression(this.parentElement.offsetWidth-1);
cursor:e-resize;
}
A:visited {
	TEXT-DECORATION: none
}
A:active {
	TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: underline overline
}
A:link {
	TEXT-DECORATION: none
}
.t {
	LINE-HEIGHT: 1.4
}
BODY {
	FONT-FAMILY: 宋体;
	FONT-SIZE: 9pt;
	scrollbar-face-color :#F1F1F1;
	SCROLLBAR-HIGHLIGHT-COLOR: #F1F1F1;
	SCROLLBAR-SHADOW-COLOR: buttonface;
	SCROLLBAR-3DLIGHT-COLOR: buttonhighlight;
	SCROLLBAR-TRACK-COLOR: #868686
	SCROLLBAR-DARKSHADOW-COLOR: buttonshadow;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
TD {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
DIV {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
FORM {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
OPTION {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
P {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
TD {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
BR {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
.gray {
	CURSOR: hand; FILTER: gray
}
.style3 {
	font-size: 16px;
	font-weight: bold;
}
.TABLE_STYLE11{
	border: 1px solid;
	border-collapse: collapse;
	width: 95%;
	
}
.TABLE_STYLE1{
	border: 1px solid;
	border-collapse: collapse;
	width: 100%;
	
}
.TABLE_STYLE2{
	width: 100%;
	
}
.TABLE_STYLE3{
	width: 98%;
	
}
.TABLE_STYLE4{
	width: 95%;
	
}
.TABLE_STYLE5{
	border: 1px solid;
	border-collapse: collapse;
	width: 95%;
	
}
.TABLE_STYLE6{
	width: 820;	
}
.TABLE_STYLE7{
	border: 1px solid;
	border-collapse: collapse;
	width: 100%;	
}
.ALL-STYLE{
	border: 1px ridge #666666;
	border-color:#DEDBD6;

}
.TR_STYLE1{

}
.TR_STYLE2{

}
.style8 {color: #000066}

.TD_HANDBOOK_STYLE1 {
	vertical-align : top ;
	width:100%;
	color:#0000FF;
}

.TD_STYLE1{
  background-image:url(/erp/images/bg.gif);
}

.TD_STYLE2{
border-spacing: 1px;
}
.TD_STYLE3{

}
.TD_STYLE4{

}
.TD_STYLE5{

}
.TD_STYLE6{

}
.TD_STYLE7{
  background-image:url(/erp/images/line4.gif);
}
.TD_STYLE8{

}
.SUBMIT_STYLE1{
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid

}
.BUTTON_STYLE1{
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.RESET_STYLE1{
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.RADIO_STYLE1{

}
.CHECKBOX_STYLE1{

}
.SELECT_STYLE1{
width:100%;
}
.SELECT_STYLE2{
width:100%;
}
.TEXTAREA_STYLE1{
width:100%;
}
.DIV_STYLE1{

float :right ;
vertical-align : top ;

}
.DIV_STYLE2{

float :center ;
vertical-align : top ;

}
.INPUT_STYLE1{
width:100%
}
.INPUT_STYLE3{
BORDER-BOTTOM:  1px solid #000000;
BORDER-left:  0px ;
BORDER-right:  0px ;
BORDER-top:  0px ;
width:100%
}
.INPUT_STYLE4{
BORDER-BOTTOM:  0px;
BORDER-left:  0px ;
BORDER-right:  0px ;
BORDER-top:  0px ;
width:100%
}
.INPUT_STYLE5{
background-color:#FFFFCC;
BORDER-BOTTOM:  0px;
BORDER-left:  0px ;
BORDER-right:  0px ;
BORDER-top:  0px ;
width:100%
}
.FILE_STYLE1{
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.btn3_mouseout {
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.btn3_mouseover {
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.btn3_mousedown
{
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
.btn3_mouseup {
 BORDER-RIGHT: #7EBF4F 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #7EBF4F 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#CAE4B6); BORDER-LEFT: #7EBF4F 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #7EBF4F 1px solid
}
</STYLE>
</head>
<%
{
String url_temp="";
String file_url=request.getRequestURI();
for(int i=0;i<file_url.split("/").length-3;i++){
	url_temp+="../";
}
%>
<script type='text/javascript' src='<%=url_temp%>javascript/include/covers/cover.js'></script>
<script language="javascript">
if (window.attachEvent)window.attachEvent("onload",function(){document.all('LoadProcess_head').style.visibility ="hidden";document.all('mengban_head').style.visibility = "hidden";document.all('ifra_head').style.visibility = "hidden";});
if (window.addEventListener)window.addEventListener("load",function(){document.all('LoadProcess_head').style.visibility = "hidden";document.all('mengban_head').style.visibility = "hidden";document.all('ifra_head').style.visibility = "hidden";},false)
</script>
<style>
.mengban_head{ 
position:absolute;
height:100%;
z-index:10;
top:0;
left:0;
background-color:#CECECE;
width:100%;
visibility: visible;
filter:alpha(opacity=10);
}
</style>
<iframe id="ifra_head" style="filter:alpha(opacity=0);position:absolute;width:expression(this.nextSibling.offsetWidth);height:expression(this.nextSibling.offsetHeight);top:expression(this.nextSibling.offsetTop);left:expression(this.nextSibling.offsetLeft);" frameborder="0" ></iframe>
<div class="mengban_head" id="mengban_head"></div>
<div  id="LoadProcess_head" style="position:absolute; left:40%; top:111px; width:280px; height:50px; z-index:1;z-index:11;"> 
  <div align=center style="color:#000000;border:1px solid #ffffff;height:50px;padding:5px 0px 0px 0px" id="id2"><img src="<%=url_temp%>images/include/indicator_medium.gif">请稍候......</div>
</div>
<script>setGradient('id2','#BFBBF4','#ffffff',1);</script>

<%
}
%>
<body bgcolor="#E9F8F3" oncontextmenu="event.returnValue=true" style="background-image:url(/erp/images/lili.gif)">

<%
String TABLE_STYLE11="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#ffffff border=1 cellspacing=0 cellpadding=0 align=center";
String TABLE_STYLE1="bordercolor=#25CB0E bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 bgcolor=#EEEEEE align=center";
String TABLE_STYLE2="";
String TABLE_STYLE3="";
String TABLE_STYLE4="align=center";
String TABLE_STYLE5="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#eeeeee border=1 cellspacing=0 cellpadding=0 align=center";
String TABLE_STYLE6="align=center";
String TABLE_STYLE7="bordercolor=#25CB0E  bordercolorlight=#000000 bordercolordark=#000000 border=0 cellspacing=1 cellpadding=1 bgcolor=#E3E3E3 align=center";//书签
String TR_STYLE1="height=20";
String TR_STYLE2="height=20 bgcolor=#D2E9FF";
String TD_STYLE1="bordercolorlight=#848284 bordercolordark=#ffffff align=right";
String TD_STYLE2="bordercolor=#DEDBD6 align=left";
String TD_STYLE11="bgcolor=#D2E9FF bordercolorlight=#000000 bordercolordark=#000000 align=left height=20";
String TD_STYLE21="valign=top bgcolor=#ffffff bordercolor=#000000";
String TD_STYLE3="";
String TD_STYLE4="bgcolor=#D2E9FF bordercolorlight=#000000 bordercolordark=#000000 align=right";//档案类
String TD_STYLE5="align=center height=5";
String TD_STYLE6="bordercolor=#DEDBD6 align=right";
String TD_STYLE7="";
String TD_STYLE8="";
String INPUT_STYLE1="";
String INPUT_STYLE3="";
String INPUT_STYLE4="";
String INPUT_STYLE5="";
String SUBMIT_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String BUTTON_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RESET_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String FILE_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RADIO_STYLE1="";
String CHECKBOX_STYLE1="";
String SELECT_STYLE1="";
String SELECT_STYLE2="size=1";
String TEXTAREA_STYLE1="rows=4";
String DIV_STYLE1="";
String DIV_STYLE2="";
String TD_HANDBOOK_STYLE1="";
String table_width="100%";
%>
<%@include file="../../include/head_msg.jsp"%>
