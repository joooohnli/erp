<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<div id="nseerGround" class="nseerGround">
<script>
function key()
{
	var locate=document.getElementById('locate');
	var key_locate=document.getElementById('key_locate');
	locate.style.display='none';
	key_locate.style.display='block';
	document.getElementById('timeLocateValidation').action='register_module_key_locate_getpara.jsp';
}
function back()
{
	var locate=document.getElementById('locate');
	var key_locate=document.getElementById('key_locate');
	locate.style.display='block';
	key_locate.style.display='none';
	document.getElementById('timeLocateValidation').action='register_module_locate_getpara.jsp';
}
</script>

 <div align=center style="position:absolute;left:20px;right:20px;">
<%
String key_list_tag=request.getParameter("key_list_tag");
if(key_list_tag==null){
%>
 <form id="timeLocateValidation" class="x-form" method="post" action="register_module_locate_getpara.jsp">
<%}else{%>
 <form id="timeLocateValidation" class="x-form" method="post" action="register_module_key_locate_getpara.jsp">
<%}%>
<%
if(key_list_tag==null){
%>
<div id="locate" style="display:block">
<%}else{%>
<div id="locate" style="display:none">
<%}%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","选择")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","搜索")%>" onClick="key();"></div>
 </td>
 </tr>
 </table>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
 <script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</div>
<%

if(key_list_tag==null){
%>

<div id="key_locate" style="display:none">
<%}else{%>
<div id="key_locate" style="display:block">
<%}%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="开始">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="back();"></div>
 </td>
 </tr>
 </table>


 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","请输入关键字")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="keyword" type="text" style="width: 30%"></td> 
 </tr>
</table>
</form>
</div>