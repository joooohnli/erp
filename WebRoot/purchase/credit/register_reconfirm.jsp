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
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
String provider_ID=request.getParameter("provider_ID");
String provider_name=request.getParameter("provider_name");
String[] aaa=FileKind.getKind((String)session.getAttribute("unit_db_name"),"purchase_file","provider_ID",provider_ID);
String purchaser=request.getParameter("purchaser");
String purchaser_ID=request.getParameter("purchaser_ID");
String[] product_ID=request.getParameterValues("product_ID") ;
String[] amount=request.getParameterValues("amount") ;
int p=0;
for(int i=1;i<product_ID.length;i++){
	if(!validata.validata(amount[i])){
			p++;
		}
}
if(p==0){
String gather_ID=request.getParameter("gather_ID") ;
String gatherer_ID=request.getParameter("gatherer_ID") ;
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String remark = request.getParameter("remark");
String new_apply=request.getParameter("new_apply") ;
String[] product_name=request.getParameterValues("product_name") ;
String[] product_describe=request.getParameterValues("product_describe") ;
String[] cost_price=request.getParameterValues("cost_price") ;
String[] type=request.getParameterValues("type") ;
String[] amount_unit=request.getParameterValues("amount_unit") ;
int a=product_ID.length;
if(a!=1){
	%>
<form id="mutiValidation" method="POST" action="../../purchase_credit_register_ok" onSubmit="return CheckForm(this)">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
	</tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8"><%=DgButton.getDraft("'mutiValidation','../../purchase_credit_register_draft_ok'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register.jsp?gather_ID=<%=gather_ID%>&&provider_ID=<%=provider_ID%>&&purchaser=<%=toUtf8String.utf8String(exchange.toURL(purchaser))%>&&provider_name=<%=toUtf8String.utf8String(exchange.toURL(provider_name))%>">&nbsp;<input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></td></tr></table>
<%
double demand_amount=0.0d;
double cost_price_sum=0.0d;
for(int j=1;j<product_ID.length;j++){
StringTokenizer tokenTO2 = new StringTokenizer(cost_price[j],","); 
String cost_price2="";
 while(tokenTO2.hasMoreTokens()) {
  String cost_price1 = tokenTO2.nextToken();
		cost_price2 +=cost_price1;
		}
	demand_amount+=Double.parseDouble(amount[j]);
	cost_price_sum+=Double.parseDouble(cost_price2)*Double.parseDouble(amount[j]);
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
	alert(<%=demo.getLang("erp","请正确填写数量！")%>);
	TheForm.amount<%=j%>.focus();
		count=count-1;
	return(false);
	}	
<%}%>
	return(true);
}
</script>
<div id="nseerGround" class="nseerGround">
 <%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","放货登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
<input name="provider_ID" type="hidden" value="<%=provider_ID%>">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="fileKind_chain" value="<%=aaa[0]%> <%=exchange.toHtml(aaa[1])%>" type="hidden"><%=aaa[0]%> <%=exchange.toHtml(aaa[1])%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","放货人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="provider_name" value="<%=exchange.toHtml(provider_name)%>" type="hidden"><%=exchange.toHtml(provider_name)%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","采购人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="purchaser" value="<%=exchange.toHtml(purchaser)%>" type="hidden">
 <input name="purchaser_ID" value="<%=exchange.toHtml(purchaser_ID)%>" type="hidden"><%=exchange.toHtml(purchaser)%></td>
<input name="gatherer_ID" type="hidden" value="">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","入库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="reason" type="hidden" value="采购放货"><%=demo.getLang("erp","采购放货")%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","是否归还")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="not_return_tag">
 
 <%if(not_return_tag.equals("是")){%>
						<option value="0" selected><%=demo.getLang("erp","是")%></option>						
<%}%>
  </select></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","归还时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_return_time" type="hidden" value="<%=exchange.toHtml(demand_return_time)%>"><%=exchange.toHtml(demand_return_time)%></td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td width="5%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","序号")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品名称")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","产品编号")%></td>
 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","描述")%></td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","数量")%></td>
 <td width="5%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","单位")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","单价（元）")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","小计（元）")%></td>
 </tr>
<%

for(int i=1;i<product_ID.length;i++){
	StringTokenizer tokenTO3 = new StringTokenizer(cost_price[i],","); 
String cost_price3="";
 while(tokenTO3.hasMoreTokens()) {
  String cost_price1 = tokenTO3.nextToken();
		cost_price3 +=cost_price1;
		}
	double cost_price_subtotal=Double.parseDouble(cost_price3)*Double.parseDouble(amount[i]);
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_name<%=i%>" onFocus="this.blur()" value="<%=exchange.toHtml(product_name[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_ID<%=i%>" onFocus="this.blur()" value="<%=product_ID[i]%>"></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><div><%=product_describe[i]%></div><input type="hidden" <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="product_describe<%=i%>" onFocus="this.blur()" value="<%=product_describe[i]%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="amount<%=i%>" value="<%=exchange.toHtml(amount[i])%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit<%=i%>" type="hidden" value="<%=exchange.toHtml(amount_unit[i])%>" onFocus="this.blur()"><%=exchange.toHtml(amount_unit[i])%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price<%=i%>" type="hidden" value="<%=exchange.toHtml(cost_price[i])%>"><%=exchange.toHtml(cost_price[i])%></td>
	 
	 <input name="type<%=i%>" type="hidden" value="<%=exchange.toHtml(type[i])%>">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cost_price_subtotal)%></td>
 </tr>
<%
	}
stock_db.close();
%>
<input name="product_amount" type="hidden" value="<%=product_ID.length%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>"><%=exchange.toHtml(register_time)%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总件数")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_amount" type="hidden" value="<%=demand_amount%>"><%=demand_amount%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="cost_price_sum" type="hidden" value="<%=cost_price_sum%>"><%=cost_price_sum%></td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%" height="65"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register.jsp?purchaser=<%=toUtf8String.utf8String(exchange.toURL(purchaser))%>&&provider_ID=<%=provider_ID%>&&provider_name=<%=toUtf8String.utf8String(exchange.toURL(provider_name))%>"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择产品，请返回。")%></td>
 </tr>
 </table>
</div>
<%}}else{
			 stock_db.close();
			 %>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>	 
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<input name="provider_name" value="<%=exchange.toHtml(provider_name)%>" type="hidden">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量必须是数字，请返回。")%></td>
 </tr>
 </table>
</div>
<%}%> 
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>