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
<%nseer_db_backup finance_db = new nseer_db_backup(application);%>
<%
String id=request.getParameter("id");
String voucher_id=request.getParameter("voucher_id");
String debit_subtotal=request.getParameter("debit_subtotal");
String loan_subtotal=request.getParameter("loan_subtotal");
try{
if(finance_db.conn((String)session.getAttribute("unit_db_name"))){	
	String sql="delete from finance_voucher_details where id='"+id+"'";
	finance_db.executeUpdate(sql) ;
	String sql2="select * from finance_voucher where id='"+voucher_id+"'";
	ResultSet rs2=finance_db.executeQuery(sql2);
	if(rs2.next()){
		double debit_sum=rs2.getDouble("debit_sum")-Double.parseDouble(debit_subtotal);
		double loan_sum=rs2.getDouble("loan_sum")-Double.parseDouble(loan_subtotal);
		String sql1="update finance_voucher set debit_sum='"+debit_sum+"',loan_sum='"+loan_sum+"',check_tag='0',change_tag='1' where id='"+voucher_id+"'";
	finance_db.executeUpdate(sql1) ;
	}
finance_db.close();
response.sendRedirect("change.jsp?id="+voucher_id+"");
}else{
%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
 <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="change.jsp?id=<%=voucher_id%>"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table>
 </div>
<%
}
	}
catch (Exception ex) {
		out.println("error"+ex);
	}
%>

