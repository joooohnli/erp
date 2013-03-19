<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crmdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language=javascript src="../../javascript/winopen/winopen.js"></script>
<%
String reasonexact=exchange.unURL(request.getParameter("reasonexact")) ;
try{
String sql="select * from crm_ordering where reasonexact='"+reasonexact+"'";
ResultSet rs=crmdb.executeQuery(sql);
if(rs.next()){
	String invoice_time=rs.getString("real_invoice_time");
	if(rs.getString("real_invoice_time").equals("1800-01-01 00:00:00.0")){
		invoice_time="";
	}
	String register=rs.getString("register");
	String register_ID=rs.getString("register_ID");
	String invoice_group=rs.getString("invoice_group");
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_details_print.jsp?reasonexact=<%=exchange.toURL(reasonexact)%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","订单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("reasonexact")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","客户名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(invoice_time)%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","发票类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("real_invoice_type"))%>&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","应开票额度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","已开票额度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次开票额度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","备注")%></td>
 </tr>
<%
	int i=1;
String sql6="select * from crm_ordering where reasonexact='"+reasonexact+"' order by details_number,id";
ResultSet rs6=crmdb.executeQuery(sql6);
while(rs6.next()){
	double invoiced_subtotal=0.0d;
	String sql7="select * from crm_order_details where order_ID='"+reasonexact+"' and details_number='"+rs6.getString("details_number")+"'";
	ResultSet rs7=crm_db.executeQuery(sql7);
	if(rs7.next()){
		invoiced_subtotal=rs7.getDouble("invoiced_subtotal");
	}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("unit"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(invoiced_subtotal)%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoice_sum"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("remark")%>&nbsp;</td>
 </tr>
<%
	i++;
	}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4"> 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(register)%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票人编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=register_ID%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","发票号码")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><%=exchange.toHtml(invoice_group)%>&nbsp;</td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
crm_db.close();
crmdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>