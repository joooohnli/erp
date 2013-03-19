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
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language=javascript src="../../javascript/winopen/winopen.js"></script>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<%
String change_time=exchange.unURL(request.getParameter("time"));
String knowledge_ID=request.getParameter("knowledge_ID");
String sql="select * from oa_knowledge_dig where knowledge_ID='"+knowledge_ID+"' and change_time='"+change_time+"'";
ResultSet rs=oa_db.executeQuery(sql);
if(rs.next()){
	String status="";
	String register_time=rs.getString("register_time");
	String check_time=rs.getString("check_time");
switch(rs.getInt("check_tag")){
	case 0:
		status="未审核";
		check_time="";
	break;
	case 1:
		status="审核通过";
	break;
}
String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","知识主题")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("subject"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","知识分类")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("type"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","内容")%>&nbsp;</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=rs.getString("content")%></td>
</tr>
<%=isPrint.printOrNot3(rs.getString("attachment1"),"附件1&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_knowledge_dig","attachment1")%>
<%=isPrint.printOrNot3(rs.getString("attachment2"),"附件2&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_knowledge_dig","attachment2")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","备注")%>&nbsp;</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=rs.getString("remark")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","登记人")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("register"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","登记时间")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(register_time)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","审核人")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("checker"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","审核时间")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(check_time)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","最近变更时间")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><a href="javascript:winopen('query_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&knowledge_ID=<%=rs.getString("knowledge_ID")%>')">
<%=lately_change_time%></a>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","变更次数")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="80%"><a href="javascript:winopen('query_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&knowledge_ID=<%=rs.getString("knowledge_ID")%>')">
<%=rs.getString("change_amount")%></a>&nbsp;</td>
</tr>
</table>
<%
}else{
	%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","没有变更")%></td>
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close();"></div></td>
</tr>
</table>
	<%
}
oa_db.close(); 
	%>