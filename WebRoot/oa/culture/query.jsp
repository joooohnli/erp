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
String culture_ID=request.getParameter("culture_ID");
String sql="select * from oa_culture where culture_ID='"+culture_ID+"'";
ResultSet rs=oa_db.executeQuery(sql);
if(rs.next()){
	String status="";
	String register_time=rs.getString("register_time");
	String check_time=rs.getString("check_time");
	String change_time=rs.getString("change_time");
switch(rs.getInt("check_tag")){
	case 0:
		status="未审核";
		check_time="";
		change_time="";
	break;
	case 1:
		status="审核通过";
		change_time="";
	break;
}
if(rs.getString("change_time").equals("1800-01-01 00:00:00.0")){
	change_time="";
}
String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","文化主题")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><%=exchange.toHtml(rs.getString("subject"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","文化类型")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("type"))%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","机构")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("chain_id"))%> <%=exchange.toHtml(rs.getString("chain_name"))%></td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","文化内容")%></legend><%=rs.getString("content")%></fieldset></div></td>
</tr>
<%=isPrint.printOrNot3(rs.getString("attachment1"),"附件1&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_culture","attachment1")%>
<%=isPrint.printOrNot3(rs.getString("attachment2"),"附件2&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_culture","attachment2")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","备注")%></legend><%=rs.getString("remark")%></fieldset></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register"))%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(register_time)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("checker"))%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","审核时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(check_time)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","最近变更")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('change_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&<%=demo.getLang("erp","culture_ID")%>=<%=rs.getString("culture_ID")%>')">
<%=lately_change_time%></a>&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","变更次数")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('change_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&culture_ID=<%=rs.getString("culture_ID")%>')">
<%=rs.getString("change_amount")%></a>&nbsp;</td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
oa_db.close(); 
%>