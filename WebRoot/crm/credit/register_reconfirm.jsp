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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="FileKind" class="include.nseer_cookie.FileKind" scope="page"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是 ：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
String customer_ID=request.getParameter("customer_ID");
String customer_name=request.getParameter("customer_name");
String[] aaa=FileKind.getKind((String)session.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID);
String sales_name=request.getParameter("sales_name");
String sales_ID=request.getParameter("sales_ID");
String[] product_ID=request.getParameterValues("product_ID") ;
String[] amount=request.getParameterValues("amount") ;
int p=0;
for(int i=1;i<product_ID.length;i++){
	if(!validata.validata(amount[i])){
			p++;
		}
}
if(p==0){
String pay_ID=request.getParameter("pay_ID") ;
String payer_name=request.getParameter("payer_name") ;
String payer_ID=request.getParameter("payer_ID") ;
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String remark = request.getParameter("remark");
String new_apply=request.getParameter("new_apply") ;
String[] product_name=request.getParameterValues("product_name") ;
String[] product_describe=request.getParameterValues("product_describe") ;
String[] list_price=request.getParameterValues("list_price") ;
String[] cost_price=request.getParameterValues("cost_price") ;
String[] type=request.getParameterValues("type") ;
String[] amount_unit=request.getParameterValues("amount_unit") ;
int a=product_ID.length;
if(a!=1){
	%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>		 
 </tr>
 </table>
<form id="mutiValidation" method="POST" action="../../crm_credit_register_ok" onSubmit="return doValidate('mutiValidation')&&CheckForm(this)">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../crm_credit_register_draft_ok'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">
	 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();">
	 <input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div></td>
	 </tr>	 
 </table>   
<%
double demand_amount=0.0d;
double list_price_sum=0.0d;
double cost_price_sum=0.0d;
for(int j=1;j<product_ID.length;j++){
	StringTokenizer tokenTO2 = new StringTokenizer(list_price[j],","); 
String list_price2="";
 while(tokenTO2.hasMoreTokens()) {
  String list_price1 = tokenTO2.nextToken();
		list_price2 +=list_price1;
		}
	demand_amount+=Double.parseDouble(amount[j]);
	list_price_sum+=Double.parseDouble(list_price2)*Double.parseDouble(amount[j]);
		cost_price_sum+=Double.parseDouble(cost_price[j])*Double.parseDouble(amount[j]);
}
%>
<script language="javascript" src="../../javascript/input_control/check.js"></script>
<script language="javascript">
var count=0;
function CheckForm(TheForm) {
	trimform(TheForm);
	if(count>0) {
 	return false;
 	}
 	count++;
<%for(int j=1;j<a;j++){%>
	if (TheForm.amount<%=j%>.value == ""||!chkfin(TheForm.amount<%=j%>.value)) {
	alert("请正确填写数量！");
	TheForm.amount<%=j%>.focus();
		count=count-1;
	return(false);
	}	
<%}%>
	return(true);
}
</script>
<input type="hidden" name="new_apply" value="<%=new_apply%>">
<input name="pay_ID" type="hidden" value="<%=pay_ID%>">
<input name="customer_ID" type="hidden" value="<%=customer_ID%>">
<input name="sales_ID" type="hidden" value="<%=sales_ID%>">
 <div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","赊货申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","客户分类")%>&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="payer_chain_name" value="<%=exchange.toHtml(aaa[1])%>" type="hidden"><%=exchange.toHtml(aaa[1])%></td>
<input name="payer_ID" type="hidden" value="">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","赊货人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_name" value="<%=exchange.toHtml(customer_name)%>" type="hidden"><%=exchange.toHtml(customer_name)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","是否归还")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="not_return_tag"><option value="0"><%=demo.getLang("erp","是")%></option>
  </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","归还时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_return_time" type="hidden" onfocus="setday(this)" value="<%=exchange.toHtml(demand_return_time)%>"><%=exchange.toHtml(demand_return_time)%></td>
</tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=tableOnlineEdit>
<thead>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","产品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","市场单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>
 </tr>
<%

for(int i=1;i<product_ID.length;i++){
	StringTokenizer tokenTO3 = new StringTokenizer(list_price[i],","); 
String list_price3="";
 while(tokenTO3.hasMoreTokens()) {
  String list_price1 = tokenTO3.nextToken();
		list_price3 +=list_price1;
		}
	double list_price_subtotal=Double.parseDouble(list_price3)*Double.parseDouble(amount[i]);
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(product_name[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" onFocus="this.blur()" value="<%=product_ID[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><div><%=product_describe[i]%></div><input type="hidden" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" value="<%=product_describe[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" value="<%=exchange.toHtml(amount[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit<%=i%>" type="hidden" value="<%=exchange.toHtml(amount_unit[i])%>" onFocus="this.blur()"><%=exchange.toHtml(amount_unit[i])%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="list_price<%=i%>" type="hidden" value="<%=exchange.toHtml(list_price[i])%>"><%=exchange.toHtml(list_price[i])%></td>
 <input name="cost_price<%=i%>" type="hidden" value="<%=exchange.toHtml(cost_price[i])%>">
 <input name="type<%=i%>" type="hidden" value="<%=exchange.toHtml(type[i])%>">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(list_price_subtotal)%></td>
 </tr>
 </thead>
<%
	}
stock_db.close();
%>
</table>
<input name="product_amount" type="hidden" value="<%=product_ID.length%>">
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","总件数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_amount" type="hidden" value="<%=demand_amount%>"><%=demand_amount%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","总金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="list_price_sum" type="hidden" value="<%=list_price_sum%>"><%=list_price_sum%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","销售人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="sales_name" value="<%=exchange.toHtml(sales_name)%>" type="hidden"><%=exchange.toHtml(sales_name)%></td>
<input name="payer_ID" type="hidden" value="">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","出库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="reason" type="hidden" value="销售赊货 "><%=demo.getLang("erp","销售赊货 ")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" onfocus="setday(this)" value="<%=exchange.toHtml(register_time)%>"><%=exchange.toHtml(register_time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" height="65" width="9%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="7" width="86.5%">
 <textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
</form>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">

<%}else{
	 stock_db.close();	
	%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>		 
 </tr>
 </table> 
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register.jsp?sales_name=<%=toUtf8String.utf8String(exchange.toURL(sales_name))%>&&customer_ID=<%=customer_ID%>&&customer_name=<%=toUtf8String.utf8String(exchange.toURL(customer_name))%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择产品，请返回")%>。</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
  </div>
<%
		 }}else{
			 stock_db.close();
			 %>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>		 
 </tr>
 </table> 
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register.jsp?sales_name=<%=toUtf8String.utf8String(exchange.toURL(sales_name))%>&&customer_ID=<%=customer_ID%>&&customer_name=<%=toUtf8String.utf8String(exchange.toURL(customer_name))%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量必须是数字，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
 </div>
<%}%> 
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>