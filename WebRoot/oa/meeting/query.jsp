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
<script language=javascript src="../../javascript/winopen/winopenm.js"></script>
<%
String meeting_ID=request.getParameter("meeting_ID");
String sql="select * from oa_meeting where meeting_ID='"+meeting_ID+"'";
ResultSet rs=oa_db.executeQuery(sql);
if(rs.next()){
	String status="";
	String planing="";
switch(rs.getInt("check_tag")){
	case 0:
		status="未通知";
	break;
	case 1:
		status="已通知";
	break;
	case 2:
		status="已整理纪要";
	break;
	case 3:
		status="已处理纪要";
	break;
}
if(rs.getString("ifplaning").equals("0")) planing="需制定计划";
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
 </table>
  <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本会议状态：")%><%=status%>&nbsp;&nbsp;<%=planing%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp</td>
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
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议主题")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><span id="meeting_subject"><%=rs.getString("subject")%></span>&nbsp;&nbsp;<a href="javascript:winopenm('query_attend_details.jsp?meeting_ID=<%=rs.getString("meeting_ID")%>&&readXml=n')"><%=demo.getLang("erp","参加人员")%></a>&nbsp;&nbsp;<a href="javascript:winopenm('query_dealwith_details.jsp?meeting_ID=<%=rs.getString("meeting_ID")%>&&readXml=n')"><%=demo.getLang("erp","获得纪要人员")%></a></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","开始时间")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="begin_time"><%=exchange.toHtml(rs.getString("begin_time"))%></span></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","结束时间")%>：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="end_time"><%=exchange.toHtml(rs.getString("end_time"))%></span></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议地点")%>：</td> 
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="place"><%=exchange.toHtml(rs.getString("place"))%></span></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","会议类型")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="meeting_type"><%=exchange.toHtml(rs.getString("type"))%></span></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","会议日程")%></legend><span id="schedule"><%=rs.getString("schedule")%></span></fieldset></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","会议纪要")%></legend><span id="content"><%=rs.getString("content")%></span></fieldset></div></td>
</tr>

<%=isPrint.printOrNot3(rs.getString("attachment1"),"附件&nbsp;&nbsp;&nbsp;&nbsp;",response,TR_STYLE1,TD_STYLE1,TD_STYLE2,rs.getString("id"),"oa_meeting","attachment1")%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" colspan="4" width="100%"><div align="left"><fieldset><legend><%=demo.getLang("erp","备注")%></legend><span id="remark"><%=rs.getString("remark")%></span></fieldset></div></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>

<%
}
oa_db.close(); 
%>