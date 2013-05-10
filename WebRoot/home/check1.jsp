<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" %>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@include file="head.jsp"%>
<script type="text/javascript" src="../javascript/include/div/divcolor.js"></script>
<TABLE width="80%" height="90%" border=0 cellPadding=0 cellSpacing=0 align="center" bgcolor="#F3F6F7"  class="example" id="example1">
 <script>
setGradient('example1','#A5E3FF','#ffffff',0);
</script>
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../images/bg_03.gif"></TD>
 <TD> 



<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>

<P> 
<TABLE align=center border=0 cellPadding=0 cellSpacing=0 width="650"> 
 <TBODY> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td vAlign=middle width="80%"> 
 <p align="center"><b><font color="#800000" size="4"><%=demo.getLang("erp","川大科技ERP系统")%></b></td></tr></TBODY></TABLE> 
<P> 
<SCRIPT language=javascript>function smilie(smilietext) { document.FORM.inpost.value=document.FORM.inpost.value+' :'+smilietext+': '; }</SCRIPT> 
 
<SCRIPT> 
function HighlightAll(theField) { 
var tempval=eval("document."+theField) 
tempval.focus() 
tempval.select() 
therange=tempval.createTextRange() 
therange.execCommand("Copy")} 
function DoTitle(addTitle) { 
var revisedTitle;var currentTitle = document.FORM.intopictitle.value;revisedTitle = addTitle+currentTitle;document.FORM.intopictitle.value=revisedTitle;document.FORM.intopictitle.focus(); 
return;} 
</SCRIPT> 

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="40"></td>
 </tr>
 </table>

<table align="center" bgcolor="E0E0E0">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"> 
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" bgcolor="#0066CC">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" width="342"><font color="FFFFFF"><%=demo.getLang("erp","系统警告")%></td>
  <td <%=TD_STYLE3%> class="TD_STYLE3" width="18">&nbsp; </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%" cellpadding="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" width="65" align="center"><font face="Wingdings" color="#FF0000" style="font-size:32pt">L</td>
  <td <%=TD_STYLE3%> class="TD_STYLE3" width="300">
 <%=demo.getLang("erp","对不起，您没有权限，如有疑问请联系系统管理员，")%><%=demo.getLang("erp","或者请检查你的用户名是否有使用单位简称作前缀，系统默认的前缀为:nseer_，请确认。")%>
 </td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2" align="center"> <input type="button" name="ok" value="<%=demo.getLang("erp","返回")%>" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onclick=location="login.jsp">
  </td>
 </tr>
 </table>
 </table>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="300"></td>
 </tr>
 </table> 
    
<%@include file="foot.htm"%>
<TD  background="../images/bg_04.gif"></TD>
    </TR>
    <TR>  
<TD width="1%" height="1%"><IMG  src="../images/bg_0lbottom.gif" ></TD>
      <TD background="../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../images/bg_0rbottom.gif"></TD>
    </TR>
  </TBODY>
</TABLE>