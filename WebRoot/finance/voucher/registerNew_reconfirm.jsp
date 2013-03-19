<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="getThreeKindsFromChain" scope ="page" class ="include.get_three_kinds.getThreeKindsFromChain"/>

<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<%
String voucher_in_month_ID=request.getParameter("voucher_in_month_ID");
String attachment_amount=request.getParameter("attachment_amount");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String[] summary_content1=request.getParameterValues("summary_content1");
String[] selectb2=request.getParameterValues("selectb2");
String[] debit_subtotal1=request.getParameterValues("debit_subtotal1");
String[] loan_subtotal1=request.getParameterValues("loan_subtotal1");
String[] product_amount1=request.getParameterValues("product_amount1");
String[] attachment_ID1=request.getParameterValues("attachment_ID1");
String[] number_in_cash_table1=request.getParameterValues("number_in_cash_table1");
int a=summary_content1.length;
double debit_sum=0.0d;
double loan_sum=0.0d;
String first_kind_ID="";
		String first_kind_name="";
		String second_kind_ID="";
		String second_kind_name="";
		String third_kind_ID="";
		String third_kind_name="";
if(a!=1){
int p=0;
int pp=0;
for(int i=1;i<a;i++){
	if(selectb2[i].equals("")) p++;
}
if(p==0){
for(int i=1;i<a;i++){
	if(!debit_subtotal1[i].equals("")){
	StringTokenizer tokenTO2 = new StringTokenizer(debit_subtotal1[i],","); //把国际标准金额转换数学数字。 
	String debit_subtotal12="";
 while(tokenTO2.hasMoreTokens()) {
  String debit_subtotal11 = tokenTO2.nextToken();
		debit_subtotal12 +=debit_subtotal11;
		}
		if(!validata.validata(debit_subtotal12)){
			p++;
		}else{
			debit_sum+=Double.parseDouble(debit_subtotal12);
		}
	}
	if(!loan_subtotal1[i].equals("")){
	StringTokenizer tokenTO2 = new StringTokenizer(loan_subtotal1[i],","); 
	String loan_subtotal12="";
 while(tokenTO2.hasMoreTokens()) {
  String loan_subtotal11 = tokenTO2.nextToken();
		loan_subtotal12 +=loan_subtotal11;
		}
		if(!validata.validata(loan_subtotal12)){
			p++;
		}else{
			loan_sum+=Double.parseDouble(loan_subtotal12);
		}
	}
String[] chain=getThreeKindsFromChain.getThreeKinds((String)session.getAttribute("unit_db_name"),selectb2[i]);
  first_kind_ID =chain[0];
				first_kind_name =chain[1];
				second_kind_ID =chain[2];
				second_kind_name =chain[3];
				third_kind_ID =chain[4];
				third_kind_name =chain[5];
			if((first_kind_name.equals("库存商品")||first_kind_name.equals("销售收入")||first_kind_name.equals("固定资产"))&&product_amount1[i].equals("")){
				pp++;
			}
}
String time1=register_time.substring(0,8)+"01";
int time_temp2=Integer.parseInt(register_time.substring(5,7))+1;
String time2=register_time.substring(0,5)+time_temp2+"-01";

String sql1="select * from finance_voucher where register_time>='"+time1+"' and register_time<'"+time2+"' and voucher_in_month_ID='"+voucher_in_month_ID+"'";
ResultSet rs1=finance_db.executeQuery(sql1);
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
int j = path.indexOf("erp");
if(j!=-1){
	path = path.substring(j-1,path.length());
}
if(!rs1.next()){
if(debit_sum==loan_sum){
if(p==0&&pp==0){
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" method="POST" action="../../finance_voucher_registerNew_ok">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back()" value="<%=demo.getLang("erp","返回")%>"></div></td>
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
 <td align="center"><font size="4"><b><%=demo.getLang("erp","记帐凭证")%></b></font></td>
 </tr>
 </table>   
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4"">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="8%"><%=demo.getLang("erp","凭证号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="18%"><input name="voucher_in_month_ID" type="hidden" value="<%=voucher_in_month_ID%>" style="width:100%"><%=voucher_in_month_ID%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="11%"><%=demo.getLang("erp","附件张数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><input name="attachment_amount" type="hidden" value="<%=attachment_amount%>" style="width:100%"><%=attachment_amount%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="12%"><%=demo.getLang("erp","制单")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><input name="register" type="hidden" value="<%=exchange.toHtml(register)%>" style="width:100%"><%=exchange.toHtml(register)%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="6%"><%=demo.getLang("erp","时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="18%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(register_time)%>" onfocus="setday(this)"><%=exchange.toHtml(register_time)%></td>
</tr>
</table> 
<table <%=TABLE_STYLE11%> class="TABLE_STYLE11" id=theObjTable>
<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><%=demo.getLang("erp","摘要")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><%=demo.getLang("erp","会计科目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","附件号码")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","行次")%></td>
</tr>
<%for(int i=1;i<a;i++){%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><input name="summary_content1" type="hidden" value="<%=summary_content1[i]%>" style="width:100%"><%=exchange.toHtml(summary_content1[i])%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><input name="selectb2" type="hidden" value="<%=exchange.toHtml(selectb2[i])%>" style="width:100%"><%=exchange.toHtml(selectb2[i])%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><input name="debit_subtotal1" type="hidden" value="<%=debit_subtotal1[i]%>" style="width:100%"><%=debit_subtotal1[i]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><input name="loan_subtotal1" type="hidden" value="<%=loan_subtotal1[i]%>" style="width:100%"><%=loan_subtotal1[i]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><input name="product_amount1" type="hidden" value="<%=product_amount1[i]%>" style="width:100%"><%=product_amount1[i]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><input name="attachment_ID1" type="hidden" value="<%=attachment_ID1[i]%>" style="width:100%"><%=attachment_ID1[i]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><input name="number_in_cash_table1" type="hidden" value="<%=number_in_cash_table1[i]%>" style="width:100%"><%=number_in_cash_table1[i]%></td>
 </tr>
<%}%>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><%=demo.getLang("erp","总计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"></td>	 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><input name="debit_sum" type="hidden" value="<%=debit_sum%>" style="width:100%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_sum)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><input name="loan_sum" type="hidden" value="<%=loan_sum%>" style="width:100%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_sum)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"></td>
 </tr>
</table>
</form>
<%@include file="../include/paper_bottom.html"%>
</div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>"> 
<%}
else{
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数量、借方金额、贷方金额必须是数字且库存商品数量不能为空，请返回确认！")%></td>
 </tr>
 </table>
</div>
<%}}else{%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","借贷不平衡，请返回确认！")%></td>
 </tr>
 </table>
</div>
<%}

}else{%> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","凭证号重复，请返回确认！")%></td>
 </tr>
 </table>
</div>
<%}}else{%> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","没有录入明细内容，请返回确认！")%></td>
 </tr>
 </table>
</div>
<%}}else{%> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有添加凭证明细，请返回确认！")%></td>
 </tr>
 </table>
</div>
<%}
finance_db.close();
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>