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
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%@include file="../include/head1.jsp"%>
<title><%=demo.getLang("erp","恩信科技开源ERP")%></title>

<%@ page import="include.nseer_cookie.isPrint"%>
<%isPrint isPrint=new isPrint(request);%>
<% 
	 demo.setPath(request);
%>

<script language=javascript src="../../javascript/winopen/winopen.js"></script>
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<div id="nseerGround" class="nseerGround">
<%
String message_ID=request.getParameter("message_ID");
String sql="select * from oa_message where message_ID='"+message_ID+"'";
ResultSet rs=oa_db.executeQuery(sql);
if(rs.next()){
	String status="";
	String register_time=rs.getString("register_time");
	String check_time=rs.getString("check_time");
switch(rs.getInt("check_tag")){
	case 0:
		status="未发送";
		check_time="";
	break;
	case 1:
		status="已发送";
	break;
}
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><%=demo.getLang("erp","公告详情")%></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE5">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","主题")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("subject"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","分类")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("type"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","内容")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("content")%></td>
</tr>
<%=isPrint.printOrNot3(rs.getString("attachment1"),"附件1&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_message","attachment1")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","备注")%>&nbsp;</td> 
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=rs.getString("remark")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","登记人")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(rs.getString("register"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="20%"><%=demo.getLang("erp","登记时间")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="80%"><%=exchange.toHtml(register_time)%></td>
</tr>
</table>
<%
}
	oa_db.close(); 
	 %>
</div>