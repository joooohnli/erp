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
<%nseer_db finance_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="sum" scope="page" class="finance.Sum"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../../javascript/winopen/winopens.js"></script>
<script src="../../../javascript/table/movetable.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="100%";
try{
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","余额调节表")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="theObjTable">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="150"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","银行科目(账户)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","对账截止日期")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="190"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","单位账账面余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="190"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","对账单账面余额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="190"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","调整后存款余额")%></td>
 </tr>
<%
String file_id="";
String file_name="";
double last_balance=0.0d;
double last_balance1=0.0d;
double current_balance=0.0d;
double current_balance1=0.0d;
String account_init_time="";
String sql = "select type_name from finance_config_public_char where kind='账务初始时间'";
ResultSet rs = finance_db.executeQuery(sql) ;
if(rs.next()){
	account_init_time=rs.getString("type_name");   
}
sql = "select file_id,file_name from finance_config_file_kind where bank_tag='1' and details_tag='0' order by file_ID" ;
ResultSet rs1 = finance_db1.executeQuery(sql) ;
while(rs1.next()){
	file_name=rs1.getString("file_name");
	file_id=rs1.getString("file_id");
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=file_name%>(<%=file_id%>)</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%

sql = "select debit_subtotal from finance_voucher where chain_id='"+file_id+"' and account_period='18'" ;
	  rs = finance_db.executeQuery(sql) ;
if(rs.next()){
	last_balance=rs.getDouble("debit_subtotal");
}

sql = "select debit_subtotal,loan_subtotal from finance_voucher where chain_id='"+file_id+"' and register_time>='"+account_init_time+"' and account_tag='1'" ;
	  rs = finance_db.executeQuery(sql) ;
while(rs.next()){
	last_balance+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
}

%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=last_balance%></td>
<%

sql = "select debit_subtotal from finance_bill where file_id='"+file_id+"' and tag='1'" ;
	  rs = finance_db.executeQuery(sql) ;
if(rs.next()){
	last_balance1=rs.getDouble("debit_subtotal");
}

sql = "select debit_subtotal,loan_subtotal from finance_bill where file_id='"+file_id+"' and settle_time>='"+account_init_time+"'" ;
	  rs = finance_db.executeQuery(sql) ;
while(rs.next()){
	last_balance1+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
}

%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=last_balance1%></td>
<%
current_balance=last_balance;
sql = "select debit_subtotal,loan_subtotal from finance_bill where file_id='"+file_id+"' and checkup_tag='0' and tag!='1'" ;
rs = finance_db.executeQuery(sql) ;
while(rs.next()){
	current_balance+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
}

current_balance1=last_balance1;
sql = "select debit_subtotal,loan_subtotal from finance_voucher where chain_id='"+file_id+"' and checkup_tag='0' and (account_period='19' or account_tag='1')" ;
	  rs = finance_db.executeQuery(sql) ;
while(rs.next()){
	current_balance1+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
}

if(current_balance==current_balance1){
	%>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=current_balance%></td>
<%
}else{
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","不平衡")%></td>
<%}
%>
</tr> 
<%
last_balance=0.0d;
last_balance1=0.0d;
current_balance=0.0d;
current_balance1=0.0d;	
}
%>
</table>

<%@include file="../../include/paper_bottom.html"%> 
</div>
<%
finance_db.close();
finance_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>