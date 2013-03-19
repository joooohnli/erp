<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<%nseer_db document_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db document_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<%
String id=request.getParameter("id");
String sql = "select * from document_multilanguage where id='"+id+"'";
	ResultSet rs = document_db.executeQuery(sql);
	if(rs.next()){
	
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="query_list.jsp"></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE7%> class="TABLE_STYLE7" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","分类")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("kind"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","组名")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("tablename"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","单词")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("name"))%></td>
</tr>
<%
String sql10="select * from document_config_public_char where kind='语言类型'";
ResultSet rs10=document_db1.executeQuery(sql10);
int t=0;

while(rs10.next()){
	t++;}
	rs10.first();

for(int i=0;i<t;i++){

%>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=exchange.toHtml(rs10.getString("type_name"))%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString(rs10.getString("type_name")))%></td>
</tr>
	
<%
		rs10.next();
	}
rs10.first();
%>
</table>
<%}
document_db.close();
%>
 </div>