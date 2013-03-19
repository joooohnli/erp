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
String file_id=(String)session.getAttribute("file_id");
String file_name=(String)session.getAttribute("file_name");
String start_time="";
String end_time="";
String time_control="";
String[] month_control=new String[13];
String last_account_period="";
int start_account_period=0;
String account_finished_tag="";
String debit_or_loan="";
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
	String sql="select debit_or_loan from finance_config_file_kind where file_ID='"+file_id+"'";
	ResultSet rs=finance_db.executeQuery(sql);
	if(rs.next()){
		debit_or_loan=rs.getString("debit_or_loan");
	}
	sql="select type_name from finance_config_public_char where kind='账务初始时间'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		start_time=rs.getString("type_name");
	}
	sql="select account_period,end_time from finance_account_period order by account_period";
	rs=finance_db.executeQuery(sql);
	while(rs.next()){
		month_control[rs.getInt("account_period")]=rs.getString("end_time").substring(5,7);
	}
	sql="select account_period from finance_account_period where start_time<='"+start_time+"' and end_time>='"+start_time+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		start_account_period=rs.getInt("account_period");
	}
	sql="select last_year_balance_sum from finance_gl where account_period='"+start_account_period+"' and file_ID='"+file_id+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		last_balance_sum=rs.getDouble("last_year_balance_sum");
	}
	sql="select debit_year_sum,loan_year_sum from finance_gl where account_period<'"+start_account_period+"' and file_ID='"+file_id+"'";
	rs=finance_db.executeQuery(sql);
	while(rs.next()){
		debit_year_sum+=rs.getDouble("debit_year_sum");
		loan_year_sum+=rs.getDouble("loan_year_sum");
	}
	sql="select account_period from finance_account_period where account_finished_tag='0' order by account_period";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		last_account_period=rs.getString("account_period");
	}else{
		account_finished_tag="1";
		last_account_period="12";
	}
	
	sql="select * from finance_gl where file_ID='"+file_id+"' and (debit_year_sum!=0 or loan_year_sum!=0) and account_period>='"+start_account_period+"' order by account_period";
	rs=finance_db.executeQuery(sql);
	int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);	
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="firstKind_locate.jsp"></div></td>
 </tr>
 </table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=file_name%><%=demo.getLang("erp","总账")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="50"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=start_time.substring(0,4)%><%=demo.getLang("erp","年")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="60"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" rowspan="2" width="180"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","摘要")%></td>
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
if(start_account_period==1){	
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","上年结转")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(debit_or_loan.equals("借")){
	if(last_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}else if(last_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(last_balance_sum))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}
}else{
	if(last_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}else if(last_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(last_balance_sum))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}}%>
</tr>
<%}else{%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","期初余额")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td> 
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(debit_or_loan.equals("借")){
	if(last_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}else if(last_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(last_balance_sum))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}
}else{
	if(last_balance_sum>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(last_balance_sum)%></td>
 <%}else if(last_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(last_balance_sum))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
<%}}%>
</tr>
<%}
while(rs.next()){
	debit_year_sum+=rs.getDouble("debit_year_sum");
	loan_year_sum+=rs.getDouble("loan_year_sum");
if(!last_account_period.equals(rs.getString("account_period"))){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=month_control[rs.getInt("account_period")]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本月合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(rs.getDouble("debit_year_sum")!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_year_sum"))%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(rs.getDouble("loan_year_sum")!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_year_sum"))%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}
if(debit_or_loan.equals("借")){
if(rs.getDouble("current_balance_sum")>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("current_balance_sum"))%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(rs.getDouble("current_balance_sum")))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}
}else{
if(rs.getDouble("current_balance_sum")>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("current_balance_sum"))%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(rs.getDouble("current_balance_sum")))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}}%>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=month_control[rs.getInt("account_period")]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","累计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(debit_year_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(debit_year_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(loan_year_sum!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(loan_year_sum)%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 </tr>
<%
}else{	
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=month_control[rs.getInt("account_period")]%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","当前合计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <%if(rs.getDouble("debit_year_sum")!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_year_sum"))%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}if(rs.getDouble("loan_year_sum")!=0){%>
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_year_sum"))%>&nbsp;</td>
 <%}else{%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}
if(debit_or_loan.equals("借")){
if(rs.getDouble("current_balance_sum")>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("current_balance_sum"))%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(rs.getDouble("current_balance_sum")))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}
}else{
if(rs.getDouble("current_balance_sum")>0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","贷")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("current_balance_sum"))%></td>
 <%}else if(current_balance_sum<0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","借")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(Math.abs(rs.getDouble("current_balance_sum")))%></td>
 <%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","平")%></td> 
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 <%}}%>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=month_control[rs.getInt("account_period")]%></td>
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
 <%}%>
 <td <%=TD_STYLE6%> class="TD_STYLE6">&nbsp;</td>
 </tr>
<%}}%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
finance_db.close();
%>
<%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick=location="firstKind_locate.jsp" value="<%=demo.getLang("erp","返回")%>"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请正确选择会计期间！")%></td>
 </tr>
 </table>
 </div>
<%}
}catch(Exception ex){ex.printStackTrace();}
%>
