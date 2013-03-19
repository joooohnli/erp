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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="100%";
try{
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String file_id=(String)session.getAttribute("file_id");
String file_name=(String)session.getAttribute("file_name");
String start_time="";
String end_time="";
String time_control="";
String month_control="";
double debit_year_sum=0.0d;
double loan_year_sum=0.0d;
double last_balance_sum=0.0d;
double current_balance_sum=0.0d;
double daily_balance_sum=0.0d;
double daily_debit_sum=0.0d;
double daily_loan_sum=0.0d;
double month_debit_sum=0.0d;
double month_loan_sum=0.0d;
int day_control=0;
int month_day_control=0;
if(file_id!=null){
	String sql="select debit_year_sum,loan_year_sum,current_balance_sum from finance_gl where file_ID='"+file_id+"' and account_period='1'";
	ResultSet rs=finance_db.executeQuery(sql);
	if(rs.next()){
		debit_year_sum=rs.getDouble("debit_year_sum");
		loan_year_sum=rs.getDouble("loan_year_sum");
		last_balance_sum=rs.getDouble("current_balance_sum");
	}
	sql="select start_time from finance_account_period where account_period='1'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		start_time=rs.getString("start_time");
	}
	sql="select end_time from finance_account_period where account_period='12'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		end_time=rs.getString("end_time");
	}
	if(timea.equals("")) timea=start_time;
	if(timeb.equals("")) timeb=end_time;
	String timec=timea.substring(0,7)+"-01";
	sql="select id from finance_voucher where chain_ID='"+file_id+"' and check_tag='1' and account_tag='1' and register_time<'"+timea+"' and register_time>='"+timec+"' order by register_time,voucher_in_month_ID";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		month_day_control++;
	}
	sql="select debit_subtotal,loan_subtotal from finance_voucher where chain_ID='"+file_id+"' and check_tag='1' and account_tag='1' and register_time<'"+timea+"' order by register_time,voucher_in_month_ID";
	rs=finance_db.executeQuery(sql);
	while(rs.next()){
		day_control++;
		debit_year_sum+=rs.getDouble("debit_subtotal");
		loan_year_sum+=rs.getDouble("loan_subtotal");
		last_balance_sum=last_balance_sum+rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
	}
	sql="select * from finance_voucher where chain_ID='"+file_id+"' and check_tag='1' and account_tag='1' and register_time>='"+timea+"' and register_time<='"+timeb+"' order by register_time,voucher_in_month_ID";
	rs=finance_db.executeQuery(sql);
	int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
	String strPage=request.getParameter("page");
	if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
		strPage="";
	}
	current_balance_sum=last_balance_sum;
%>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script src="../../javascript/table/movetable.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="daily_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=file_name%><%=demo.getLang("erp","分录总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 </table>

<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","日记账")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="50"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=timea.substring(0,4)%><%=demo.getLang("erp","年")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="180"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","摘要")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="120"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","对方科目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","借 方")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","贷 方")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="18"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","方向")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","余额")%></td>
 </tr>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="25"><%=demo.getLang("erp","月")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="25"><%=demo.getLang("erp","日")%></td>
 </tr>
<%
if(last_balance_sum!=0&&(day_control==0||month_day_control==0)){	
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","月初余额")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(last_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}else if(last_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}%>
</tr>
<%}else if(last_balance_sum!=0&&day_control!=0&&month_day_control!=0){%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","昨日余额")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(last_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}else if(last_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}%>
</tr>
<%}
	if(rs.next()){
	time_control=rs.getString("register_time");
	month_control=rs.getString("register_time").substring(5,7);
	%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("register_time").substring(5,7)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("register_time").substring(8)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("voucher_in_month_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("summary"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("chain_mate_id")%>&nbsp;</td>
 <%if(rs.getDouble("debit_subtotal")!=0){
	current_balance_sum+=rs.getDouble("debit_subtotal");
	daily_debit_sum+=rs.getDouble("debit_subtotal");
	month_debit_sum+=rs.getDouble("debit_subtotal");
	debit_year_sum+=rs.getDouble("debit_subtotal");
	%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%
		}else{
	current_balance_sum=current_balance_sum-rs.getDouble("loan_subtotal");
	daily_loan_sum+=rs.getDouble("loan_subtotal");
	month_loan_sum+=rs.getDouble("loan_subtotal");
	loan_year_sum+=rs.getDouble("loan_subtotal");
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>&nbsp;</td> 
 <%}%>
 <%if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
</tr>

<%
}
while(rs.next()){
	if(!time_control.equals(rs.getString("register_time"))){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=time_control.substring(5,7)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=time_control.substring(8)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本日合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(daily_debit_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(daily_debit_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(daily_loan_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(daily_loan_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 </tr>
<%
time_control=rs.getString("register_time");
daily_debit_sum=0;
daily_loan_sum=0;
}
if(!month_control.equals(rs.getString("register_time").substring(5,7))){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=month_control%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本月合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(month_debit_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(month_debit_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(month_loan_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(month_loan_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=month_control%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","累    计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(debit_year_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_year_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(loan_year_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_year_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 </tr>
<%
month_control=rs.getString("register_time").substring(5,7);
month_debit_sum=0;
month_loan_sum=0;
}	
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("register_time").substring(5,7)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("register_time").substring(8)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("voucher_in_month_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("summary"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("chain_mate_id")%>&nbsp;</td>
 <%if(rs.getDouble("debit_subtotal")!=0){
	current_balance_sum+=rs.getDouble("debit_subtotal");
	daily_debit_sum+=rs.getDouble("debit_subtotal");
	month_debit_sum+=rs.getDouble("debit_subtotal");
	debit_year_sum+=rs.getDouble("debit_subtotal");
	%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_subtotal"))%>&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%
		}else{
	current_balance_sum=current_balance_sum-rs.getDouble("loan_subtotal");
	daily_loan_sum+=rs.getDouble("loan_subtotal");
	month_loan_sum+=rs.getDouble("loan_subtotal");
	loan_year_sum+=rs.getDouble("loan_subtotal");
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_subtotal"))%>&nbsp;</td> 
 <%}%>
 <%if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
</tr>
<%}
if(!time_control.equals("")){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=time_control.substring(5,7)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=time_control.substring(8)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本日合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(daily_debit_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(daily_debit_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(daily_loan_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(daily_loan_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 </tr>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=time_control.substring(5,7)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","当前合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(month_debit_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(month_debit_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(month_loan_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(month_loan_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 </tr>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=time_control.substring(5,7)%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","当前累计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(debit_year_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_year_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(loan_year_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_year_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(current_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(current_balance_sum)%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 </tr>
<%}%>
</table>
<%@include file="../include/paper_bottom.html"%> 
</div>
<%
finance_db.close();
%>
<%}else{%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","请选择日记账科目！")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="daily_locate.jsp"></div></td>
 </tr>
 </table>
 </div>
<%}
}catch(Exception ex){ex.printStackTrace();}
%>