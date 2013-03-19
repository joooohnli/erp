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
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db intrmanufacturedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
try{
	String sql = "select * from intrmanufacture_intrmanufacture where intrmanufacture_ID='"+intrmanufacture_ID+"'" ;
	ResultSet rs = intrmanufacturedb.executeQuery(sql) ;
	if(rs.next()){
String check_tag="";
String stock_invoice_tag="";
String pay_tag="";
String invoice_tag="";
String intrmanufacture_tag="等待";
String color="#FF9A31";
String color1="#FF9A31";
String color2="#FF9A31";
String color3="#FF9A31";
String color4="#FF9A31";
String color5="#FF9A31";
if(rs.getString("invoice_tag").equals("1")){
invoice_tag="等待";
}else if(rs.getString("invoice_tag").equals("2")){
invoice_tag="执行";
color4="mediumseagreen";
}else if(rs.getString("invoice_tag").equals("3")){
invoice_tag="完成";
color4="3333FF";
}
if(rs.getString("intrmanufacture_tag").equals("1")){
intrmanufacture_tag="执行";
color="mediumseagreen";
}else if(rs.getString("intrmanufacture_tag").equals("2")){
intrmanufacture_tag="完成";
color="3333FF";
}
int invoiced_percent1=(int)(rs.getDouble("invoiced_sum")/rs.getDouble("demand_cost_price_sum")*100);
String invoiced_percent=invoiced_percent1+"%";
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_print.jsp?intrmanufacture_ID=<%=intrmanufacture_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","执行单编号")%>：<font color="<%=color%>"><%=rs.getString("intrmanufacture_ID")%><%=intrmanufacture_tag%></font>
 <%=demo.getLang("erp","其中 收发票状态")%>：<font color="<%=color4%>"><%=exchange.toHtml(invoice_tag)%></font> </td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","发票登记单")%></b></font></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><%=intrmanufacture_ID%></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","明细序号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","委外厂商名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","委外厂商编号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","联系人")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","电话")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","应开票金额")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","已收到金额")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","本次收到金额")%></td>
 </tr>
<%
	int i=1;
String sql6="select * from intrmanufacture_purchasing where intrmanufacture_ID='"+intrmanufacture_ID+"' and kind='发票' and check_tag='1' order by register_time";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("real_contact_person"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("real_contact_person_tel"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoiced_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoicing_sum"))%>&nbsp;</td>
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应开票总额")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已开票总额")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("invoiced_sum"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
	</tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
 </div>
<%
	}
	intrmanufacture_db.close();
	intrmanufacturedb.close();
	}
catch (Exception ex){
out.println("error"+ex);
}
%>