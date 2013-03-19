<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseer_db.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String changer=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String id=request.getParameter("id");
try{
	String sql="select * from hr_major_release where id='"+id+"'";
	ResultSet rs= hr_db.executeQuery(sql) ;
	if(rs.next()){
		String remark1=exchange.unHtml(rs.getString("remark1"));
		String remark2=exchange.unHtml(rs.getString("remark2"));
%>
<form id="query" method="post" action="../resume/register_major.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","申请该职位")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td> 
 </tr> 
 </table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","招聘类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("engage_type"))%>&nbsp;</td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="hidden" name="human_major_first_kind_ID" value="<%=rs.getString("human_major_first_kind_ID")%>">&nbsp;<input type="hidden" name="human_major_first_kind_name" value="<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="hidden" name="human_major_second_kind_ID" value="<%=rs.getString("human_major_second_kind_ID")%>">&nbsp;<input type="hidden" name="human_major_second_kind_name" value="<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","招聘人数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("human_amount"))%>&nbsp;</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","截止日期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rs.getString("deadline")%>&nbsp;</td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","职位描述")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rs.getString("remark1")%>&nbsp;</td>
<td height="65" <%=TD_STYLE4%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","招聘要求")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rs.getString("remark2")%>&nbsp;</td>
	</tr> 
</table>
</form>
<%
	}
	hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>