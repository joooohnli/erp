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
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>

 <center>
 <table cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
 </center>
</div>
<P> 
<TABLE align=center border=0 cellPadding=0 cellSpacing=0 width="650"> 
 <TBODY> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td vAlign=middle width="80%"> 
 <p align="center"><b><font color="#800000" size="4"><%=demo.getLang("erp","恩信科技ERP系统")%></b></td></tr></TBODY></TABLE> 
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

 <center>
 <table cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="40"></td>
 </tr>
 </table>
 </center>
</div>
&nbsp;<table align="center" cellspacing="0" bordercolorlight="000000" bordercolordark="FFFFFF" bgcolor="E0E0E0">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"> <table bgcolor="#0066CC" cellspacing="0" cellpadding="2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td width="342"><font color="FFFFFF"><%=demo.getLang("erp","系统警告")%></td>
  <td width="18">&nbsp; </td>
 </tr>
 </table>
 <table width="100%" cellpadding="4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td width="65" align="center"><font face="Wingdings" color="#FF0000" style="font-size:32pt">L</td>
  <td width="300">
 <%=demo.getLang("erp","对不起，您没有权限，如有疑问请联系系统管理员。")%><%=demo.getLang("erp","或者请检查你的用户名是否有使用单位简称作前缀，系统默认的前缀为:nseer_，请确认。")%>
 </td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td colspan="2" align="center"> <input type="button" name="ok" value="<%=demo.getLang("erp","返回")%>" onclick=location="login.jsp">
  </td>
 </tr>
 </table></table>

 <center>
 <table cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="300"></td>
 </tr>
 </table>
 </center>
</div>      
<%@include file="foot.htm"%>   