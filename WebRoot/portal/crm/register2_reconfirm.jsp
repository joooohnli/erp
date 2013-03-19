<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*"%>
<%@include file="../top.jsp"%>
<%@include file="../include/head.jsp"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db crm_db = new nseer_db("ondemand1");%>

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>

    <td width="930" valign="top"><table width="930" border="0" bgcolor="#FFFFFF">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","我要购买")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
	  <tr><td>	  
	  
<%
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String register_time=request.getParameter("register_time") ;
String remark = request.getParameter("remark");
String[] product_name=request.getParameterValues("product_name") ;
String[] product_ID=request.getParameterValues("product_ID") ;
String[] product_describe=request.getParameterValues("product_describe") ;
String[] amount=request.getParameterValues("amount") ;
String[] off_discount=request.getParameterValues("off_discount") ;
String[] list_price=request.getParameterValues("list_price") ;
String[] cost_price=request.getParameterValues("cost_price") ;
String[] real_cost_price=request.getParameterValues("real_cost_price") ;
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
if(p==0){
%>
<form id="register2" method="POST" action="../../portal_crm_register2_ok">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6" >
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3">
	 <div <%=DIV_STYLE1%> class="DIV_STYLE1">
	 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">
<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register2.jsp?customer_ID=<%=customer_ID%>">
	 <input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></td>
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
<%@include file="../include/paper_top.html"%>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>


<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_ID" type="hidden" width="100%" value="<%=customer_ID%>" ><%=customer_ID%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","电话")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_contact_person_tel" value="<%=exchange.toHtml(demand_contact_person_tel)%>"></td>
  </tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","拟订货时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="demand_pay_time" onfocus="" id="date_start" value="<%=exchange.toHtml(demand_pay_time)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_time" value="<%=exchange.toHtml(register_time)%>"><%=exchange.toHtml(register_time)%></td>
 </tr>
 </table><!--
  -->
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
</tr>
</table>
 <TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" >
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="7%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","小计（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","折扣（%）")%></td>
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
 <tr>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" onFocus="this.blur()" value="<%=product_ID[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(product_name[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" value="<%=product_describe[i]%>"><%=product_describe[i]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" value="<%=amount[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount_unit<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(amount_unit[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="list_price<%=i%>" value="<%=list_price[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price<%=i%>" type="hidden" value="<%=cost_price[i]%>"><input name="real_cost_price<%=i%>" type="hidden" value="<%=real_cost_price[i]%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(subtotal)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="off_discount<%=i%>" value="<%=off_discount[i]%>"></td>
 </tr>
<%
	}
%>
<input name="product_amount" type="hidden" value="<%=product_ID.length%>">

</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" height="65" width="9%"><%=demo.getLang("erp","备注")%>：</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="90%"><textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
</table>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%@include file="../include/paper_bottom.html"%>

<%}else{%>
<form id="form1" method="POST" action="register2.jsp">
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量、单价、折扣必须是数字，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
</form>
<%}}else{%>
<form id="form2" method="POST" action="register2.jsp">
<input type="hidden" name="customer_ID" value="<%=customer_ID%>">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择产品，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","返回")%>"></div>
 </td>
 </tr>
 </table>
</form>
<%}%>

<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
</td>
  </tr>
</table>
</td>
  </tr>
</table>
<%@include file="../bottom.jsp"%>