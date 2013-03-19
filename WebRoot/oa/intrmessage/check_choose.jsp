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
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<html>
	<head>
<script language="javascript" src="../../javascript/ajax/ajax-select.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/ajax/select.css">
<style id=s>
div{cursor:hand;font-size:12px;}
a{text-decoration:none;color:red;font-size:12px}
</style>
</head>
<body>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String intrmessage_ID=request.getParameter("intrmessage_ID");
session.setAttribute("tfn","oa_config_public_char&type_name");
session.setAttribute("condition","kind='群发对象分类'");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="frmSearch" class="x-form" method="post" name="form1" action="check.jsp">
<input type="hidden" name="autosearch" id="autosearch"></input>
<input type="hidden" name="intrmessage_ID" value="<%=intrmessage_ID%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="50%">&nbsp;</td>
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确定")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td> 
</tr>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="50%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" id="op" name="fason" style="width: 39%;">
<%
String sql="select * from oa_config_public_char where kind='群发对象分类' order by type_ID";
ResultSet rs=oa_db.executeQuery(sql);
while(rs.next()){
%>
<option value="<%=exchange.toHtml(rs.getString("type_name"))%>"><%=exchange.toHtml(rs.getString("type_name"))%></option>
<%}
oa_db.close();%>
</select>
</td>
<td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td> 
</tr>
</table>
</form>
</div>