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

String stock_ID=request.getParameter("stock_ID");
String product_ID=request.getParameter("product_ID");
String pay_ID=request.getParameter("pay_ID");
String timea=request.getParameter("timea");
String timeb=request.getParameter("timeb");
if(timea==null) timea="";
if(timeb==null) timeb="";
if(!timea.equals("")) timea=timea+" 00:00:00";
if(!timeb.equals("")) timeb=timeb+" 23:59:59";
String sql="";
if(timea.equals("")&&timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' order by register_time";
}else if(!timea.equals("")&&timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' and register_time>='"+timea+"' order by register_time";
}else if(timea.equals("")&&!timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' and register_time<='"+timeb+"' order by register_time";
}else if(!timea.equals("")&&!timeb.equals("")){
	sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' and register_time>='"+timea+"' and register_time<='"+timeb+"' order by register_time";
}
 ResultSet rs = stock_db.executeQuery(sql) ;
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<form method="post" action="../../stock_pay_register_choose_bat_ok">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","出库")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","搜索")%>" onClick=location="register_choose_bat_locate.jsp?stock_ID=<%=stock_ID%>&&product_ID=<%=product_ID%>&&pay_ID=<%=pay_ID%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
</tr>
</table>
<input name="stock_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=stock_ID%>">
<input name="product_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=product_ID%>">
<input name="pay_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=pay_ID%>">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","出库单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>  
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
<tr <%=TR_STYLE2%> class="TR_STYLE2">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品编号")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品名称")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","库房名称")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","入库时间")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","B/N")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","数量")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","出库数量")%></td>
</tr>
<%
while(rs.next()){
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<input type="hidden" name="serial_number" value=<%=rs.getString("serial_number")%>>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("product_ID")%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("stock_name"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("serial_number")%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("amount"))%>&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="paid_amount" type="text"></td>
</tr>
<%}%>
  </table>
  </form>
  </div>
<%@include file="../include/paper_bottom.html"%>
 
<%stock_db.close();%>
 