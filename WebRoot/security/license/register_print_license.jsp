<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 
<%
String human_ID=request.getParameter("human_ID");
String sql="select * from security_license where human_ID='"+human_ID+"'";
ResultSet rs=security_db.executeQuery(sql);
if(rs.next()){
%> 
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" class="Noprint"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","用户许可证")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","使用单位简称：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml((String)session.getAttribute("unit_id"))%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","姓名：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("human_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","员工档案编号：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getString("human_ID")%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","所在机构：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("chain_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","职位分类：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","职位名称：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","许可证号码：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("license_code"))%>&nbsp;</td>
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","有效期限(天)：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("expiry_period"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","发放时间：")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
<%
}
security_db.close();

%>