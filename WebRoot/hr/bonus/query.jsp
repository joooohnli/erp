<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String human_ID=request.getParameter("human_ID");
String time=request.getParameter("time");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
if(time==null) time=formatter.format(now);
try{
	String sql1 = "select * from hr_bonus where human_ID='"+human_ID+"' and check_time<='"+time+"' order by check_time desc" ;
	ResultSet rs = hr_db.executeQuery(sql1) ;
	if(rs.next()){
	 String check_time=rs.getString("check_time").equals("1800-01-01 00:00:00.0")?"":rs.getString("check_time");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
</div></td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%" colspan="3"><%=rs.getString("human_ID")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><span align="left" class="style16"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("human_name")%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","奖励项目")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("bonus_item"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","奖励价值(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("bonus_worth"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","奖励等级")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("bonus_degree"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=exchange.toHtml(check_time)%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%"><%=demo.getLang("erp","备注")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%"><%=rs.getString("remark")%>&nbsp;</td>
<td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="11%">&nbsp;</td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="39%">&nbsp;</td>
	</tr> 
 </table>
<%
	}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><%=time%><%=demo.getLang("erp","之前没有奖励记录，请返回。")%></td>
 </tr>
</table>
<%
}
		hr_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</div>