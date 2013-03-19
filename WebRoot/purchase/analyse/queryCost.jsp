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
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db purchasedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String purchase_ID=request.getParameter("purchase_ID");
try{
	String sql = "select * from purchase_purchase where purchase_ID='"+purchase_ID+"'" ;
	ResultSet rs = purchasedb.executeQuery(sql) ;
	if(rs.next()){
String check_tag="";
String stock_gather_tag="";
String pay_tag="";
String gather_tag="";
String invoice_tag="";
String purchase_tag="等待";
String color="#FF9A31";
String color1="#FF9A31";
String color2="#FF9A31";
String color3="#FF9A31";
String color4="#FF9A31";
String color5="#FF9A31";
if(rs.getString("check_tag").equals("1")){
check_tag="等待";
}else if(rs.getString("check_tag").equals("2")){
check_tag="通过";
color1="3333FF";
}else if(rs.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
color1="red";
}
if(rs.getString("stock_gather_tag").equals("1")){
stock_gather_tag="等待";
}else if(rs.getString("stock_gather_tag").equals("2")){
stock_gather_tag="执行";
color2="mediumseagreen";
}else if(rs.getString("stock_gather_tag").equals("3")){
stock_gather_tag="完成";
color2="3333FF";
}
if(rs.getString("pay_tag").equals("1")){
pay_tag="等待";
}else if(rs.getString("pay_tag").equals("2")){
pay_tag="执行";
color3="mediumseagreen";
}else if(rs.getString("pay_tag").equals("3")){
pay_tag="完成";
color3="3333FF";
}
if(rs.getString("gather_tag").equals("1")){
gather_tag="等待";
}else if(rs.getString("gather_tag").equals("2")){
gather_tag="执行";
color4="mediumseagreen";
}else if(rs.getString("gather_tag").equals("3")){
gather_tag="完成";
color4="3333FF";
}
if(rs.getString("invoice_tag").equals("1")){
invoice_tag="等待";
}else if(rs.getString("invoice_tag").equals("2")){
invoice_tag="执行";
color5="mediumseagreen";
}else if(rs.getString("invoice_tag").equals("3")){
invoice_tag="完成";
color5="3333FF";
}
if(rs.getString("purchase_tag").equals("1")){
purchase_tag="执行";
color="mediumseagreen";
}else if(rs.getString("purchase_tag").equals("2")){
purchase_tag="完成";
color="3333FF";
}
int pay_percent1=(int)(rs.getDouble("fund_paid_sum")/rs.getDouble("demand_cost_price_sum")*100);
String pay_percent=pay_percent1+"%";
int invoice_percent1=(int)(rs.getDouble("invoiced_sum")/rs.getDouble("demand_cost_price_sum")*100);
String invoice_percent=invoice_percent1+"%";
int gather_percent1=(int)(rs.getDouble("real_cost_price_sum")/rs.getDouble("demand_cost_price_sum")*100);
String gather_percent=gather_percent1+"%";
int stock_gather_percent1=(int)(rs.getDouble("stock_gathered_amount")/rs.getDouble("demand_amount")*100);
String stock_gather_percent=stock_gather_percent1+"%";
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('../purchase/query_print.jsp?purchase_ID=<%=purchase_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","采购执行单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","执行单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=purchase_ID%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库单编号集合")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getString("pay_ID_group")%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","供应商名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","供应商编号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","联系人")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","电话")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价(元)")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","采购数量")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","查看")%></td>
 </tr>
<%
String sql6="select * from purchase_details where purchase_ID='"+purchase_ID+"' order by details_number";
ResultSet rs6=purchase_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("demand_contact_person"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("demand_contact_person_tel"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("demand_amount"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="javascript:winopen('../purchase/query_purchase_details.jsp?purchase_ID=<%=purchase_ID%>&&provider_ID=<%=rs6.getString("provider_ID")%>')"><%=demo.getLang("erp","查看")%></a></td>
 </tr>
<%
	}
	purchase_db.close();
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","采购数量")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><%=exchange.toHtml(rs.getString("demand_amount"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核意见")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><%=rs.getString("remark")%>&nbsp;</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
	}
purchasedb.close();
	}
catch (Exception ex){
out.println("error"+ex);
}
%>