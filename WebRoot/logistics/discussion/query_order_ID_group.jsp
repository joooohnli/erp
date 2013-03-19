<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db logisticsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div>
 </td>
 </tr>
</table>
<%
String discussion_ID_group=request.getParameter("discussion_ID") ;
StringTokenizer tokenTO = new StringTokenizer(discussion_ID_group,", "); 
 while(tokenTO.hasMoreTokens()) {
				String discussion_ID=tokenTO.nextToken();
try{
String sql="select * from logistics_discussion where discussion_ID='"+discussion_ID+"'";
ResultSet rs=logisticsdb.executeQuery(sql);
while(rs.next()){
String check_tag="";
String discussion_tag="";
String color="#FF9A31";
String color1="#FF9A31";
String color2="#FF9A31";
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
if(rs.getString("discussion_tag").equals("1")){
discussion_tag=demo.getLang("erp","等待");
}else if(rs.getString("discussion_tag").equals("2")){
discussion_tag=demo.getLang("erp","完成");
color2="3333FF";
}
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
<%=demo.getLang("erp","报价单编号")%>：<font color="<%=color%>"><%=rs.getString("discussion_ID")%><%=order_tag%></font> <%=demo.getLang("erp","其中审核状态")%>：<font color="<%=color1%>"><%=check_tag%></font>
<%=demo.getLang("erp","处理状态")%>：<font color="<%=color2%>"><%=discussion_tag%></font>
</td> 
 </tr>
 </table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("customer_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","拟订货时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%" colspan="2"><%=exchange.toHtml(rs.getString("demand_pay_time"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","销售人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("sales_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","销售人编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs.getString("sales_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%" colspan="2"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" height="65" width="11%"><%=demo.getLang("erp","备注")%>  </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="8" width="86.5%"><%=rs.getString("remark")%></textarea>&nbsp;
 </td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);
%>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","总计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="37.4%"><%=rs.getString("sale_price_sum")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","报价单附件")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="4" width="37.4%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=logistics_discussion&fieldname=attachment_name')"><%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","运费（元）")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","折扣（%）")%></td>
 </tr>
<%
int i=1;
String sql6="select * from logistics_discussion_details where discussion_ID='"+discussion_ID+"'";
ResultSet rs6=logistics_db.executeQuery(sql6);
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
	
%>
</table>

<%
}
logisticsdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
			}
			logistics_db.close();
%>