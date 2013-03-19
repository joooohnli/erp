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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmountDetails" scope="request"/>
<jsp:useBean id="length" class="stock.getLength" scope="request"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crmdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
int lll=0;
String order_ID=request.getParameter("order_ID") ;
String sql="select * from crm_order_retail_temp where order_ID='"+order_ID+"'";
ResultSet rs=crm_db.executeQuery(sql);
if(rs.next()){
String stock_name=rs.getString("stock_name");
String stock_ID=rs.getString("stock_ID");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<form id="register2" method="POST" action="../../crm_retail_register_ok">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" onclick=location="register.jsp" value="<%=demo.getLang("erp","返回")%>"></div></td>
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
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","零售店")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("hr_third_kind_name"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","零售库房")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("stock_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","会员编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("customer_ID")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","会员名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("customer_name"))%></td>
</tr>
 <input type=hidden name="order_ID" value="<%=order_ID%>"/>
 <input type=hidden name="type" value="<%=exchange.toHtml(rs.getString("type"))%>"/>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE id=tableOnlineEdit <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="9%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价（元）")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","库存数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","B/N或S/N")%></td>
 </tr>
<%
String sql1="select * from crm_order_retail_details_temp where order_ID='"+order_ID+"' order by details_number";
ResultSet rs1=crmdb.executeQuery(sql1);
while(rs1.next()){
	int serial_number_tag=0;
		String sql2="select * from stock_cell where product_ID='"+rs1.getString("product_ID")+"' and check_tag='1'";
		ResultSet rs2=stock_db.executeQuery(sql2);
		if(rs2.next()){
			serial_number_tag=rs2.getInt("serial_number_tag");
		}
		if(serial_number_tag==1){
		lll=length.getLength((String)session.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)session.getAttribute("unit_db_name"));
			}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("details_number")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("product_ID")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("product_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("amount"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("amount_unit"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("list_price"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("subtotal"))%></td>
<%if(serial_number_tag==1){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="register_choose.jsp?order_ID=<%=order_ID%>&&product_ID=<%=rs1.getString("product_ID")%>&&stock_ID=<%=stock_ID%>"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs1.getString("product_ID"),stock_name)%></a>&nbsp;</td>
<%}else if(serial_number_tag==2){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="register_choose_bat.jsp?order_ID=<%=order_ID%>&&product_ID=<%=rs1.getString("product_ID")%>&&stock_ID=<%=stock_ID%>"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs1.getString("product_ID"),stock_name)%></a>&nbsp;</td>
<%}else{%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs1.getString("product_ID"),stock_name)%>&nbsp;</td>
<%
 }
	String sql5="select * from stock_paying_temp where pay_ID='"+order_ID+"' and product_ID='"+rs1.getString("product_ID")+"' and stock_ID='"+stock_ID+"'";
		 ResultSet rs5=stock_db.executeQuery(sql5);
		 if(rs5.next()){
		 %>
		 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="serial_number" size="<%=lll-1%>" value="<%=rs5.getString("serial_number")%>"><input name="amount_number" type="hidden" size="<%=lll-1%>" value="<%=rs5.getString("amount_number")%>"></td>
		 <%}else{%>

 <td <%=TD_STYLE2%> class="TD_STYLE2"><%if(serial_number_tag!=0){%><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="serial_number" size="<%=lll-1%>"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_number" type="hidden" size="<%=lll-1%>" value=""><%}else{%><input name="serial_number" type="hidden" size="<%=lll-1%>" value=""><input name="amount_number" type="hidden" size="<%=lll-1%>" value=""><%}%></td><%}%>
 </tr>
<%
	}
 crmdb.close();
 stock_db.close();
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","销售编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("sales_ID")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","销售人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("sales_name"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","收银员")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","时间")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register_time"))%></td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><%=rs.getString("remark")%></td>
 </tr>
</table>
<%
}
crm_db.close();
%>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>