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
<head>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
</head>
<%
String order_ID=request.getParameter("order_ID") ;
try{
String sql="select * from crm_order where order_ID='"+order_ID+"'";
ResultSet rs=crmdb.executeQuery(sql);
if(rs.next()){
String check_tag="";
String manufacture_tag="";
String pay_tag="";
String gather_tag="";
String invoice_tag="";
String order_tag=demo.getLang("erp","等待");
String color="#FF9A31";
String color1="#FF9A31";
String color2="#FF9A31";
String color3="#FF9A31";
String color4="#FF9A31";
String color5="#FF9A31";
if(rs.getString("check_tag").equals("0")&&rs.getString("modify_tag").equals("0")){
check_tag=demo.getLang("erp","等待");
}else if(rs.getString("check_tag").equals("0")&&rs.getString("modify_tag").equals("1")){
check_tag=demo.getLang("erp","执行");
color1="mediumseagreen";
}else if(rs.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","完成");
color1="3333FF";
}else if(rs.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
color1="red";
}
if(rs.getString("manufacture_tag").equals("1")){
manufacture_tag=demo.getLang("erp","等待");
}else if(rs.getString("manufacture_tag").equals("2")){
manufacture_tag=demo.getLang("erp","执行");
color2="mediumseagreen";
}else if(rs.getString("manufacture_tag").equals("3")){
manufacture_tag=demo.getLang("erp","完成");
color2="3333FF";
}
if(rs.getString("pay_tag").equals("1")){
pay_tag=demo.getLang("erp","等待");
}else if(rs.getString("pay_tag").equals("2")){
pay_tag=demo.getLang("erp","执行");
color3="mediumseagreen";
}else if(rs.getString("pay_tag").equals("3")){
pay_tag=demo.getLang("erp","完成");
color3="3333FF";
}
if(rs.getString("gather_tag").equals("1")){
gather_tag=demo.getLang("erp","等待");
}else if(rs.getString("gather_tag").equals("2")){
gather_tag=demo.getLang("erp","执行");
color4="mediumseagreen";
}else if(rs.getString("gather_tag").equals("3")){
gather_tag=demo.getLang("erp","完成");
color4="3333FF";
}
if(rs.getString("invoice_tag").equals("1")){
invoice_tag=demo.getLang("erp","等待");
}else if(rs.getString("invoice_tag").equals("2")){
invoice_tag=demo.getLang("erp","执行");
color5="mediumseagreen";
}else if(rs.getString("invoice_tag").equals("3")){
invoice_tag=demo.getLang("erp","完成");
color5="3333FF";
}
if(rs.getString("order_tag").equals("1")){
order_tag=demo.getLang("erp","执行");
color="mediumseagreen";
}else if(rs.getString("order_tag").equals("2")){
order_tag=demo.getLang("erp","完成");
color="3333FF";
}
int pay_percent1=(int)(rs.getDouble("paid_amount_sum")/rs.getDouble("pay_amount_sum")*100);
String pay_percent=pay_percent1+"%";
int invoice_percent1=(int)(rs.getDouble("invoiced_sum")/rs.getDouble("sale_price_sum")*100);
String invoice_percent=invoice_percent1+"%";
int gather_percent1=(int)(rs.getDouble("gathered_sum")/rs.getDouble("sale_price_sum")*100);
String gather_percent=gather_percent1+"%";
int manufacture_percent1=(int)(rs.getDouble("manufactured_sum")/rs.getDouble("sale_price_sum")*100);
String manufacture_percent=manufacture_percent1+"%";
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_print.jsp?order_ID=<%=order_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","零售单编号")%>：<%=rs.getString("order_ID")%><font color="<%=color%>"><%=order_tag%></font>
 <%=demo.getLang("erp","其中审核状态")%>： <font color="<%=color1%>"><%=check_tag%></font> <%=demo.getLang("erp","出库状态")%>：<font color="<%=color3%>"><%=pay_tag%></font>
 <%=demo.getLang("erp","回款状态")%>： <font color="<%=color4%>"><%=gather_tag%></font> <%=demo.getLang("erp","发票状态")%>：<font color="<%=color5%>"><%=invoice_tag%></font></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","零售单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("customer_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("type"))%>&nbsp;</td> 
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","完成时间")%>：</td>
 <%
String accomplish_time="";
if(!rs.getString("accomplish_time").equals("1800-01-01 00:00:00.0")){
	accomplish_time=rs.getString("accomplish_time");
}
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(accomplish_time)%>&nbsp;</td>	 
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","折扣（%）")%></td>
 </tr>
<%
int i=1;
String sql6="select * from crm_order_details where order_ID='"+order_ID+"'";
ResultSet rs6=crm_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("off_discount")%>&nbsp;</td>
 </tr>
<%
	i++;
	}
	crm_db.close();
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","总计")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","机构")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("chain_id"))%> <%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","销售人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("sales_name"))%>&nbsp;</td> 
 </tr>	
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><%=rs.getString("remark")%>&nbsp;
</td>
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
crmdb.close();
}
catch (Exception ex){
ex.printStackTrace();
}
%>