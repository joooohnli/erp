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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="accountPeriod" scope="page" class="include.get_name_from_ID.AccountPeriod"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script src="../../javascript/table/movetable.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
try{
String table_width="100%";
String[] account_period=accountPeriod.getAccountPeriod((String)session.getAttribute("unit_db_name"));
String sql="select * from finance_voucher where account_tag='1' and profit_or_cost='0' and cost_tag='0' and account_period='"+account_period[0]+"' order by chain_ID";
ResultSet rs=finance_db.executeQuery(sql);
int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","结转")%>" onClick=location="../../finance_account_calculateCost_ok"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","等待转成本的记录总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr> 
</table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","期末结转成本")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="200"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","摘要")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","借 方")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","贷 方")%></td>
 </tr>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">

 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=demo.getLang("erp","数 量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=demo.getLang("erp","单 价")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=demo.getLang("erp","金 额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=demo.getLang("erp","数 量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=demo.getLang("erp","单 价")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=demo.getLang("erp","金 额")%></td>
 </tr>

<%
while(rs.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("register_time")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("voucher_in_month_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("summary"))%>&nbsp;</td>
<%if(rs.getDouble("debit_subtotal")!=0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("product_amount"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("product_price"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66">&nbsp;</td>
 <%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="66">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("product_amount"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("product_price"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="66"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>&nbsp;</td>
<%}
}%>
  </table>
<%@include file="../include/paper_bottom.html"%> 
</div>
<%

finance_db.close();
	 }catch(Exception ex){
		 ex.printStackTrace();
		}
%>

