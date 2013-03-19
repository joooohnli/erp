<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%demo.setPath(request);%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="../../javascript/media/mt_style.css" type="text/css">
<style type="text/css">
<!--
body {

	background-color: #FFFFFF;
}
a:link {
	
}
a:visited {
	
}
a:hover {
	color: #0066CC;
}
a:active {
	
}
body,td,th {
	font-size: 12px;
	
}
.style2 {color: #000000}
-->
</style></head>
<script language="JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
 window.open(theURL,winName,features);
}
//-->
</script>
<!-- 
window.defaultStatus="3D APPLE网络资源站 HTTP://WWW.3DAPPLE.COM"; 
//--> 
</SCRIPT>
<SCRIPT language=javascript src="../../javascript/media/mt_dropdownC.js"></SCRIPT>
<SCRIPT language=javascript src="../../javascript/media/mt_dropdown_initialize.js"></SCRIPT>



<body onload="init();">



<%
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
String mod=request.getRequestURI();
session.setAttribute("mod",mod);
mod=mod.substring(5);
int location=mod.indexOf("/");
mod=mod.substring(0,location);
String sqlurl="";
String url=request.getParameter("url");
String main_kind_name="";
String first_kind_name="";
String second_kind_name="";
String function="";
String topic="";
String pppp="";

if(url==null) {
	sqlurl="select * from document_main where reason='"+mod+"'";
	ResultSet rsurl=db.executeQuery(sqlurl);
rsurl.next();
function=rsurl.getString("function");
topic=rsurl.getString("value");
pppp="";
}else
{

StringTokenizer tokenTO = new StringTokenizer(url,"/");
int tokencount=tokenTO.countTokens();
switch(tokencount){
case 2:
			while (tokenTO.hasMoreTokens()) {
				main_kind_name = tokenTO.nextToken();
				first_kind_name = tokenTO.nextToken();
			}
			sqlurl="select * from document_first where main_kind_name='"+main_kind_name+"' and first_kind_name='"+first_kind_name+"'";
			break;
case 3:
			while (tokenTO.hasMoreTokens()) {
				main_kind_name = tokenTO.nextToken();
				first_kind_name = tokenTO.nextToken();
				second_kind_name = tokenTO.nextToken();
			}
			sqlurl="select * from document_second where main_kind_name='"+main_kind_name+"' and first_kind_name='"+first_kind_name+"' and second_kind_name='"+second_kind_name+"'";
			break;

}
ResultSet rsurl=db.executeQuery(sqlurl);
rsurl.next();
topic=rsurl.getString("first_kind_id");
pppp=topic;

function=rsurl.getString("function");
}




String user_ID=(String)session.getAttribute("human_IDD");



String group_name=mod+"Tree";


String mod1=mod+"_allright";
String mod2=mod+"_tree";
int group_length=0;
int i=0;
String sqlb="select count(distinct main) from "+mod2+" order by tree_id";
ResultSet rsb=db.executeQuery(sqlb);
if(rsb.next()){
	group_length=rsb.getInt("count(distinct main)");
}
String[] aaa=new String[group_length];
String[] bbb=new String[group_length];
String[] ccc=new String[group_length];
String m="";
String sqla="select distinct * from "+mod2+" order by tree_id,id";
ResultSet rsa=db.executeQuery(sqla);
while(rsa.next()){
	if(!m.equals(rsa.getString("main"))&&rsa.getString("thirdurl").equals("")&&!rsa.getString("secondurl").equals("")){
	aaa[i]=rsa.getString("main");
	ccc[i]=rsa.getString("mainurl");
	m=rsa.getString("main");
	bbb[i]=rsa.getString("secondurl").substring(10,rsa.getString("secondurl").length());
	int index=bbb[i].indexOf("/");
	bbb[i]=bbb[i].substring(index+1);
	index=bbb[i].indexOf("/");
	bbb[i]=bbb[i].substring(0,index);
	ccc[i]=ccc[i].substring(10,ccc[i].length());
	index=ccc[i].indexOf("/");
	ccc[i]=ccc[i].substring(index+1);
	index=ccc[i].indexOf("/");
	ccc[i]=ccc[i].substring(index+1);
	i++;
	}else if(!m.equals(rsa.getString("main"))&&!rsa.getString("thirdurl").equals("")){
	aaa[i]=rsa.getString("main");
	ccc[i]=rsa.getString("mainurl");
	m=rsa.getString("main");
	bbb[i]=rsa.getString("thirdurl").substring(10,rsa.getString("thirdurl").length());
	int index=bbb[i].indexOf("/");
	bbb[i]=bbb[i].substring(index+1);
	index=bbb[i].indexOf("/");
	bbb[i]=bbb[i].substring(0,index);
	ccc[i]=ccc[i].substring(10,ccc[i].length());
	index=ccc[i].indexOf("/");
	ccc[i]=ccc[i].substring(index+1);
	index=ccc[i].indexOf("/");
	ccc[i]=ccc[i].substring(index+1);
	i++;
	}
}
String[] aaa1=new String[group_length];
String[] bbb1=new String[group_length];
String[] ccc1=new String[group_length];
i=0;
int p=0;
for(int h=0;h<group_length;h++){
String sql1="select * from "+mod1+" where human_ID='"+user_ID+"' and main='"+aaa[h]+"'";
	ResultSet rs1=db.executeQuery(sql1);
	if(rs1.next()){
		aaa1[i]=aaa[h];
 bbb1[i]=bbb[h];
	 ccc1[i]=ccc[h];

	 i++;
	 p=group_length-i;
	}
}
if(pppp.equals("")){

%>
<table width="100%" height="6%" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td></tr>
 
</table>
 


<script>
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

</script>
<style type="text/css">
<!--
.trans_msg
 {
 filter:alpha(opacity=100,enabled=1) revealTrans(duration=.2,transition=1) blendtrans(duration=.2);
 }
-->
</style>
</head>
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<script>initToolTips()</script>
<table align="center" width="100%">


<%

int circle=(i+4)/5;
int iii=1;
int x=0;
for(int q=0;q<circle;q++){
	int j=0;
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%	while(x<aaa1.length-p){
	%>
 <td width="20%"><div align="center"><font id="menu<%=bbb1[x]%>"><img src="images/<%=bbb1[x]%>.gif" width="55" height="55" hspace="1" NAME="<%=bbb1[x]%>" onMouseOver="toolTip('<%=demo.getLang(group_name,aaa1[x])%>','#000000', '#FFFFE1')" onMouseOut="toolTip()"></td>



<%
x++;
iii++;
j++;
if(j>=5) break;
}
if(x<5){
for(int y=0;y<5-j;y++){

%>
<td width="110">&nbsp;</td>
<%}}%>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"><td colspan=5>&nbsp;</td></tr>

<%
}
db.close();

%>
</table>
</html>
<SCRIPT LANGUAGE=javascript>
if (mtDropDown.isSupported()) {
var ms = new mtDropDownSet(mtDropDown.direction.down, 0, 0, mtDropDown.reference.bottomLeft);
<%
int circle1=(i+4)/5;
int xx=1;
int xxx=0;


for(int q=0;q<i;q++){int j=0;%>
var menu<%=xx%> = ms.addMenu(document.getElementById("menu<%=bbb1[xxx]%>"));
<%String human_ID=(String)session.getAttribute("human_IDD");
nseer_db security_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db security_db2 = new nseer_db((String)session.getAttribute("unit_db_name"));
ResultSet rss15=security_db1.executeQuery("select * from "+mod+"_view where PARENT_CATEGORY_ID='"+xx+"'&&human_id='"+human_ID+"' order by CATEGORY_ID ");
int fff=0;


while(rss15.next()){
	ResultSet rss17=security_db2.executeQuery("select * from "+mod+"_view where PARENT_CATEGORY_ID='"+rss15.getString("CATEGORY_ID")+"'&&human_id='"+human_ID+"' order by CATEGORY_ID ");
if(rss17.next()){
	
	
	
	%>

	
menu<%=xx%>.addItem("<%=demo.getLang(group_name,rss15.getString("module_name"))%>",""); 

<%}else{
	String hreflink="../../"+rss15.getString("hreflink").substring(10);
	%>

menu<%=xx%>.addItem("<%=demo.getLang(group_name,rss15.getString("module_name"))%>","<%=hreflink%>"); 
<%}%>

<%ResultSet rss16=security_db2.executeQuery("select * from "+mod+"_view where PARENT_CATEGORY_ID='"+rss15.getString("CATEGORY_ID")+"'&&human_id='"+human_ID+"' order by CATEGORY_ID ");%>
<%if(rss16.next()){%>
var subMenu<%=fff%> = menu<%=xx%>.addMenu(menu<%=xx%>.items[<%=fff%>]);
<%do{
	String hreflink="../../"+rss16.getString("hreflink").substring(10);
	%>
subMenu<%=fff%>.addItem("<%=demo.getLang(group_name,rss16.getString("module_name"))%>","<%=hreflink%>");<%
}while(rss16.next());}fff++;}
security_db1.close();
security_db2.close();
%><%
xxx++;
xx++;
j++;
}
%>
mtDropDown.renderAll();
}
</SCRIPT>

<%}else{%>

	<table align="center" width="100%" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <font color="#1A98F1"><%=demo.getLang("erp","请了解功能介绍，操作请选择左边菜单。")%></td>
 
 <td <%=TD_STYLE3%> class="TD_STYLE3">
	  <div <%=DIV_STYLE1%> class="DIV_STYLE1">

 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" align="right" onClick="history.back();">

 </td>
	 
 </tr>
</table>
	<table> <tr <%=TR_STYLE1%> class="TR_STYLE1"><td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=topic%><%=demo.getLang("erp","功能介绍")%>:
</td></tr>
</tr>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <font color="#1A98F1"><%=function%>
</td>
 </tr>

	</table>
</html>
<%}
db.close();
%>

