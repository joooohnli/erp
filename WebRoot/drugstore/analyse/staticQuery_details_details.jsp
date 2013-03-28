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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>


<%
String static_report_ID=request.getParameter("static_report_ID");
String stock_name=request.getParameter("stock_name");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String amount=request.getParameter("amount");

String sql = "select * from stock_balance_static_report_details_details where stock_name='"+stock_name+"' and product_ID='"+product_ID+"' and static_report_ID='"+static_report_ID+"'";

 ResultSet rs = stock_db.executeQuery(sql) ;
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
	 if(Double.parseDouble(amount)<0) intRowCount=-intRowCount;

double amount1=Double.parseDouble(amount)-intRowCount;
int k=1;
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
</tr>
</table>
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
		 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td colspan="2"><%=demo.getLang("erp","产品：")%><%=product_name%><%=demo.getLang("erp","在")%><%=stock_name%><%=demo.getLang("erp","中共有")%><%=amount%><%=demo.getLang("erp","件，其中有S/N号码的")%><%=intRowCount%><%=demo.getLang("erp","件，没有S/N号码的")%><%=amount1%><%=demo.getLang("erp","件。")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1">
  <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE1%> class="TD_STYLE1" width="13%" align="left"><%=demo.getLang("erp","产品编号")%></td>
	<td <%=TD_STYLE1%> class="TD_STYLE1" width="13%" align="left"><%=demo.getLang("erp","产品名称")%></td>
	<td <%=TD_STYLE1%> class="TD_STYLE1" width="13%" align="left"><%=demo.getLang("erp","库房名称")%></td>
	<td <%=TD_STYLE1%> class="TD_STYLE1" width="13%" align="left">S/N</td>
	<td <%=TD_STYLE1%> class="TD_STYLE1" width="14%" align="left"><%=demo.getLang("erp","入库时间")%></td>
</tr>
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("product_ID")%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("stock_name"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("serial_number"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
</tr>
<%
k++;
%>
</page:pages>
  </table>
  </div>
<%stock_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="queryBalance_details_details.jsp"/>