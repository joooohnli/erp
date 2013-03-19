<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<style>
.resizeDivClass
{
position:relative;
background-color:#DEDBD6;
width:2;
z-index:1;
left:expression(this.parentElement.offsetWidth-1);
cursor:e-resize;

}
</style>

<script language=javascript>

function MouseDownToResize(obj){
obj.mouseDownX=event.clientX;
obj.pareneTdW=obj.parentElement.offsetWidth;
obj.pareneTableW=theObjTable.offsetWidth;
obj.setCapture();
}
function MouseMoveToResize(obj){
    if(!obj.mouseDownX) return false;
    var newWidth=obj.pareneTdW*1+event.clientX*1-obj.mouseDownX;
    if(newWidth>0)
    {
obj.parentElement.style.width = newWidth;
theObjTable.style.width=obj.pareneTableW*1+event.clientX*1-obj.mouseDownX;
}
}
function MouseUpToResize(obj){
obj.releaseCapture();
obj.mouseDownX=0;
}

</script>
<%String excel_tag="<html xmlns:x=&quot;urn:schemas-microsoft-com:office:excel&quot;&#13;&#10;xmlns=&quot;http://www.w3.org/TR/REC-html40&quot;>&#13;&#10;&#13;&#10;<head>&#13;&#10;<style type=&quot;text/css&quot;>&#13;&#10;<!--tr&#13;&#10;&#9;{mso-height-source:auto;}&#13;&#10;td&#13;&#10;&#9;{white-space:nowrap;}&#13;&#10;.wcC18A7E7&#13;&#10;&#9;{white-space:nowrap;&#13;&#10;&#9;font-family:宋体;&#13;&#10;&#9;mso-number-format:General;&#13;&#10;&#9;font-size:auto;&#13;&#10;&#9;font-weight:auto;&#13;&#10;&#9;font-style:auto;&#13;&#10;&#9;text-decoration:auto;&#13;&#10;&#9;mso-background-source:auto;&#13;&#10;&#9;mso-pattern:auto;&#13;&#10;&#9;mso-color-source:auto;&#13;&#10;&#9;text-align:general;&#13;&#10;&#9;vertical-align:bottom;&#13;&#10;&#9;border-top:none;&#13;&#10;&#9;border-left:none;&#13;&#10;&#9;border-right:none;&#13;&#10;&#9;border-bottom:none;&#13;&#10;&#9;mso-protection:locked;}&#13;&#10;-->&#13;&#10;</style>&#13;&#10;</head>&#13;&#10;&#13;&#10;<body>&#13;&#10;<!--[if gte mso 9]><xml>&#13;&#10; <x:ExcelWorkbook>&#13;&#10;  <x:ExcelWorksheets>&#13;&#10;   <x:ExcelWorksheet>&#13;&#10;    <x:OWCVersion>9.0.0.2710</x:OWCVersion>&#13;&#10;    <x:Label Style='border-top:solid .5pt silver;border-left:solid .5pt silver;&#13;&#10;     border-right:solid .5pt silver;border-bottom:solid .5pt silver'>&#13;&#10;     <x:Caption>Microsoft Office Spreadsheet</x:Caption>&#13;&#10;    </x:Label>&#13;&#10;    <x:Name>Sheet1</x:Name>&#13;&#10;    <x:WorksheetOptions>&#13;&#10;     <x:Selected/>&#13;&#10;     <x:Height>6615</x:Height>&#13;&#10;     <x:Width>13944</x:Width>&#13;&#10;     <x:TopRowVisible>0</x:TopRowVisible>&#13;&#10;     <x:LeftColumnVisible>0</x:LeftColumnVisible>&#13;&#10;     <x:ProtectContents>False</x:ProtectContents>&#13;&#10;     <x:DefaultRowHeight>210</x:DefaultRowHeight>&#13;&#10;   <x:StandardWidth>2389</x:StandardWidth>&#13;&#10;    </x:WorksheetOptions>&#13;&#10;   </x:ExcelWorksheet>&#13;&#10; </x:ExcelWorksheets>&#13;&#10;  <x:MaxHeight>80%</x:MaxHeight>&#13;&#10;  <x:MaxWidth>80%</x:MaxWidth>&#13;&#10; </x:ExcelWorkbook>&#13;&#10;</xml><![endif]-->&#13;&#10;&#13;&#10;<table class=wcC18A7E7 x:str>&#13;&#10;";

String excel_tag_last="<PARAM NAME=\"DataType\" VALUE=\"HTMLDATA\"><PARAM NAME=\"AutoFit\" VALUE=\"0\"><PARAM NAME=\"DisplayColHeaders\" VALUE=\"-1\"><PARAM NAME=\"DisplayGridlines\" VALUE=\"-1\"><PARAM NAME=\"DisplayHorizontalScrollBar\" VALUE=\"-1\"><PARAM NAME=\"DisplayRowHeaders\" VALUE=\"-1\"><PARAM NAME=\"DisplayTitleBar\" VALUE=\"0\"><PARAM NAME=\"DisplayToolbar\" VALUE=\"-1\"><PARAM NAME=\"DisplayVerticalScrollBar\" VALUE=\"-1\"><PARAM NAME=\"EnableAutoCalculate\" VALUE=\"-1\"><PARAM NAME=\"EnableEvents\" VALUE=\"-1\"><PARAM NAME=\"MoveAfterReturn\" VALUE=\"-1\"><PARAM NAME=\"MoveAfterReturnDirection\" VALUE=\"0\"><PARAM NAME=\"RightToLeft\" VALUE=\"0\"><PARAM NAME=\"ViewableRange\" VALUE=\"1:65536\"></OBJECT>";
%>
<STYLE>
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
	SCROLLBAR-HIGHLIGHT-COLOR: buttonface;
	SCROLLBAR-SHADOW-COLOR: buttonface;
	SCROLLBAR-3DLIGHT-COLOR: buttonhighlight;
	SCROLLBAR-TRACK-COLOR: #eeeeee;
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

TEXTAREA {
	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px; BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000; BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 9pt
}
SELECT {
	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px; BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000; BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 9pt
}
</STYLE>
<META content="Microsoft FrontPage 4.0" name=GENERATOR>

<STYLE>
.gray {
	CURSOR: hand; FILTER: gray
}
.style3 {
	font-size: 16px;
	font-weight: bold;
}


.ALL-STYLE{
	border: 1px ridge #666666;
	border-color:#DEDBD6;

}
.TR_STYLE1{

}

.style8 {color: #000066}



.TD_HANDBOOK_STYLE1 {
	vertical-align : top ;
	width:100%;
	color:#0000FF;
}

.TD_STYLE1{

}

.TD_STYLE2{
border-spacing: 1px;
}
.TD_STYLE3{

}
.SUBMIT_STYLE1{
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid

}
.BUTTON_STYLE1{
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid
}
.RESET_STYLE1{
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid
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
.FILE_STYLE1{
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid
}
.btn3_mouseout {
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid
}
.btn3_mouseover {
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid
}
.btn3_mousedown
{
 BORDER-RIGHT: #FFE400 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #FFE400 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #FFE400 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #FFE400 1px solid
}
.btn3_mouseup {
 BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid
}



</STYLE>
</head>



<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	 demo.setPath(request);
%>
 <%
 WebBase wb=new WebBase("ondemand1","nseer");
 ColumnMain cm=new ColumnMain();
 Table tb=new Table();
 String[] cols_main=cm.getColumn("ondemand1","nseer","ecommerce_colsa");
String[] cols_top=cm.getColumn("ondemand1","nseer","ecommerce_cols_top");
String[] cols_bottom=cm.getColumn("ondemand1","nseer","ecommerce_cols_bottom");
int circle=(cols_top.length+9)/10;
int rows=circle+1;
 %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%=wb.getTitle()%></title>
<style type="text/css">
<!--
body {
	margin-top: 0px;
}
.STYLE1 {
	font-family: "宋体";
	font-size: 12px;
	line-height: 16pt;
	}
.STYLE4{font-family: "宋体"; font-size: 12px; color: #000000; line-height: 16pt;}
.STYLE5 {font-family: "宋体"; font-size: 12px; }

-->
a:link {
	color: #333333;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #086994;
}
a:active {
	text-decoration: none;
}
</style>
</head>
<script>
function first(){
var left_text=document.getElementById("left_text");
left_text.style.position='absolute'
left_text.style.top=65;
left_text.style.left=(document.body.clientWidth-980)/2+90;
//left_text.style.width=document.body.clientWidth;
}
</script>
<div id="left_text"><table width="930" height="120"><tr><td align="left"><font size="5" color="#ffffff"><b><%=wb.getAdvertisement1()%></b></font></td></tr><tr><td align="right"><font size="5" color="#ffffff"><b><%=wb.getAdvertisement2()%></b></td></tr></table></div>
<body onload="first()">
<table width="930" height="60" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#ebf3fb">
</tr>
    <td width="180" rowspan="<%=rows%>"><img src="../../ecommerce/file_attachments/<%=wb.getAttachment1()%>" width="180" height="46" /></td>
	</tr>
	<tr>
    <td height="22" align="right">
	<table>
    <tr><td height="6">
	&nbsp;&nbsp;&nbsp;</td></tr>
	<tr>
	<td>
	<table width="745" border="0" cellpadding="0" cellspacing="0" bgcolor="#ebf3fb">
<%
int m=0;
for(int i=0;i<circle;i++){
%>

          <tr>
          
<%
	for(int j=0;j<12;j++){
		if(m<cols_top.length){
String[] record1=tb.getTable("ondemand1","nseer",cols_top[m]);
if(record1[3].equals("common")||record1[3].equals("other")){
%>
            <td width="90" class="STYLE1" align="right"><font size="2" color="#00499A"><a href="../<%=record1[3]%>/index.jsp?column=<%=toUtf8String.utf8String(exchange.toURL(cols_top[m]))%>"><%=exchange.toHtml(cols_top[m])%></a></font></td>
<%}else if(record1[3].equals("../home/login.jsp")){%>
			<td width="90" class="STYLE1" align="right"><font size="2" color="#00499A"><a href="../<%=record1[3]%>"><%=exchange.toHtml(cols_top[m])%></a></font></td>
<%}else{%>
			<td width="90" class="STYLE1" align="right"><font size="2" color="#00499A"><a href="../<%=record1[3]%>/index.jsp"><%=exchange.toHtml(cols_top[m])%></a></font></td>
<%}
}else{%>
            <td width="90" class="STYLE1">&nbsp;</td>
<%}
m++;
}%>
		  </tr>
<%}%>
        </table></td></tr></table>
		</td>
		</tr>
</table>
<table width="930" height="100" border="0" align="center" bgcolor="#ebf3fb">
  <tr>
    <td width="930" ><img src="../../ecommerce/file_attachments/<%=wb.getAttachment2()%>" width="930" height="160"/></td>
  </tr>
</table>