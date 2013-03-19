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
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String chain_ID=request.getParameter("chain_ID");
String sql="select * from hr_config_file_kind where file_id='"+chain_ID+"'";
ResultSet rs=hr_db.executeQuery(sql) ;
%>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭")%>" onClick="window.close();"></td>
 </tr>
 </table>
<%if(rs.next()){%>
<table <%=TABLE_STYLE7%> class="TABLE_STYLE7" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","机构编号")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("file_id")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","机构名称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("chain_name")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","机构简称")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("nick_name")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","责任人编号")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("describe1")%></td>
</tr>
</table>
<%}else{%>
<table <%=TABLE_STYLE7%> class="TABLE_STYLE7" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","该机构不存在")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("file_id")%></td>
</tr>
</table>
<%}
hr_db.close();
%>
</div>