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
<%@ taglib uri="http://www.nseer.com/tag" prefix="app" %>
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
.TABLE_STYLE1{
	border: 1px solid;
	width: 100%;
}
.TABLE_STYLE2{
	width: 100%;
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
	color:#1A98F1;
}

.TD_STYLE1{

}

.TD_STYLE2{

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
background-color:#CCFFFF;
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
<Script Language=javascript>
function KeyDown(){
if ((window.event.altKey)&&
((window.event.keyCode==37)||(window.event.keyCode==39))){
alert("请不要使用ALT+方向键前进或后退网页！");
event.returnValue=false;
}

if ((event.keyCode==116)||(event.ctrlKey&&event.keyCode==82)){
event.keyCode=0;
event.returnValue=false;
}
if ((event.ctrlKey)&&(event.keyCode==78))
event.returnValue=false;
if ((event.shiftKey)&&(event.keyCode==121))
event.returnValue=false;
if (window.event.srcElement.tagName == "A" && window.event.shiftKey)
window.event.returnValue = false;
if ((window.event.altKey)&&(window.event.keyCode==115)){
window.showModelessDialog("about:blank","","dialogWidth:1px;dialogheight:1px");
return false;}
}
</script>
<body bgcolor="#EFEFEF" oncontextmenu="event.returnValue=true">

<%
String TABLE_STYLE1="bordercolor=#000000 bordercolorlight=#848284 bordercolordark=#eeeeee border=1 cellspacing=0 cellpadding=0";
String TABLE_STYLE2="";
String TR_STYLE1="";
String TD_STYLE1="bgcolor=#DEDBD6 bordercolorlight=#848284 bordercolordark=#eeeeee";
String TD_STYLE2="valign=top bgcolor=#FFFFFF bordercolor=#DEDBD6";
String TD_STYLE3="";
String INPUT_STYLE1="";
String SUBMIT_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String BUTTON_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RESET_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String FILE_STYLE1="onmouseover=this.className='btn3_mouseover' onmouseout=this.className='btn3_mouseout' onmousedown=this.className='btn3_mousedown' onmouseup=this.className='btn3_mouseup'";
String RADIO_STYLE1="";
String CHECKBOX_STYLE1="";
String SELECT_STYLE1="";
String TEXTAREA_STYLE1="rows=4";
String DIV_STYLE1="";
String DIV_STYLE2="";
String TD_HANDBOOK_STYLE1="";
%>