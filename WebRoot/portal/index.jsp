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
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>

<%
try{
	 demo.setPath(request);
%>
 <%
 nseer_db db = new nseer_db("ondemand1");
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
	margin-bottom: 0px;
}

.STYLE1 {
	font-family: "宋体";
	font-size: 15px;
	line-height: 16pt;
	}
.STYLE4{font-family: "宋体"; font-size: 14px; color: #000000; line-height: 16pt;}
.STYLE5 {font-family: "宋体"; font-size: 14px; }
.STYLE6 {
	font-family: "宋体";
	font-size: 15px;
	line-height: 18pt;
	}
-->
	a:link {
	color: #000000;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #000000;
}
a:active {
	text-decoration: none;
	color: #000000;
}
</style>
</head>
<%
	String qq1="";
	String qq2="";
nseer_db db_index = new nseer_db("ondemand1");
String sql_index="select qq1,qq2 from ecommerce_contact where check_tag='1' order by id";
ResultSet rs_index=db_index.executeQuery(sql_index);
if(rs_index.next()){
	qq1=rs_index.getString("qq1");
	qq2=rs_index.getString("qq2");
}
db_index.close();
%>
<div id="ad" style="position:absolute">
<table border="0" cellpadding="0" cellspacing="0" width="139" align="center">
<!-- fwtable fwsrc="未命名" fwbase="未命名-2.jpg" fwstyle="Dreamweaver" fwdocid = "678153004" fwnested="0" -->
  <tr>
   <td bgcolor="#99CDFF" width="139" height="35" colspan="3" align="center"><font size="2" color="#000000"><b><%=demo.getLang("erp","在线咨询")%></b></td>
  </tr>
  <tr>
   <td bgcolor="#99CDFF" width="7" height="90"></td>
   <td bgcolor="#D6FAFA" class="STYLE1" border="0"><table width="100" border="0" cellpadding="0" cellspacing="0">
       <tr>
         <td height="4"><table width="118" border="0" cellpadding="0" cellspacing="0">
          
           <tr>
             <td>
		 <a target=blank href=http://wpa.qq.com/msgrd?V=1&amp;Uin=491438396&amp;Site=恩信科技&amp;Menu=yes><font style=font-size:12px;>491438396<img SRC=http://wpa.qq.com/pa?p=10:491438396:10 border=0 ></font></a><br>
		 <a target=blank href=http://wpa.qq.com/msgrd?V=1&amp;Uin=772861935&amp;Site=恩信科技&amp;Menu=yes><font style=font-size:12px;>772861935<img SRC=http://wpa.qq.com/pa?p=10:772861935:10 border=0 ></font></a><br><br>
		
		  </td>
           </tr>
         </table>
	</td>
    </tr>
    <tr>
         <td height="4"><table width="121" border="0" cellpadding="0" cellspacing="0">
         </table></td>
       </tr>
     </table></td>
   <td bgcolor="#99CDFF" width="7" height="90"></td>
  </tr>
  <tr>
   <td bgcolor="#99CDFF" width="139" height="25" align="right" colspan="3"><img src="../images/close.jpg" onClick="javascript:closead()">&nbsp;</td>
  </tr>
</table>
</div>
  <script>
  var x = 50,y = 60
  var xin = true, yin = true
  var step = 1 
  var delay = 30
  var obj=document.getElementById("ad") 
  function floatAD() {
     var L=T=0
     var R= document.body.clientWidth-obj.offsetWidth
     var B = document.body.clientHeight-obj.offsetHeight
     obj.style.left = x + document.body.scrollLeft
     obj.style.top = y + document.body.scrollTop
     x = x + step*(xin?1:-1)  
     if (x < L) { xin = true; x = L} 
     if (x > R){ xin = false; x = R} 
     y = y + step*(yin?1:-1) 
     if (y < T) { yin = true; y = T } 
     if (y > B) { yin = false; y = B } 
  }
  function closead(){
	  obj.style.display="none";
  }
  var itl= setInterval("floatAD()", delay) 
obj.onmouseover=function(){clearInterval(itl)} 
obj.onmouseout=function(){itl=setInterval("floatAD()", delay)}
  </script>
<%@include file="top1.jsp"%>
<%
		if(strhead.indexOf(browercheck.IE)==-1){
%>
<body bgcolor="#ffffff" oncontextmenu="event.returnValue=true"  style="background-image:url(images/pro.jpg)">
<%}else{%>
<body bgcolor="#E9EAEB" oncontextmenu="event.returnValue=true" style="background-image:url(images/pro.jpg)">
<div>
<table width="930" height="25" border="0" align="center" cellpadding="0" cellspacing="0" bordercolorlight="#848284">
<tr><td bgcolor="#ffffff" width="80" >
&nbsp;&nbsp;我的公告：
</td>
<td width="850" bgcolor="#ffffff"><MARQUEE scrollamount="2" onmouseover=this.stop() onmouseout=this.start() ScrollAmount=1 ScrollDelay=30  direction=left border="0" ><%=wb.getContent()%></MARQUEE></td>
			  <td bgcolor="#ffffff">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
</tr></table>
<%}%>
<%
circle=(cols_main.length+2)/3;
int ee=cols_main.length%3;
m=0;
int p=0;
for(int i=0;i<circle;i++){
%>
<table width="930" height="200" bgcolor=#EBEBEB bordercolorlight=#848284 bordercolordark=#ffffff border=0 cellspacing=1 cellpadding=0 align="center">
  <tr>
<%
		if(m<cols_main.length){
String[] record=tb.getTable("ondemand1","nseer",cols_main[m]);
%>
    <td width="310" valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" 
 align="left">&nbsp;<font size="2" color="#FFFFFF"><%=demo.getLang("erp",cols_main[m])%></font></td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right"><a href="<%=record[3]%>/index.jsp?column=<%=toUtf8String.utf8String(exchange.toURL(record[7]))%>"><font size="2" color="#FFFFFF"><%=demo.getLang("erp","更多")%></font></a>&nbsp;</td>
        </tr>
      <tr>
        <td height="156" bgcolor="#ffffff" colspan="2" valign="top">&nbsp;<img src="images/jt0.gif" border="0">
<%
String field1="";
String field2="";
StringTokenizer tokenTO = new StringTokenizer(record[2],",");
		while(tokenTO.hasMoreTokens()) {
			field1 = tokenTO.nextToken();
			field2 = tokenTO.nextToken();
		}
String sql="";
if(record[3].equals("other")){
	sql="select * from "+record[0]+" where "+record[1]+" and chain_ID!='02' limit 8";
}else{
	sql="select * from "+record[0]+" where "+record[1]+" limit 8";
}
ResultSet rs=db.executeQuery(sql);
while(rs.next()){	
%>
<a href="<%=record[3]%>/index_details.jsp?id=<%=rs.getString("id")%>"><font size="2"><%=exchange.toHtml(rs.getString(field1))%>--<%=exchange.toHtml(rs.getString(field2))%></font></a><br>
<%}%>
</td>
        </tr>
		<tr><td height="24" colspan="2" bgcolor="#E9F8F0" class="STYLE1" align="right">
<%
if(!record[4].equals("")){	
%>
  <a href="<%=record[3]%>/register1.jsp"><font color="#000000" size="2"><%=demo.getLang("erp",record[4])%></font></a>&nbsp;
<%}
if(!record[5].equals("")){
%>
  <a href="<%=record[3]%>/register2.jsp"><font color="#000000" size="2"><%=demo.getLang("erp",record[5])%></font></a>&nbsp;
<%}%>
<a href="self/index.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","自助服务")%></font></a></td>
        </tr>
    </table>
	</td>
<%}
m++;
		if(m<cols_main.length){
String[] record=tb.getTable("ondemand1","nseer",cols_main[m]);
%>
    <td width="300" valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" align="left">&nbsp;<font size="2" color="#FFFFFF"><%=demo.getLang("erp",cols_main[m])%></font></td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right"><a href="<%=record[3]%>/index.jsp?column=<%=toUtf8String.utf8String(exchange.toURL(record[7]))%>"><font size="2" color="#FFFFFF"><%=demo.getLang("erp","更多")%></font></a>&nbsp;</td>
        </tr>
      <tr>
        <td height="156" bgcolor="#ffffff" colspan="2" valign="top">&nbsp;<img src="images/jt0.gif" border="0">
<%
String field1="";
String field2="";
StringTokenizer tokenTO = new StringTokenizer(record[2],",");
		while(tokenTO.hasMoreTokens()) {
			field1 = tokenTO.nextToken();
			field2 = tokenTO.nextToken();
		}
String sql="";
if(record[3].equals("other")){
	sql="select * from "+record[0]+" where "+record[1]+" and chain_ID!='02' limit 8";
}else{
	sql="select * from "+record[0]+" where "+record[1]+" limit 8";
}
ResultSet rs=db.executeQuery(sql);
while(rs.next()){	
%>
<a href="<%=record[3]%>/index_details.jsp?id=<%=rs.getString("id")%>"><font size="2"><%=exchange.toHtml(rs.getString(field1))%>--<%=exchange.toHtml(rs.getString(field2))%></font></a><br>
<%}%>
</td>
        </tr>
		<tr><td height="24" colspan="2" bgcolor="#E3F5FA" class="STYLE1" align="right">
<%
if(!record[4].equals("")){	
%>
  <a href="<%=record[3]%>/register1.jsp"><font color="#000000" size="2"><%=demo.getLang("erp",record[4])%></font></a>&nbsp;
<%}
if(!record[5].equals("")){
%>
  <a href="<%=record[3]%>/register2.jsp"><font color="#000000" size="2"><%=demo.getLang("erp",record[5])%></font></a>&nbsp;
<%}%>
<a href="self/index.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","自助服务")%></font></a></td>
        </tr>
    </table>
	</td>
<%}else{
%>
<td valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/erp.jpg)" align="left"><font size="2" color="#000000">&nbsp;</font></td>
		<td height="24" style="background-image:url(images/erp.jpg)" align="right">&nbsp;</td>
        </tr>
      <tr>
        <td height="156" bgcolor="#ffffff" colspan="2" valign="top">&nbsp;</td>
        </tr>
		<tr>
		<td height="24" width="25%" bgcolor="#e3f5fa" class="STYLE1">&nbsp;</td>
		<td height="24" width="4%" bgcolor="#e3f5fa" class="STYLE1">&nbsp;</td>
        </tr>
    </table>
	</td>
<%
}
m++;
		if(m<cols_main.length){
String[] record=tb.getTable("ondemand1","nseer",cols_main[m]);
%>
    <td valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" align="left">&nbsp;<font size="2" color="#FFFFFF"><%=demo.getLang("erp",cols_main[m])%></font></td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right"><a href="<%=record[3]%>/index.jsp?column=<%=toUtf8String.utf8String(exchange.toURL(record[7]))%>"><font size="2" color="#FFFFFF"><%=demo.getLang("erp","更多")%></font></a>&nbsp;</td>
        </tr>
      <tr>
        <td height="156" bgcolor="#FFFFFF" colspan="2" valign="top">&nbsp;<img src="images/jt0.gif" border="0">
<%
String field1="";
String field2="";
StringTokenizer tokenTO = new StringTokenizer(record[2],",");
		while(tokenTO.hasMoreTokens()) {
			field1 = tokenTO.nextToken();
			field2 = tokenTO.nextToken();
		}
String sql="";
if(record[3].equals("other")){
	sql="select * from "+record[0]+" where "+record[1]+" and chain_ID!='02' limit 8";
}else{
	sql="select * from "+record[0]+" where "+record[1]+" limit 8";
}
ResultSet rs=db.executeQuery(sql);
while(rs.next()){	
%>
<a href="<%=record[3]%>/index_details.jsp?id=<%=rs.getString("id")%>"><font size="2"><%=exchange.toHtml(rs.getString(field1))%>--<%=exchange.toHtml(rs.getString(field2))%></font></a><br>
<%}%>
</td>
        </tr>
		<tr><td height="24" colspan="2" bgcolor="#F1FBF1" class="STYLE1" align="right">
<%
if(!record[4].equals("")){
%>
  <a href="<%=record[3]%>/register1.jsp"><font color="#000000" size="2"><%=demo.getLang("erp",record[4])%></font></a>&nbsp;
<%}
if(!record[5].equals("")){
%>
  <a href="<%=record[3]%>/register2.jsp"><font color="#000000" size="2"><%=demo.getLang("erp",record[5])%></font></a>&nbsp;
<%}%>
<a href="self/index.jsp"><font color="#000000" size="2"><%=demo.getLang("erp","自助服务")%></font></a></td>
        </tr>
    </table>
	</td>
<%}else{
%>
<td width="310" valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" align="left"><a href="../home/login.jsp" target="_blank"><font size="2" color="#FFFFFF"><%=demo.getLang("erp","我的ERP")%></font></a></td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right">&nbsp;</td>
        </tr>
      <tr>
       <td height="180" width="270" colspan="2" valign="top"><a href="../home/login.jsp" target="_blank"><img src="images/erp.jpg" border="0"></a></td>
        </tr>
    </table>
	</td>
<%
}
m++;
%>
  </tr>
</table>
<%}
if(ee==0){
%>
<table width="930" height="200" bgcolor=#EBEBEB bordercolorlight=#848284 bordercolordark=#ffffff border=0 cellspacing=1 cellpadding=0 align="center">
  <tr>
  <td valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" align="left">&nbsp;</td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right">&nbsp;</td>
        </tr>
      <tr>
        <td height="156" bgcolor="#ffffff" colspan="2" valign="top">&nbsp;</td>
        </tr>
		<tr><td height="24" colspan="2" bgcolor="#E9F8F0" class="STYLE1" align="right">&nbsp;</td>
        </tr>
    </table>
	</td>
  <td valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" align="left"><font size="2" color="#000000">&nbsp;</font></td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right">&nbsp;</td>
        </tr>
      <tr>
        <td height="156" bgcolor="#ffffff" colspan="2" valign="top">&nbsp;</td>
        </tr>
		<tr>
		<td height="24" width="25%" bgcolor="#e3f5fa" class="STYLE1">&nbsp;</td>
		<td height="24" width="4%" bgcolor="#e3f5fa" class="STYLE1">&nbsp;</td>
        </tr>
    </table>    
	</td>
  <td valign="top">
	<table width="310" height="200" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="24" style="background-image:url(images/port.jpg)" align="left"><a href="../home/login.jsp" target="_blank"><font size="2" color="#FFFFFF"><%=demo.getLang("erp","我的ERP")%></font></a></td>
		<td height="24" style="background-image:url(images/port.jpg)" align="right">&nbsp;</td>
        </tr>
     <tr>
        <td height="180" width="260" colspan="2" valign="top"><a href="../home/login.jsp" target="_blank"><img src="images/erp.jpg" border="0"></a></td>
        </tr>
    </table>
	</td>
    </tr>
</table>
<%}%>
    </td>
  </tr>
<%@include file="bottom1.jsp"%>
</body>
</html>
<%}catch(Exception ex){
	ex.printStackTrace();
}%>