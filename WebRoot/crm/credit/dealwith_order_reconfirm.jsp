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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是 ：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String demand_customer_address=request.getParameter("demand_customer_address") ;
String demand_customer_mailing_address=request.getParameter("demand_customer_mailing_address") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String demand_pay_type=request.getParameter("demand_pay_type") ;
String demand_pay_fee_type=request.getParameter("demand_pay_fee_type") ;
String demand_pay_fee_sum2=request.getParameter("demand_pay_fee_sum") ;
StringTokenizer tokenTO1 = new StringTokenizer(demand_pay_fee_sum2,","); 
String demand_pay_fee_sum="";
 while(tokenTO1.hasMoreTokens()) {
  String demand_pay_fee_sum1 = tokenTO1.nextToken();
		demand_pay_fee_sum +=demand_pay_fee_sum1;
		}
if(demand_pay_fee_sum.equals("")) demand_pay_fee_sum="0";
String demand_gather_time=request.getParameter("demand_gather_time") ;
String demand_gather_type=request.getParameter("demand_gather_type") ;
String demand_gather_method=request.getParameter("demand_gather_method") ;
String demand_invoice_type=request.getParameter("demand_invoice_type") ;
String register_time=request.getParameter("register_time") ;
String sales_name=request.getParameter("sales_name") ;
String sales_ID=request.getParameter("sales_ID") ;
String register=request.getParameter("register") ;
String type=request.getParameter("type") ;
String invoice_info = request.getParameter("invoice_info");
String remark = request.getParameter("remark");
String[] product_name=request.getParameterValues("product_name") ;
String[] product_ID=request.getParameterValues("product_ID") ;
String[] product_describe=request.getParameterValues("product_describe") ;
String[] amount=request.getParameterValues("amount") ;
String[] off_discount=request.getParameterValues("off_discount") ;
String[] list_price=request.getParameterValues("list_price") ;
String[] cost_price=request.getParameterValues("cost_price") ;
String[] amount_unit=request.getParameterValues("amount_unit") ;
int a=product_ID.length;

if(a!=1){
int p=0;
for(int i=1;i<product_ID.length;i++){
	if(off_discount[i].equals("")) off_discount[i]="0";
	StringTokenizer tokenTO2 = new StringTokenizer(list_price[i],","); 
	String list_price2="";
 while(tokenTO2.hasMoreTokens()) {
  String list_price1 = tokenTO2.nextToken();
		list_price2 +=list_price1;
		}
		if(!validata.validata(amount[i])||!validata.validata(off_discount[i])||!validata.validata(list_price2)){
			p++;
		}
}
		if(!validata.validata(demand_pay_fee_sum)){
			p++;
		}
if(p==0){
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
<form id="register2" method="POST" action="register_ok.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>"></td><td <%=TD_STYLE3%> class="TD_STYLE3"><a href="register.jsp?customer_ID=<%=customer_ID%>&&customer_name=<%=toUtf8String.utf8String(exchange.toURL(customer_name))%>&&sales_name=<%=toUtf8String.utf8String(exchange.toURL(sales_name))%>"><img src="../../../images/return.jpg" width="37" height="18"></a></td><td <%=TD_STYLE3%> class="TD_STYLE3"><input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></td></tr></table>
 </td>
 </tr>
 </table>
<script language="javascript" src="/check.js"></script>
<script language="javascript">
var count=0;
function CheckForm(TheForm) {
	trimform(TheForm);
	if(count>0) {
 	return false;
 	}
 	count++;
<%for(int j=1;j<a;j++){%>
	if (TheForm.amount<%=j%>.value == ""||!chkint(TheForm.amount<%=j%>.value)) {
	alert("<%=demo.getLang("erp","请正确填写数量！")%>");
	TheForm.amount<%=j%>.focus();
		count=count-1;
	return(false);
	}	
<%}%>
	return(true);
}
</script>
 
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户名称 ")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="customer_name" type="hidden" value="<%=exchange.toHtml(customer_name)%>"><%=exchange.toHtml(customer_name)%></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户编号")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="customer_ID" type="hidden" value="<%=customer_ID%>"><%=customer_ID%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" colspan="2" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="demand_contact_person_tel" value="<%=exchange.toHtml(demand_contact_person_tel)%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","预提货时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="demand_pay_time" onfocus="setday(this)" value="<%=exchange.toHtml(demand_pay_time)%>"></td>
 </tr>
<input name="demand_customer_address" type="hidden">
<input name="demand_customer_mailing_address" type="hidden">
<input name="demand_contact_person" type="hidden">
<input name="demand_contact_person_fax" type="hidden">
<input name="demand_pay_type" type="hidden">
<input name="demand_pay_fee_type" type="hidden">
<input type="hidden" name="demand_pay_fee_sum">
<input type="hidden" name="demand_gather_time">
<input name="demand_gather_type" type="hidden">
<input name="demand_gather_method" type="hidden">
<input name="demand_invoice_type" type="hidden">
<input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>">
<input name="invoice_info" type="hidden">
<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","销售人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="sales_name" value="<%=exchange.toHtml(sales_name)%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","销售人编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="sales_ID" value="<%=sales_ID%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" colspan="2" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","客户类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="type" type="hidden" value="<%=exchange.toHtml(type)%>"><%=exchange.toHtml(type)%></td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" height="65" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="8" width="86.5%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","商品编号")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="4%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","折扣（%）")%></td>
 </tr>
<%

for(int i=1;i<product_ID.length;i++){
	if(off_discount[i].equals("")) off_discount[i]="0";
	StringTokenizer tokenTO2 = new StringTokenizer(list_price[i],","); 
	String list_price2="";
 while(tokenTO2.hasMoreTokens()) {
  String list_price1 = tokenTO2.nextToken();
		list_price2 +=list_price1;
		}
	double subtotal=Double.parseDouble(list_price2)*(1-Double.parseDouble(off_discount[i])/100)*Integer.parseInt(amount[i]);
	
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_ID<%=i%>" onFocus="this.blur()" value="<%=product_ID[i]%>"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_name<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(product_name[i])%>"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_describe<%=i%>" onFocus="this.blur()" value="<%=product_describe[i]%>"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="amount<%=i%>" value="<%=exchange.toHtml(amount[i])%>"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="amount_unit<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(amount_unit[i])%>"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="list_price<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(list_price[i])%>"></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input name="cost_price<%=i%>" type="hidden" value="<%=cost_price[i]%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(subtotal)%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="off_discount<%=i%>" value="<%=exchange.toHtml(off_discount[i])%>"></td>
 </tr>
<%
	}
%>
<input name="product_amount" type="hidden" value="<%=product_ID.length%>">
</table>
<%}else{%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
<form id="form1" method="POST" action="register.jsp">
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
<input type="hidden" name="customer_name" value="<%=customer_name%>">
<input type="hidden" name="sales_name" value="<%=sales_name%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量、单价、折扣、运费额度必须是数字，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</form>
</div>
<%}}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="form2" method="POST" action="register.jsp">
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
<input type="hidden" name="customer_name" value="<%=exchange.toHtml(customer_name)%>">
<input type="hidden" name="sales_name" value="<%=exchange.toHtml(sales_name)%>">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择产品，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</form>
</div>
<%}%> 
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>