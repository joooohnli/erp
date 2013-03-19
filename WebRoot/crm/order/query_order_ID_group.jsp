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
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="关闭窗口" onClick="window.close()"></div></td>
 </tr>
 </table>
<%
String order_ID_group=request.getParameter("order_ID") ;
StringTokenizer tokenTO = new StringTokenizer(order_ID_group,", "); 
while(tokenTO.hasMoreTokens()) {
	String order_ID=tokenTO.nextToken();
try{
String sql="select * from crm_order where order_ID='"+order_ID+"'";
ResultSet rs=crmdb.executeQuery(sql);
if(rs.next()){
String check_tag="";
String manufacture_tag="";
String pay_tag="";
String logistics_tag="";
String receive_tag="";
String gather_tag="";
String invoice_tag="";
String order_tag=demo.getLang("erp","等待");
String color="#FF9A31";
String color1="#FF9A31";
String color2="#FF9A31";
String color3="#FF9A31";
String color4="#FF9A31";
String color5="#FF9A31";
String color6="#FF9A31";
String color7="#FF9A31";
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
if(rs.getString("logistics_tag").equals("1")){
logistics_tag=demo.getLang("erp","等待");
}else if(rs.getString("logistics_tag").equals("2")){
logistics_tag=demo.getLang("erp","执行");
color6="mediumseagreen";
}else if(rs.getString("logistics_tag").equals("3")){
logistics_tag=demo.getLang("erp","完成");
color6="3333FF";
}
if(rs.getString("receive_tag").equals("1")){
receive_tag=demo.getLang("erp","等待");
}else if(rs.getString("receive_tag").equals("2")){
receive_tag=demo.getLang("erp","执行");
color7="mediumseagreen";
}else if(rs.getString("receive_tag").equals("3")){
receive_tag=demo.getLang("erp","完成");
color7="3333FF";
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
 <div>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","销售订单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("customer_ID")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","电话")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","提货时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("demand_pay_time"))%>&nbsp;</td>	 
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","机构")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("hr_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","销售人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("sales_name"))%>&nbsp;</td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品名称")%> </td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getDouble("off_discount")%>&nbsp;</td>
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
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","总计")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","订单附件")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=crm_order&fieldname=attachment_name')"><%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1"> 
<%
String accomplish_time="";
if(!rs.getString("accomplish_time").equals("1800-01-01 00:00:00.0")){
	accomplish_time=rs.getString("accomplish_time");
}
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","完成时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(accomplish_time)%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("type"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
  <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><%=rs.getString("remark")%>&nbsp;
</td>
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<%
}
}
catch (Exception ex){
out.println("error"+ex);
}
			}
	crm_db.close();
	crmdb.close();
%>