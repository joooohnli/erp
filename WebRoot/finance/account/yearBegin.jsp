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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<%
String account_finished_finance_time="";
String sql="select * from finance_account_finished where account_finished_tag='1' order by id desc";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
	
account_finished_finance_time=rs.getString("account_finished_finance_time");
}
if(account_finished_finance_time.indexOf("-12")!=-1){
String year=account_finished_finance_time.substring(0,4);

String month=account_finished_finance_time.substring(5,7);
account_finished_finance_time=year+"年"+month+"月";

finance_db.close();

%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" width="70%">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3" width="70%"><%=demo.getLang("erp","对")%><%=account_finished_finance_time%><%=demo.getLang("erp","开始建账，您确认吗？")%></td>
 </tr>
</table>
	 <%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3" width="70%">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3" width="70%"><%=demo.getLang("erp","现在不能建账！")%></td>	
 </tr>
</table>
	<%}
	finance_db.close();

	%>
 </div>